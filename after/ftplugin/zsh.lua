if vim.b.fvim_zsh_ftplugin_loaded then return end
vim.b.fvim_zsh_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")

if not vim.lsp.is_enabled("bashls") and vim.fn.executable("bash-language-server") == 1 then fvim.lsp.setup_server("bashls") end
