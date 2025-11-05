local M = {}


-- ==================== TodoSign Highlights Namespace ====================
local todo_sign_hl_ns_id = vim.api.nvim_create_namespace("todo_signs_hl")
vim.api.nvim_set_hl(todo_sign_hl_ns_id, "@comment", { bold = true, italic = true })

---@param win_id? number -- Window ID, default: 0 (current window)
function M.set_todo_sign_hl_ns(win_id)
  win_id = win_id or 0
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.api.nvim_win_set_hl_ns(win_id, todo_sign_hl_ns_id)
end


return M
