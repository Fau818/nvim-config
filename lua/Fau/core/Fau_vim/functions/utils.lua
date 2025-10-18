local M = {}

---Simulate pressing `keys` in `mode` mode.
---@param mode string
---@param keys string
function M.feedkeys(mode, keys)
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(keys, true, true, true),
    mode,
    false
  )
end


---@type fun(bufnr?: number)
M._buf_remove = nil

---Delete the specified buffer.
---@param bufnr integer Default is the current buffer.
function M.buf_remove(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- NOTE: The `checkhealth` will open a new tab, so just use `:bd` to close it.
  if vim.bo[bufnr].filetype == "checkhealth" then vim.api.nvim_command("bd " .. bufnr) return end

  -- Try to use the provided function to delete buffer.
  if M._buf_remove == nil or not pcall(M._buf_remove, bufnr) then
    vim.api.nvim_command("bd " .. bufnr)
  end
end


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

  vim.b[bufnr].is_large_file = file_status.size >= Fau_vim.file.large_file_size
  return vim.b[bufnr].is_large_file
end


function M.reveal_in_system(path)
  local file = path or vim.fn.expand("%:p")
  if vim.fn.has("mac") == 1 then vim.fn.system({ "open", "-R", file })
  elseif vim.fn.has("win32") == 1 then vim.fn.system({"explorer", "/select,", file})
  else vim.ui.open(vim.fn.expand("%:p:h"))
  end
end


---If there is no line crossing when selecting in Visual-Block mode, switch to Visual mode.
---This is useful to trim trailing line break when yanking some text in Visual-Block mode.
function M.smart_visual_mode()
  local mode = vim.fn.mode()

  if mode == "\22" then
    local start_row, end_row = vim.fn.getpos("v")[2], vim.fn.getpos(".")[2]
    -- vim.notify(string.format("mode: %s start_row: %d, end_row: %d", mode, start_row, end_row))
    if start_row == end_row then Fau_vim.functions.utils.feedkeys("x", "v") end
  end
end

return M
