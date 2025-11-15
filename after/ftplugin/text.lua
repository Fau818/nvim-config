if vim.b.fvim_text_ftplugin_loaded then return end
vim.b.fvim_text_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/markdown.lua")
