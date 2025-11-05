-- BUG: "axelvc/template-string.nvim" will lead to load twice when the first time to open a python file.
-- HACK: Add protection here.
if vim.b.fvim_python_ftplugin_loaded then return end
vim.b.fvim_python_ftplugin_loaded = true

vim.cmd.runtime("after/ftplugin/all.lua")

-- Set indent
vim.opt_local.tabstop     = 2
vim.opt_local.softtabstop = -1
vim.opt_local.shiftwidth  = 0

-- LSP setup
if not vim.lsp.is_enabled("fylance") and vim.fn.executable("fylance") == 1 then fvim.lsp.setup_server("fylance") end

-- Set TodoSign highlights namespace.
if vim.bo.buftype == "" then fvim.colorscheme.set_todo_sign_hl_ns() end
