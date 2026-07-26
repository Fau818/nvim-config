local M = {}


-- =============================================
-- ========== Helpers
-- =============================================

---Get conda installation path.
---@return string? conda_path
local function get_conda_path()
  local conda_path_list = {
    -- Universe
    os.getenv("CONDA_ROOT"),
    -- macOS
    "/usr/local/Caskroom/miniconda/base",
    "/opt/homebrew/Caskroom/miniconda/base",
    -- Linux
    "/usr/local/miniconda3",
    vim.fn.expand("$HOME/miniconda3"),
    vim.fn.expand("$HOME/.miniconda3"),
    vim.fn.expand("$HOME/.local/share/miniconda3"),
  }

  for _, path in ipairs(conda_path_list) do
    if path and vim.fn.isdirectory(path) == 1 then
      if vim.fn.executable(path .. "/bin/conda") == 1 then return path end
    end
  end

  fvim.notify("Conda path not found.", vim.log.levels.ERROR)
  return nil
end


---Build list of conda environments.
---@return snacks.picker.Item[]
local function build_conda_env_list()
  local conda_path = get_conda_path()
  if not conda_path then return {} end

  local conda_envs_path = conda_path .. "/envs"
  if vim.fn.isdirectory(conda_envs_path) ~= 1 then
    fvim.notify("Conda envs directory not found: " .. conda_envs_path, vim.log.levels.WARN)
    return {}
  end

  local env_list = { { name = "base", path = conda_path, idx = 1 } }
  for _, file in ipairs(vim.fn.readdir(conda_envs_path)) do
    if file:sub(1, 1) ~= "." then  -- Ignore hidden files
      local full_path = string.format("%s/%s", conda_envs_path, file)
      if vim.fn.isdirectory(full_path) == 1 then
        table.insert(env_list, { name = file, path = full_path, idx = #env_list + 1 })
      end
    end
  end

  return env_list
end


-- =============================================
-- ========== Conda Env Management
-- =============================================

local _conda_env_list = nil

---Get list of conda environments (cached).
---@return snacks.picker.Item[]
function M.get_conda_envs()
  if not _conda_env_list then _conda_env_list = build_conda_env_list() end
  return _conda_env_list
end


---Find a conda environment by name.
---@param name string
---@return snacks.picker.Item?
function M.find_env(name)
  for _, item in ipairs(M.get_conda_envs()) do
    if item.name == name then return item end
  end
end


---Activate conda environment. Deactivates whatever else is currently active
---first, so switching directly between two envs doesn't leave the old one's
---bin dir stuck in PATH and CONDA_SHLVL climbing forever.
---@param item snacks.picker.Item
function M.activate(item)
  local cur_name = os.getenv("CONDA_DEFAULT_ENV")
  local cur_prefix = os.getenv("CONDA_PREFIX")
  if cur_prefix and cur_name and cur_name ~= "" and cur_name ~= "base" and cur_name ~= item.name then
    M.deactivate({ path = cur_prefix })
  end

  fvim.notify("Activating conda environment: " .. item.name, vim.log.levels.INFO)

  local shlvl = tonumber(os.getenv("CONDA_SHLVL")) or 0

  vim.fn.setenv("CONDA_DEFAULT_ENV", item.name)
  vim.fn.setenv("CONDA_PREFIX",      item.path)
  vim.fn.setenv("CONDA_SHLVL",       tostring(shlvl + 1))
  vim.env.PATH = string.format("%s/bin:%s", item.path, vim.env.PATH)
end


---Deactivate the current conda environment.
---@param item snacks.picker.Item
function M.deactivate(item)
  fvim.notify("Deactivating conda environment.", vim.log.levels.INFO)

  local shlvl = tonumber(os.getenv("CONDA_SHLVL")) or 1

  vim.fn.setenv("CONDA_DEFAULT_ENV", nil)
  vim.fn.setenv("CONDA_PREFIX", nil)
  vim.fn.setenv("CONDA_SHLVL",  tostring(math.max(shlvl - 1, 0)))
  vim.env.PATH = vim.env.PATH:gsub(vim.pesc(item.path .. "/bin:"), "")
end


-- =============================================
-- ========== Auto-Env (cwd-based)
-- =============================================

-- Shared with `zsh/plugins/conda_auto_env.zsh` via `$CONDA_AUTO_ENVS_CONF` (set in
-- `.zshenv`), so nvim gets the right env even when opened without `cd`ing there
-- first. Only plain directory prefixes are supported; the zsh side also allows globs.
local CONF_PATH = os.getenv("CONDA_AUTO_ENVS_CONF")

---@type {pattern: string, env: string}[]?
local mappings

---@return {pattern: string, env: string}[]
local function load_mappings()
  local result = {}
  if not CONF_PATH or vim.fn.filereadable(CONF_PATH) ~= 1 then return result end
  for _, line in ipairs(vim.fn.readfile(CONF_PATH)) do
    line = line:gsub("#.*$", ""):match("^%s*(.-)%s*$")
    local pattern, env = line:match("^(%S+)%s+(%S+)$")
    if pattern and env then table.insert(result, { pattern = vim.fn.expand(pattern), env = env }) end
  end
  return result
end

---Env mapped to the longest pattern matching `path`, or nil.
---@param path string
---@return string?
local function lookup(path)
  mappings = mappings or load_mappings()
  local best, best_env
  for _, m in ipairs(mappings) do
    if path == m.pattern or vim.startswith(path, m.pattern .. "/") then
      if not best or #m.pattern > #best then best, best_env = m.pattern, m.env end
    end
  end
  return best_env
end

local active = nil  -- env we auto-activated, mirrors the zsh plugin's _CAE_ACTIVE

local function auto_activate(name)
  local item = M.find_env(name)
  if not item then fvim.notify("conda_auto_env: env not found: " .. name, vim.log.levels.WARN) return end
  M.activate(item)
  active = name
end

local function auto_deactivate(name)
  local item = M.find_env(name)
  if item then M.deactivate(item) end
  active = nil
end


---Python interpreter path for the env mapped to `dir`, or nil. Independent of the globally "active" env.
---@param dir string
---@return string?
function M.python_path_for(dir)
  local item = M.find_env(lookup(dir))
  return item and (item.path .. "/bin/python") or nil
end

---Re-evaluate the cwd against the mapping and (de)activate as needed. Mirrors
---`_cae_chpwd` in the zsh plugin; never touches a manually-selected env.
function M.check()
  local cur = os.getenv("CONDA_DEFAULT_ENV")
  local target = lookup(vim.fn.getcwd())

  -- Adopt an inherited env matching this cwd (e.g. auto-activated by zsh before
  -- nvim started) as ours, so later cwd changes can still switch away from it.
  if not active and target and target == cur then active = target end

  local not_active = not cur or cur == "" or cur == "base"
  local is_managed = cur == active
  if target and target ~= cur then
    if not_active or is_managed then auto_activate(target) end
  elseif not target and active then
    if is_managed then auto_deactivate(active) else active = nil end  -- else: env changed manually; stop tracking it
  end
end


return M
