-- ==================== Filetype ====================
vim.g.python_recommended_style = 0

-- ==================== Basic ====================
fvim.nvim_config_path = vim.fn.stdpath("config")
fvim.xdg_config_home  = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")

fvim.kitty = require("fau.config.kitty")

-- ==================== General ====================
fvim.colors   = require("fau.config.colors")
fvim.file     = require("fau.config.file")
fvim.icons    = require("fau.config.icons")
fvim.settings = require("fau.config.settings")

-- ==================== LSP ====================
fvim.diagnositcs = require("fau.config.diagnostic")
fvim.lsp = require("fau.config.lsp")

-- ==================== Setup ====================
fvim.diagnositcs.setup()
