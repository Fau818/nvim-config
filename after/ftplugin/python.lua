if vim.b.fvim_python_ftplugin_loaded then return end
vim.b.fvim_python_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")

-- Set indent
vim.bo.tabstop     = 2
vim.bo.softtabstop = -1
vim.bo.shiftwidth  = 0

-- TEST: Prevent autoindent.
vim.schedule(function() vim.opt_local.indentkeys:remove({ "o", "O" }) end)
