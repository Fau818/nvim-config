if vim.b.fvim_jsonc_ftplugin_loaded then return end
vim.b.fvim_jsonc_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/json.lua")
