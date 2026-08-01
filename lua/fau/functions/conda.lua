local M = {}

---@class fvim.CondaEnv
---@field name string Conda env name; `base` for the installation root itself.
---@field path string Conda env prefix, i.e. the dir holding `bin/python`.
---@field idx? integer Position in the list, which the picker orders by.


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
      if vim.fn.executable(vim.fs.joinpath(path, "bin/conda")) == 1 then return path end
    end
  end

  fvim.notify("Conda path not found.", vim.log.levels.ERROR)
  return nil
end


---Build list of conda environments.
---@return fvim.CondaEnv[]
local function build_conda_env_list()
  local conda_path = get_conda_path()
  if not conda_path then return {} end

  local conda_envs_path = vim.fs.joinpath(conda_path, "envs")
  if vim.fn.isdirectory(conda_envs_path) ~= 1 then
    fvim.notify("Conda envs directory not found: " .. conda_envs_path, vim.log.levels.WARN)
    return {}
  end

  local env_list = { { name = "base", path = conda_path, idx = 1 } }
  for _, file in ipairs(vim.fn.readdir(conda_envs_path)) do
    if file:sub(1, 1) ~= "." then  -- Ignore hidden files
      local full_path = vim.fs.joinpath(conda_envs_path, file)
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
---@return fvim.CondaEnv[]
function M.get_conda_envs()
  if not _conda_env_list then _conda_env_list = build_conda_env_list() end
  return _conda_env_list
end


---Find a conda environment by name.
---@param name string
---@return fvim.CondaEnv?
local function find_env(name)
  for _, item in ipairs(M.get_conda_envs()) do
    if item.name == name then return item end
  end
end


---Activate a conda environment, deactivating the current one first; switching straight
---from one to another would leave the old bin dir in PATH and let CONDA_SHLVL climb forever.
---@param item fvim.CondaEnv
function M.activate(item)
  local cur_name = os.getenv("CONDA_DEFAULT_ENV")
  local cur_prefix = os.getenv("CONDA_PREFIX")
  if cur_prefix and cur_name and cur_name ~= "" and cur_name ~= "base" and cur_name ~= item.name then
    M.deactivate({ name = cur_name, path = cur_prefix })
  end

  fvim.notify("Activating conda environment: " .. item.name, vim.log.levels.INFO)

  local shlvl = tonumber(os.getenv("CONDA_SHLVL")) or 0

  vim.fn.setenv("CONDA_DEFAULT_ENV", item.name)
  vim.fn.setenv("CONDA_PREFIX",      item.path)
  vim.fn.setenv("CONDA_SHLVL",       tostring(shlvl + 1))
  vim.env.PATH = string.format("%s/bin:%s", item.path, vim.env.PATH)
end


---Deactivate `item`, which has to be the env that is currently active.
---@param item fvim.CondaEnv
function M.deactivate(item)
  local cur_name = os.getenv("CONDA_DEFAULT_ENV")
  if cur_name ~= item.name then
    fvim.notify(("Not deactivating %s: %s is active."):format(item.name, cur_name or "no env"), vim.log.levels.WARN)
    return
  end

  fvim.notify("Deactivating conda environment: " .. item.name, vim.log.levels.INFO)

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
  local item = find_env(name)
  if not item then fvim.notify("conda_auto_env: env not found: " .. name, vim.log.levels.WARN) return end
  M.activate(item)
  active = name
end


local function auto_deactivate(name)
  local item = find_env(name)
  if item then M.deactivate(item) end
  active = nil
end


---Get the interpreter path of the env `$CONDA_AUTO_ENVS_CONF` maps `dir` to, or nil.
---Independent of whichever env happens to be active.
---@param dir string
---@return string?
function M.get_mapped_python_path(dir)
  local name = lookup(dir)
  -- EXIT: This dir is not in the map, so no env is pinned to it.
  if not name then return end

  local item = find_env(name)
  return item and vim.fs.joinpath(item.path, "bin/python") or nil
end


---Get the interpreter path of an env you selected yourself, or nil. `base` and an env `check()`
---auto-activated for the cwd doesn't count: neither is a decision, so a root's map may outrank them.
---@return string?
function M.get_manual_python_path()
  local name = os.getenv("CONDA_DEFAULT_ENV")
  local prefix = os.getenv("CONDA_PREFIX")
  if not prefix or not name or name == "" or name == "base" or name == active then return end

  local python_path = vim.fs.joinpath(prefix, "bin/python")
  return vim.fn.executable(python_path) == 1 and python_path or nil
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
