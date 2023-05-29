-- NOTE: This module is for code completion, will be loaded in `InsertEnter` event.

---@type LazySpec[]
local cmp = {
  -- =============================================
  -- ========== Completion
  -- =============================================
  {
    -- DESC: neovim code completion core plugin.
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- -----------------------------------
      -- -------- Completion Sources
      -- -----------------------------------
      {
        -- DESC: buffer completion source for nvim-cmp.
        "hrsh7th/cmp-buffer",
      },
      {
        -- DESC: language server protocol completion source for nvim-cmp.
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        -- DESC: path completion source for nvim-cmp.
        "hrsh7th/cmp-path",
      },
      {
        -- DESC: command line completion source for nvim-cmp.
        "hrsh7th/cmp-cmdline",
      },
      {
        -- DESC: L3MON4D3/LuaSnip plugin completion source for nvim-cmp.
        "saadparwaiz1/cmp_luasnip",
        dependencies = { "L3MON4D3/LuaSnip" }
      },
      {
        -- DESC: gitcommit completion source for nvim-cmp.
        "davidsierradz/cmp-conventionalcommits",
        ft = "gitcommit",
      },
      {
        -- DESC: zsh completion source for nvim-cmp.
        "tamago324/cmp-zsh",
        ft = "zsh",
      },
      {
        -- DESC: signature help completion source for nvim-cmp.
        -- WARNING: This plugin is disabled.
        "hrsh7th/cmp-nvim-lsp-signature-help",
        enabled = false,
      },
      {
        -- DESC: calculation source for nvim-cmp.
        "hrsh7th/cmp-calc"
      },
      {
        -- DESC: copilot source for nvim-cmp
        "zbirenbaum/copilot-cmp",
        dependencies = {
          {
            -- DESC: a plugin for config copilot.
            "zbirenbaum/copilot.lua",
            config = function() require("Fau.core.copilot") end,
            cmd = { "Copilot" },
          },
        },
        config = function()
          local config = {
            suggestion = { enabled = false },
            panel = { enabled = false },
          }
          require("copilot_cmp").setup(config)
        end,
      },



      -- -----------------------------------
      -- -------- Snippets
      -- -----------------------------------
      {
        -- DESC: a powerful code snippets engine.
        "L3MON4D3/LuaSnip",
        dependencies = {
          {
            -- DESC: an abundant code snippet repository (can be loaded into LuaSnip).
            -- WARNING: This plugin is disabled.
            "rafamadriz/friendly-snippets",
            enabled = false,
          },
        },
      },


      -- -----------------------------------
      -- -------- Autopairs and Autotags
      -- -----------------------------------
      {
        -- DESC: a super powerful autopair plugin for Neovim.
        "windwp/nvim-autopairs",
        config = function() require("Fau.core.autopairs") end,
      },

      {
        -- DESC: auto close html tag.
        "windwp/nvim-ts-autotag",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
      },
    },
    config = function() require("Fau.core.cmp") end,
    event = { "InsertEnter", "CmdlineEnter" },
    -- BUG: If open a large file, a huge dalay occur in the first time entering the insert mode.
    -- BUG: Open command to enter having huge delay. and if scroll many lines, it occurs again.
  },

  {
    -- DESC: smartly add `end` in lua, ruby, and etc.
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "lua", "ruby", "vim", "sh", "zsh", "elixir" }
  },

  {
    -- DESC: show signature help in a small pop window.
    "echasnovski/mini.completion",
    config = function() require("Fau.core.mini.completion") end,
    event = { "InsertEnter" },
  },


}


return cmp
