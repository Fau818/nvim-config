-- DESC: This module is for code completion, will be loaded in `InsertEnter` event.

---@type LazySpec[]
local cmp = {
  -- ==================== Completion Core ====================
  {
    -- DESC: Neovim code completion core plugin.
    -- BUG: If open a large file, a huge dalay occur in the first time entering the insert mode.
    -- \    Open command to enter having huge delay. and if scroll many lines, it occurs again.
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        -- DESC: Autopair plugin for Neovim.
        "windwp/nvim-autopairs",
        config = function() require("Fau.configs.completion.autopairs") end,
      },

      {
        -- DESC: Auto close html tag in Neovim.
        "windwp/nvim-ts-autotag",
        config = function() require("Fau.configs.completion.autotag") end,
      },
    },
    config = function() require("Fau.configs.completion.cmp") end,
    lazy = true,
  },


  -- ==================== Completion Sources ====================
  {
    -- DESC: Language server protocol completion source for nvim-cmp.
    "hrsh7th/cmp-nvim-lsp",
    dependencies = "hrsh7th/nvim-cmp",
    event = "LspAttach",
  },

  {
    -- DESC: Buffer completion source for nvim-cmp.
    "hrsh7th/cmp-buffer",
    dependencies = "hrsh7th/nvim-cmp",
    event = { "CmdlineEnter", "InsertEnter" },
  },

  {
    -- DESC: Path completion source for nvim-cmp.
    "hrsh7th/cmp-path",
    dependencies = "hrsh7th/nvim-cmp",
    event = { "CmdlineEnter", "InsertEnter" },
  },

  {
    -- DESC: Command line completion source for nvim-cmp.
    "hrsh7th/cmp-cmdline",
    dependencies = "hrsh7th/nvim-cmp",
    event = "CmdlineEnter",
  },

  {
    -- DESC: Calculation source for nvim-cmp.
    "hrsh7th/cmp-calc",
    dependencies = "hrsh7th/nvim-cmp",
    event = { "CmdlineEnter", "InsertEnter" },
  },

  {
    -- DESC: `L3MON4D3/LuaSnip` code snippets completion source for nvim-cmp.
    "saadparwaiz1/cmp_luasnip",
    dependencies = {
      { "hrsh7th/nvim-cmp" },
      { "L3MON4D3/LuaSnip", config = function() require("Fau.configs.completion.luasnip") end },
    },
    event = "InsertEnter",
  },

  {
    -- DESC: Conventional gitcommits type source for nvim-cmp.
    "davidsierradz/cmp-conventionalcommits",
    dependencies = "hrsh7th/nvim-cmp",
    ft = "gitcommit",
  },



  -- ==================== Copilot ====================
  -- {
  --   -- DESC: Github copilot source for nvim-cmp.
  --   "zbirenbaum/copilot-cmp",
  --   dependencies = {
  --     "hrsh7th/nvim-cmp",
  --     {
  --       -- DESC: Github copilot supporter.
  --       -- TEST: Use a fork
  --       "Kelo007/copilot.lua",
  --       config = function() require("Fau.configs.completion.copilot") end,
  --       cmd = "Copilot",
  --     }
  --   },
  --   config = function() require("copilot_cmp").setup() end,
  --   event = "InsertEnter",
  --   enabled = Fau_vim.plugin.copilot.enable,
  -- },
  {
    -- DESC: Github copilot supporter.
    -- NOTE: Original repo: zbirenbaum/copilot.lua
    "Fau818/copilot.lua",
    config = function() require("Fau.configs.completion.copilot") end,
    event = "InsertEnter",
    cmd = "Copilot",
    enabled = Fau_vim.plugin.copilot.enable,
  },


  -- ==================== MISC ====================
  {
    -- DESC: Smartly add `end` in lua, ruby, and etc.
    "RRethy/nvim-treesitter-endwise",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "Ruby", "Lua", "Vimscript", "Bash", "Elixir", "Fish", "Julia" }
  },

  {
    -- DESC: Show signature help in a small pop window.
    "echasnovski/mini.completion",
    config = function() require("Fau.configs.completion.mini-completion") end,
    event = "InsertEnter",
  },

}


return cmp
