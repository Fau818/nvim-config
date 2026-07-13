-- IMPORTANT: If use `vim.schedule` to set buffer-local options in a ftplugin,
-- make sure to capture the buffer number first since the current buffer might have changed by the time the schedule runs.

if not vim.g.vscode then
  -- NOTE: Capture the buffer now; the current buffer may have changed by the time the schedule runs.
  local bufnr = vim.api.nvim_get_current_buf()
  vim.schedule(function() if vim.api.nvim_buf_is_valid(bufnr) then vim.bo[bufnr].formatoptions = "tcqj" end end)
else vim.opt_local.formatoptions = "tcqj"
end
