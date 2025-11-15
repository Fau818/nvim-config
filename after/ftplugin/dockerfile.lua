if vim.b.fvim_dockerfile_ftplugin_loaded then return end
vim.b.fvim_dockerfile_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/docker.lua")
