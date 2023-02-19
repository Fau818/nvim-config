-- NOTE: This module is for testing new plugins.

return {
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    enabled = false,
    config = function() require("Fau.core.lsp_signature") end,
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

  {
    -- DESC: single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
    event = "VeryLazy",
  },

  {
    "echasnovski/mini.indentscope",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "", "checkhealth", "help", "gitcommit", "alpha", "NvimTree", "Trouble",
          "toggleterm", "aerial", "lspinfo", "notify", "noice", "TelescopePrompt",
          "packer", "lazy", "mason",
        },
        callback = function() vim.b.miniindentscope_disable = true end,
      })

      local config = {
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          -- Textobjects
          object_scope = 'ii',
          object_scope_with_border = 'ai',

          -- Motions (jump to respective border line; if not present - body line)
          goto_top = '[i',
          goto_bottom = ']i',
        },

        -- Options which control scope computation
        options = {
          -- Type of scope's border: which line(s) with smaller indent to
          -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
          border = "top",  -- for python

          -- Whether to use cursor column when computing reference indent.
          -- Useful to see incremental scopes with horizontal cursor movements.
          indent_at_cursor = true,

          -- Whether to first check input line to be a border of adjacent scope.
          -- Use it if you want to place cursor on function header to get scope of
          -- its body.
          try_as_border = true,
        },
        -- Which character to use for drawing scope indicator
        symbol = Fau_vim.icons.ui.IndentLine,
      }
      require("mini.indentscope").setup(config)
    end,
    event = { "BufReadPost", "BufNewFile" },
  }

}
