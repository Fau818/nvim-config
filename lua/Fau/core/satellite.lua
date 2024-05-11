-- =============================================
-- ========== Plugin Loading
-- =============================================
local satellite_ok, satellite = pcall(require, "satellite")
if not satellite_ok then Fau_vim.load_plugin_error("satellite") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  current_only = false,
  winblend = 0,
  zindex = 40,
  excluded_filetypes = Fau_vim.file.disabled_filetypes,
  width = 2,
  handlers = {
    cursor = {
      enable = true,
      symbols = { "⎺", "⎻", "⎼", "⎽" }
    },
    search = { enable = true },
    diagnostic = {
      enable = true,
      signs = { "-", "=", "≡" },
      min_severity = vim.diagnostic.severity.WARN,
    },
    gitsigns = {
      enable = true,
      signs = { -- can only be a single character (multibyte is okay)
        add = "│",
        change = "│",
        delete = "-",
      },
    },
    marks = {
      enable = true,
      show_builtins = false, -- shows the builtin marks like [ ] < >
      key = "m",
    },
    quickfix = { signs = { "-", "=", "≡" } }
  },
}


satellite.setup(config)
