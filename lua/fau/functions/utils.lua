local M = {}

-- =============================================
-- ========== Feedkeys
-- =============================================
---Simulate pressing `keys` in noremap mode (asynchronously).
---@param keys string
function M.feedkeys(keys) vim.api.nvim_feedkeys(vim.keycode(keys), "n", false) end


-- =============================================
-- ========== Buffer Remove
-- =============================================
---@type fun(bufnr?: number)
M._buf_remove = nil

---Dismiss a transient diff view (window + buffer), returning true if one was closed.
---Registered by the diff provider — see `lua/fau/plugins/editor/gitsigns.lua`.
---@type fun(): boolean?
M._diff_dismiss = nil

---Delete the specified buffer.
---@param bufnr integer Default is the current buffer.
function M.buf_remove(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then fvim.notify("Buffer " .. bufnr .. " is not valid.", vim.log.levels.ERROR) return end

  -- CASE1: `checkhealth` opens in a new tab; bypass the custom handler and wipe directly.
  if vim.bo[bufnr].filetype == "checkhealth" then vim.api.nvim_buf_delete(bufnr, { force = false }) return end

  -- CASE2: In a diff view (e.g. gitsigns diffthis), dismiss the transient diff instead of closing the real file.
  if vim.wo.diff and M._diff_dismiss and M._diff_dismiss() then return end

  -- Try to use the provided function to delete buffer.
  if M._buf_remove == nil or not pcall(M._buf_remove, bufnr) then vim.api.nvim_buf_delete(bufnr, { force = false }) end
end


-- =============================================
-- ========== Large File Detection
-- =============================================
---Determine if the specified buffer is a large file.
---@param bufnr? integer Default is the current buffer.
---@return boolean flag True if the buffer is a large file, otherwise false.
function M.is_large_file(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- EXIT: Not a regular buffer.
  if vim.bo[bufnr].buftype ~= "" then return false end
  -- EXIT: `bigfile` filetype always a large file.
  if vim.bo[bufnr].filetype == "bigfile" then return true end
  -- EXIT: Use the cached result.
  if vim.b[bufnr].is_large_file ~= nil then return vim.b[bufnr].is_large_file end

  -- Get file status.
  local status_ok, file_status = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
  -- EXIT: Get the status of file error. => Not a large file (E.g., a new buffer)
  if not status_ok or not file_status then return false end

  vim.b[bufnr].is_large_file = file_status.size >= fvim.file.large_file_size
  return vim.b[bufnr].is_large_file
end


-- =============================================
-- ========== Python Library Files
-- =============================================
---Dirs marking a file as third-party/stdlib source.
local python_library_patterns = {
  "^(.*/site%-packages)/", "^(.*/dist%-packages)/", "^(.*/lib/python%d+%.%d+)/",
  "^(.*/typeshed%-fallback)/", "^(.*/python%-type%-stubs)/",
}

---Determine if the specified buffer holds someone else's code.
---@param bufnr? integer Default is the current buffer.
---@return string? library_root The library root containing the file, or nil for project code.
function M.python_library_root(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(bufnr) then return end

  local path = vim.api.nvim_buf_get_name(bufnr)
  for _, pattern in ipairs(python_library_patterns) do
    local library_root = path:match(pattern)
    if library_root then return library_root end
  end
end


-- =============================================
-- ========== Python Venv
-- =============================================
---Venv dir names to look for, in priority order.
local venv_names = { ".venv", "venv.nosync", "venv" }

---Find the interpreter under `root_dir`, trying each `venv_names` entry in order.
---@param root_dir string
---@return string? python_bin The interpreter of the first venv that has one, or nil if none does.
function M.find_venv_python(root_dir)
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
function M.resolve_python_path(root_dir)
  local venv_python = M.find_venv_python(root_dir)
  -- EXIT: No conda on this machine, so there is nothing that could outrank the venv.
  if vim.fn.executable("conda") ~= 1 then return venv_python end

  local conda_python = M.conda.get_manual_python_path() or M.conda.python_path_for(root_dir)
  if not conda_python then return venv_python end

  return conda_python, venv_python ~= conda_python and venv_python or nil
end


-- =============================================
-- ========== Reveal in System
-- =============================================
---Reveal a file in the system's file manager.
---@param path? string The file path to reveal. If nil, the current buffer's path is used.
function M.reveal_in_system(path)
  local file = path or vim.fn.expand("%:p")
  if vim.fn.has("mac") == 1 then vim.fn.system({ "open", "-R", file })
  elseif vim.fn.has("win32") == 1 then vim.fn.system({"explorer", "/select,", file})
  else vim.ui.open(vim.fn.expand("%:p:h"))
  end
end


-- =============================================
-- ========== Smart Visual Mode
-- =============================================
---If there is no line crossing when selecting in Visual-Block mode, switch to Visual mode.
---This is useful to trim line break when yanking in Visual-Block mode.
---E.g., when you are in normal mode and press `vg_`, although you didn't copy the line break, the macOS clipboard will
---still add a line break at the end. This function can help avoid this issue.
function M.smart_visual_mode()
  local mode = vim.fn.mode()
  if mode == "\22" then
    local start_row, end_row = vim.fn.getpos("v")[2], vim.fn.getpos(".")[2]
    if start_row == end_row then vim.api.nvim_command("normal! v") end
  end
end


-- =============================================
-- ========== Fallback Mapping
-- =============================================
---Capture the current mapping for `mode`+`key` and return a closure that invokes it.
---If no mapping exists, the closure feeds the original key with the no-remap flag, falling through to vim's built-in behavior.
---@param mode string
---@param key string
---@return fun()
function M.keymap_fallback_wrapper(mode, key)
  local mapping = vim.fn.maparg(key, mode, false, true)

  return function()
    -- CASE1: No prior mapping → feed original key with no-remap, fall through to vim's built-in.
    if vim.tbl_isempty(mapping) then M.feedkeys(key); return end

    local is_expr = mapping.expr == 1

    -- CASE2: Non-expr callback → call it
    if mapping.callback and not is_expr then vim.schedule(mapping.callback); return end

    -- CASE3: Resolve to a key string -> then feed it.
    --   expr callback -> call it (returns the string)
    --   expr rhs      -> eval the expression
    --   plain rhs     -> use as-is
    local key
    if mapping.callback then key = mapping.callback()
    elseif is_expr then key = vim.api.nvim_eval(mapping.rhs)
    else key = mapping.rhs
    end

    if type(key) == "string" then M.feedkeys(key) end
  end
end


-- =============================================
-- ========== Backdrop
-- =============================================
---Creates a semi-transparent backdrop window behind the specified parent window.
---@param parent integer A valid window ID to anchor the backdrop to.
---@param opts? table Options for the backdrop. Supported keys: `blend` (number, default 60) and `bg` (string, default `fvim.colors.bg`).
function M.backdrop(parent, opts)
  local DEFAULT_OPTS = { blend = 60, bg = fvim.colors.bg }
  local BACKDROP_NAME = "FauBackdrop"
  local DEFAULT_INDEX = 50

  opts = vim.tbl_deep_extend("force", DEFAULT_OPTS, opts or {})

  if not vim.o.termguicolors or opts.blend >= 100 then return end
  if not vim.api.nvim_win_is_valid(parent) then return end

  vim.api.nvim_set_hl(0, BACKDROP_NAME, { bg = opts.bg })

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"

  local win = vim.api.nvim_open_win(buf, false, {
    relative = "editor", row = 0, col = 0,
    width = vim.o.columns, height = vim.o.lines,
    focusable = false,
    style = "minimal",
    zindex = (vim.api.nvim_win_get_config(parent).zindex or DEFAULT_INDEX) - 1,
  })

  vim.wo[win].winhighlight = "Normal:FauBackdrop"
  vim.wo[win].winblend = opts.blend

  local function close()
    pcall(vim.api.nvim_win_close, win, true)
    pcall(vim.api.nvim_buf_delete, buf, true)
  end

  vim.api.nvim_create_autocmd({ "WinClosed", "WinEnter" }, {
    callback = function(event)
      local parent_alive = vim.api.nvim_win_is_valid(parent)
          and not vim.api.nvim_win_get_config(parent).hide
          and not (event.event == "WinClosed" and event.match == tostring(parent))

      if parent_alive then return end

      close()
      return true  -- NOTE: Remove the autocmd.
    end,
  })
end


-- =============================================
-- ========== Window
-- =============================================
---Find the first "main" window in the current tabpage: non-floating and showing a regular buffer.
---@param filter? fun(win: integer): boolean Extra acceptance test; the window is kept only if it returns true.
---@return integer? win The matching window id, or nil if none qualifies.
function M.get_main_win(filter)
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(w).relative == ""
      and vim.bo[vim.api.nvim_win_get_buf(w)].buftype == ""
      and (not filter or filter(w)) then
      return w
    end
  end
end


return M
