vim.cmd.runtime("after/ftplugin/all.lua")

-- Set indent
vim.opt_local.tabstop     = 2
vim.opt_local.softtabstop = -1
vim.opt_local.shiftwidth  = 0

-- LSP settings
Fau_vim.lsp.packages.python = { "pylance", "ruff" }
if not vim.lsp.is_enabled("pylance") and vim.fn.executable("pylance") == 1 then Fau_vim.lsp.setup_server("pylance") end
