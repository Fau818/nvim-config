-- =============================================
-- ========== Plugin Configurations
-- =============================================
local satellite = require("satellite")

---@type SatelliteConfig
local config = {
  current_only = false,

  winblend = 0,
  zindex   = 40,
  width    = 2,

  excluded_filetypes = Fau_vim.file.excluded_filetypes,

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
    quickfix = { signs = { error = { '-', '=', '≡' }, warn = { '-', '=', '≡' }, info = { '-', '=', '≡' }, hint = { '-', '=', '≡' } } },
  },
}

satellite.setup(config)
