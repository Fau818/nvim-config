if vim.b.fvim_python_ftplugin_loaded then return end
vim.b.fvim_python_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")

-- Set indent
vim.bo.tabstop     = 2
vim.bo.softtabstop = -1
vim.bo.shiftwidth  = 0

-- LSP setup
-- if not vim.lsp.is_enabled("fylance") and vim.fn.executable("fylance") == 1 then fvim.lsp.setup_server("fylance") end
