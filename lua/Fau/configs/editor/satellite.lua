-- =============================================
-- ========== Plugin Configurations
-- =============================================
local satellite = require("satellite")

local config = {
  current_only = false,
  winblend = 0,
  zindex = 40,
  excluded_filetypes = Fau_vim.file.excluded_filetypes,
  width = 2,
  handlers = {
    cursor = {
      enable = true,
      symbols = { "⎺", "⎻", "⎼", "⎽" },
    },
    search = { enable = true },
    diagnostic = {
      enable = true,
      signs = { "-", "=", "≡" },
      min_severity = vim.diagnostic.severity.WARN,
    },
    gitsigns = {
      enable = true,
      signs = { add = "│", change = "│", delete = "-" },
    },
    marks = {
      enable = true,
      show_builtins = false,  -- shows the builtin marks like [ ] < >
      key = "m",
    },
    quickfix = { signs = { "-", "=", "≡" } },
  },
}
vim.api.nvim_get_current_win()

satellite.setup(config)
