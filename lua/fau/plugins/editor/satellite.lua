---@type LazySpec
return {
  -- DESC: A nice scrollbar.
  ---@module "satellite"
  "lewis6991/satellite.nvim",
  enabled = vim.fn.has("nvim-0.10") == 1,
  event = { "BufReadPre", "BufNewFile" },
  ---@type SatelliteConfig
  opts = {
    current_only = false,

    winblend = 0,
    zindex   = 40,
    width    = 2,

    excluded_filetypes = fvim.file.excluded_filetypes,

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
      quickfix = {
        enable = true,
        signs = { '-', '=', '≡' },
      }
    },
  }
}
