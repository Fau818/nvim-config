-- NOTE: If set `fvim_lua_ftplugin_loaded` will break `formatoptions` settings.
-- if vim.b.fvim_lua_ftplugin_loaded then return end
-- vim.b.fvim_lua_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")
