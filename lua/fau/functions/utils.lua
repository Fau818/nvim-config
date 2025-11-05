local M = {}

-- =============================================
-- ========== Feedkeys
-- =============================================
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


-- =============================================
-- ========== Buffer Remove
-- =============================================
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
-- ========== Reveal in System
-- =============================================
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
function M.smart_visual_mode()
  local mode = vim.fn.mode()
  if mode == "\22" then
    local start_row, end_row = vim.fn.getpos("v")[2], vim.fn.getpos(".")[2]
    if start_row == end_row then fvim.utils.feedkeys("x", "v") end
  end
end


-- =============================================
-- ========== Fallback Mapping
-- =============================================
---Get the global mapping for the specified key in the specified mode.
---@param mode string
---@param key string
---@return vim.api.keyset.get_keymap|nil mapping
local function get_global_mapping_for_key(mode, key)
  -- REF: https://github.com/saghen/blink.cmp/blob/2408f14f740f89d603cad33fe8cbd92ab068cc92/lua/blink/cmp/keymap/fallback.lua#L15
  local normalized_key = vim.api.nvim_replace_termcodes(key, true, true, true)
  local mappings = vim.api.nvim_get_keymap(mode)
  for _, mapping in ipairs(mappings) do
    local mapping_key = vim.api.nvim_replace_termcodes(mapping.lhs, true, true, true)
    if mapping_key == normalized_key then return mapping end
  end

  -- vim.notify("Fallback mapping not found for key: " .. key .. " in mode: " .. mode, vim.log.levels.WARN)
  return nil
end


---Execute the fallback mapping.
---@param mapping vim.api.keyset.get_keymap
---@return nil
local function run_fallback_mapping(mapping)
  if mapping == nil then vim.notify("Fallback mapping is nil.", vim.log.levels.ERROR); return end

  -- REF: https://github.com/saghen/blink.cmp/blob/2408f14f740f89d603cad33fe8cbd92ab068cc92/lua/blink/cmp/keymap/fallback.lua#L64
  if type(mapping.callback) == "function" then
    vim.schedule(mapping.callback)
    return nil
  elseif mapping.rhs then
    local rhs = mapping.rhs
    if mapping.expr == 1 then
      vim.notify("Expr rhs mappings are not tested yet.", vim.log.levels.ERROR)
      assert(false, "PLEASE TEST ME!!!")
      -- rhs = vim.api.nvim_replace_termcodes(mapping.rhs, true, true, true)
      -- rhs = vim.api.nvim_eval(rhs)
    end

    if type(rhs) == "string" then
      M.feedkeys(mapping.mode, rhs)
      return nil
    else
      vim.notify("Fallback mapping rhs is not a string.", vim.log.levels.ERROR)
      assert(false, "PLEASE TEST ME!!!")
    end
  end

  vim.notify("Fallback mappings without rhs or callback are not tested yet.", vim.log.levels.ERROR)
  assert(false, "PLEASE TEST ME!!!")
  -- pass the key along as usual
  -- return vim.api.nvim_replace_termcodes(key, true, true, false)
end


---Create a fallback warp function for the specified key in the specified mode.
---@param mode string
---@param key string
---@return fun()
function M.fallback_warp(mode, key)
  local mapping = get_global_mapping_for_key(mode, key)
  return function() if mapping then run_fallback_mapping(mapping) end end
end


return M
