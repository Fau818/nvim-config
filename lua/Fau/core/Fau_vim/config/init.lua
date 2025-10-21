-- ==================== Basic ====================
Fau_vim.colorscheme = "habamax"  -- Default colorscheme
Fau_vim.config_path = vim.fn.stdpath("config")
Fau_vim.xdg_config_home = os.getenv("XDG_CONFIG_HOME") or vim.fn.expand("~/.config")
Fau_vim.os_name = vim.fn.system("uname"):gsub("\n", "")


-- ==================== General ====================
Fau_vim.icons    = require("Fau.core.Fau_vim.config.icons")
Fau_vim.colors   = require("Fau.core.Fau_vim.config.colors")
Fau_vim.settings = require("Fau.core.Fau_vim.config.settings")

Fau_vim.file     = require("Fau.core.Fau_vim.config.file")
Fau_vim.plugin   = require("Fau.core.Fau_vim.config.plugin")
Fau_vim.lsp      = {}  -- SEE: Loaded when mason.nvim is ready.
