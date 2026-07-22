if vim.b.fvim_python_ftplugin_loaded then return end
vim.b.fvim_python_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")

-- TEST: Prevent autoindent.
local bufnr = vim.api.nvim_get_current_buf()
vim.schedule(function()
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  vim.api.nvim_buf_call(bufnr, function() vim.opt_local.indentkeys:remove({ "o", "O" }) end)
end)
