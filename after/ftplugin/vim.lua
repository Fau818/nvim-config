if vim.b.fvim_vim_ftplugin_loaded then return end
vim.b.fvim_vim_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")
