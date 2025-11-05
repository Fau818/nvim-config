-- ==================== Basic ====================
fvim.nvim_config_path = vim.fn.stdpath("config")
fvim.xdg_config_home  = os.getenv("XDG_CONFIG_HOME") or vim.fn.expand("~/.config")


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
