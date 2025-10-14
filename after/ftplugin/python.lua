vim.cmd.runtime("after/ftplugin/all.lua")

-- Set indent
vim.opt_local.tabstop     = 2
vim.opt_local.softtabstop = -1
vim.opt_local.shiftwidth  = 0

-- LSP settings
Fau_vim.lsp.packages.python = { "pylance", "ruff" }
if vim.fn.executable("pylance") == 1 then Fau_vim.functions.lsp.setup_server("pylance") end
