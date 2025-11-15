if vim.b.fvim_html_ftplugin_loaded then return end
vim.b.fvim_html_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")
