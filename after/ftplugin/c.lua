vim.cmd.runtime("after/ftplugin/all.lua")
if not vim.lsp.is_enabled("clangd") and vim.fn.executable("clangd") == 1 then fvim.lsp.setup_server("clangd") end
