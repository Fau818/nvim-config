local M = {}

M.conda = require("fau.functions.conda")


-- ════════════════════════════════════════════════════════════
-- ══════════════════════ Library Files ═══════════════════════
-- ════════════════════════════════════════════════════════════

---Dirs marking a file as third-party/stdlib source.
local library_patterns = {
  "^(.*/site%-packages)/", "^(.*/dist%-packages)/", "^(.*/lib/python%d+%.%d+)/",
  "^(.*/typeshed%-fallback)/", "^(.*/python%-type%-stubs)/",
}

---Determine if the specified buffer holds someone else's code.
---@param bufnr? integer Default is the current buffer.
---@return string? library_root The library root containing the file, or nil for project code.
function M.library_root(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then return end

  local path = vim.api.nvim_buf_get_name(bufnr)
  for _, pattern in ipairs(library_patterns) do
    local library_root = path:match(pattern)
    if library_root then return library_root end
  end
end


-- ════════════════════════════════════════════════════════════
-- ═══════════════════════ Interpreter ════════════════════════
-- ════════════════════════════════════════════════════════════

---Venv dir names to look for, in priority order.
local venv_names = { ".venv", "venv.nosync", "venv" }

---Find the interpreter under `root_dir`, trying each `venv_names` entry in order.
---@param root_dir string
---@return string? python_bin The interpreter of the first venv that has one, or nil if none does.
local function find_venv_python(root_dir)
  for _, name in ipairs(venv_names) do
    local python_bin = vim.fs.joinpath(root_dir, name, "bin", "python")
    if vim.fn.executable(python_bin) == 1 then return python_bin end
  end
end


---Decide which interpreter a python project should use, first match wins:
---  1. a conda env you selected yourself
---  2. the conda env `$CONDA_AUTO_ENVS_CONF` maps `root_dir` to
---  3. a venv under `root_dir`
---@param root_dir string
---@return string? python_path nil hands the choice back to the server, i.e. `python3` on PATH.
---@return string? shadowed_venv The local venv a conda env is overriding, if both are present.
function M.resolve_path(root_dir)
  local venv_python = find_venv_python(root_dir)
  -- EXIT: No conda on this machine, so there is nothing that could outrank the venv.
  if vim.fn.executable("conda") ~= 1 then return venv_python end

  local conda_python = M.conda.get_manual_python_path() or M.conda.get_mapped_python_path(root_dir)
  if not conda_python then return venv_python end

  return conda_python, venv_python ~= conda_python and venv_python or nil
end


---Point a running client at `python_path`, without restarting it.
---@param client vim.lsp.Client
---@param python_path string? nil restores the server's own auto-detection.
local function reconfigure_path(client, python_path)
  local settings = client.settings
  settings.python = settings.python or {}
  settings.python.pythonPath = python_path
  client:notify("workspace/didChangeConfiguration", { settings = nil })
end


---Re-run `resolve_path` for a buffer's python clients. Call it after changing the conda env by hand:
---`conda.activate`/`deactivate` stay out of this, so a cwd-driven switch cannot move a settled client.
---@param bufnr? integer Default is the current buffer.
function M.resync_path(bufnr)
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr or 0 })) do
    local root_dir = client.config.root_dir
    if root_dir and client.settings.python then reconfigure_path(client, M.resolve_path(root_dir)) end
  end
end


return M
