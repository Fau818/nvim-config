---@type LazySpec
return {
  -- DESC: A nice scrollbar.
  ---@module "satellite"
  "lewis6991/satellite.nvim",
  enabled = vim.fn.has("nvim-0.10") == 1,  -- BUG: Delay when scroll in buffer.
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
        enable = false,  -- BUG: It seems that prevent the buffer remove function.
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
