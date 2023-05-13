-- NOTE: This module is for testing new plugins.

---@type LazySpec[]
local test = {
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    config = function() require("Fau.core.lsp.lsp_signature") end,
    enabled = false,
    -- cond = false
  },

  {
    -- DESC: an incremental LSP rename supporter, which has a preview feature.
    -- WARNING: This plugin is disabled.
    "smjonas/inc-rename.nvim",
    config = function() require("Fau.core.inc_rename") end,
    enabled = Fau_vim.inc_rename.enable,
  },


  -- {
  --   -- DESC: Maybe in the future.
  --   -- mini.doc
  -- },

  {
    "lewis6991/satellite.nvim",
    config = function()
      require("satellite").setup {
        current_only = false,
        winblend = 0,
        zindex = 40,
        excluded_filetypes = Fau_vim.disabled_filetypes,
        width = 2,
        handlers = {
          search = {
            enable = true,
          },
          diagnostic = {
            enable = true,
            signs = { "-", "=", "≡" },
            min_severity = vim.diagnostic.severity.HINT,
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
          },
        },
      }
    end,
    cond = false
  },


}


return test
