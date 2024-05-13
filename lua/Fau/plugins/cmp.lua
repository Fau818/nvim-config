-- NOTE: This module is for code completion, will be loaded in `InsertEnter` event.

---@type LazySpec[]
local cmp = {
  -- =============================================
  -- ========== Completion
  -- =============================================
  {
    -- DESC: Neovim code completion core plugin.
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- -----------------------------------
      -- -------- Completion Sources
      -- -----------------------------------
      {
        -- DESC: Language server protocol completion source for nvim-cmp.
        "hrsh7th/cmp-nvim-lsp",
      },
      {
        -- DESC: Buffer completion source for nvim-cmp.
        "hrsh7th/cmp-buffer",
      },
      {
        -- DESC: Path completion source for nvim-cmp.
        "hrsh7th/cmp-path",
      },
      {
        -- DESC: Command line completion source for nvim-cmp.
        "hrsh7th/cmp-cmdline",
      },
      {
        -- DESC: Calculation source for nvim-cmp.
        "hrsh7th/cmp-calc"
      },
      {
        -- DESC: Zsh completion source for nvim-cmp.
        "tamago324/cmp-zsh",
      },
      {
        -- DESC: `L3MON4D3/LuaSnip` code snippets completion source for nvim-cmp.
        "saadparwaiz1/cmp_luasnip",
        dependencies = { "L3MON4D3/LuaSnip" }
      },
      {
        -- DESC: Github copilot source for nvim-cmp.
        "zbirenbaum/copilot-cmp",
        dependencies = {
          {
            -- DESC: Github copilot supporter.
            "zbirenbaum/copilot.lua",
            config = function() require("Fau.core.copilot") end,
            cmd = { "Copilot" },
          },
        },
        config = function() require("copilot_cmp").setup() end,
        enabled = Fau_vim.plugin.copilot.enable,
      },


      -- -----------------------------------
      -- -------- Snippets
      -- -----------------------------------
      {
        -- DESC: Code snippets engine.
        "L3MON4D3/LuaSnip",
        lazy = true,
      },


      -- -----------------------------------
      -- -------- Autopairs and Autotags
      -- -----------------------------------
      {
        -- DESC: A super powerful autopair plugin for Neovim.
        "windwp/nvim-autopairs",
        config = function() require("Fau.core.autopairs") end,
      },

      {
        -- DESC: Auto close html tag.
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
    -- DESC: Smartly add `end` in lua, ruby, and etc.
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "InsertEnter" },
  },

  {
    -- DESC: Show signature help in a small pop window.
    "echasnovski/mini.completion",
    config = function() require("Fau.core.mini.completion") end,
    event = { "InsertEnter" },
  },


}


return cmp
