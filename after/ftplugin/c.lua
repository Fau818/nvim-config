if vim.b.fvim_c_ftplugin_loaded then return end
vim.b.fvim_c_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")
if not vim.lsp.is_enabled("clangd") and vim.fn.executable("clangd") == 1 then fvim.lsp.setup_server("clangd") end
