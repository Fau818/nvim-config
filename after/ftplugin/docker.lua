if vim.b.fvim_docker_ftplugin_loaded then return end
vim.b.fvim_docker_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")
