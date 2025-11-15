local M = {}


---Toggle indent width between 2 and 4.
function M.toggle_indent_width()
  local new_width = vim.bo.tabstop == 2 and 4 or 2
  vim.bo.shiftwidth = 0; vim.bo.softtabstop = -1
  if vim.bo.expandtab then vim.bo.expandtab = false; vim.cmd("retab!") end
  vim.bo.tabstop = new_width
  if vim.bo.expandtab == false then vim.bo.expandtab = true; vim.cmd("retab") end
end


return M
