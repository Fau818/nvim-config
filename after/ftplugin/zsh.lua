vim.cmd.runtime("after/ftplugin/all.lua")

if not vim.lsp.is_enabled("bashls") and vim.fn.executable("bash-language-server") == 1 then fvim.lsp.setup_server("bashls") end
