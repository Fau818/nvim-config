-- =============================================
-- ========== Initialization
-- =============================================
require "Fau.core.Fau_vim.options"
require "Fau.core.Fau_vim.keymaps"
require "Fau.core.Fau_vim.config"



-- =============================================
-- ========== Extension
-- =============================================
Fau_vim.icons     = require "Fau.core.Fau_vim.icons"
Fau_vim.functions = require "Fau.core.Fau_vim.functions"
Fau_vim.colors    = require "Fau.core.Fau_vim.colors"

-- Fau_vim.file_indent = require "Fau.core.Fau_vim.file_indent"



-- =============================================
-- ========== Extra
-- =============================================
require "Fau.core.Fau_vim.commands"
require "Fau.core.Fau_vim.autocmd"



-- =============================================
-- ========== Startup Neovim
-- =============================================
require "Fau.lazy"
