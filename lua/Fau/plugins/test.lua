-- NOTE: This module is for testing new plugins.

---@type LazySpec[]
local test = {
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    enabled = false,
    config = function() require("Fau.core.lsp.lsp_signature") end,
    lazy = true,
  },

  {
    -- DESC: an incremental LSP rename supporter, which has a preview feature.
    -- WARNING: This plugin is disabled.
    "smjonas/inc-rename.nvim",
    enabled = Fau_vim.inc_rename.enable,
    config = function() require("Fau.core.inc_rename") end,
    lazy = true,
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


  {
    "echasnovski/mini.completion",
    config = function()
      local completion = require("mini.completion")


      local DISABLE_TIME = 99999999999999999999999999999999999999999999999999999999999
      local config = {
        -- Delay (debounce type, in ms) between certain Neovim event and action.
        -- This can be used to (virtually) disable certain automatic actions by
        -- setting very high delay time (like 10^7).
        delay = { completion = DISABLE_TIME, info = DISABLE_TIME, signature = 250 },

        -- Configuration for action windows:
        -- - `height` and `width` are maximum dimensions.
        -- - `border` defines border (as in `nvim_open_win()`).
        window = {
          info = { height = 25, width = 80, border = "none" },
          signature = { height = 25, width = 80, border = "none" },
        },

        -- Way of how module does LSP completion
        lsp_completion = {
          -- `source_func` should be one of 'completefunc' or 'omnifunc'.
          source_func = "completefunc",

          -- `auto_setup` should be boolean indicating if LSP completion is set up
          -- on every `BufEnter` event.
          auto_setup = false,

          -- `process_items` should be a function which takes LSP
          -- 'textDocument/completion' response items and word to complete. Its
          -- output should be a table of the same nature as input items. The most
          -- common use-cases are custom filtering and sorting. You can use
          -- default `process_items` as `MiniCompletion.default_process_items()`.
          -- process_items = --<function: filters out snippets; sorts by LSP specs>,
        },

        -- Fallback action. It will always be run in Insert mode. To use Neovim's
        -- built-in completion (see `:h ins-completion`), supply its mapping as
        -- string. Example: to use 'whole lines' completion, supply '<C-x><C-l>'.
        -- fallback_action = --<function: like `<C-n>` completion>,

        -- Module mappings. Use `''` (empty string) to disable one. Some of them
        -- might conflict with system mappings.
        mappings = {
          force_twostep  = "", -- Force two-step completion
          force_fallback = "", -- Force fallback completion
        },

        -- Whether to set Vim's settings for better experience (modifies
        -- `shortmess` and `completeopt`)
        set_vim_settings = false,
      }


      completion.setup(config)
    end,
    event = { "InsertEnter", "CmdlineEnter" },
  }


}


return test
