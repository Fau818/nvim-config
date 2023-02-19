-- NOTE: This module is for enhancing editor, will be loaded in `VeryLazy` event.
-- also maybe in `BufReadPost` and `BufNewFile` events.

return {
  -- =============================================
  -- ========== Basic Editor UI
  -- =============================================
  {
    -- DESC: a file explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    config = function() require("Fau.core.nvim-tree") end,
    event = { "BufReadPre", "VeryLazy" },
  },

  {
    -- DESC: a snazzy tabline to show opened buffers.
    "akinsho/bufferline.nvim",
    dependencies = {
      -- DESC: close the buffer but don't affect the layout (like vim-bbye).
      "famiu/bufdelete.nvim"
    },
    config = function() require("Fau.core.bufferline") end,
    event = { "BufReadPre", "VeryLazy" },
  },

  {
    -- DESC: a fancy and configurable statusline.
    "nvim-lualine/lualine.nvim",
    config = function() require("Fau.core.lualine") end,
    event = { "BufReadPre", "VeryLazy" },
  },


  -- =============================================
  -- ========== Fuzzy Finder (Telescope)
  -- =============================================
  {
    -- DESC: a powerful fuzzy finder.
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- -----------------------------------
      -- -------- Extensions
      -- -----------------------------------
      {
        -- DESC: a fzf sorter for telescope.
        "nvim-telescope/telescope-fzf-native.nvim",  -- for speeding up the fuzzy find
        build = "make",
        -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
      },
      {
        -- DESC: an emoji searcher for telescope
        "xiyaowong/telescope-emoji.nvim",
      },
      {
        -- DESC: a telescope extension for searching LuaSnip.
        "benfowler/telescope-luasnip.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
      },
    },
    config = function() require("Fau.core.telescope") end,
    cmd = "Telescope",
  },


  -- =============================================
  -- ========== Enhancement
  -- =============================================
  -- -----------------------------------
  -- -------- Keymap
  -- -----------------------------------
  {
    -- DESC: a fancy key binding helper.
    "folke/which-key.nvim",
    config = function() require("Fau.core.whichkey") end,
    event = "VeryLazy",
  },

  -- -----------------------------------
  -- -------- Text
  -- -----------------------------------
  {
    -- DESC: a plugin for automatically highlighting code.
    "RRethy/vim-illuminate",
    config = function() require("Fau.core.illuminate") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: a colorizer for showing color.
    "NvChad/nvim-colorizer.lua",
    config = function() require("Fau.core.colorizer") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: highlight parameters in comments.
    "folke/paint.nvim",
    config = function() require("Fau.core.paint") end,
    event = { "BufReadPost", "BufNewFile" },
    ft = { "lua", "python" },
  },
  {
    -- DESC: a highlighter for todo comments.
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.todo-comments") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  },

  -- -----------------------------------
  -- -------- View Guide
  -- -----------------------------------
  {
    -- DESC: indent guides for Neovim.
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("Fau.core.indentline") end,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    -- DESC: git integration for buffer.
    "lewis6991/gitsigns.nvim",
    config = function() require("Fau.core.gitsigns") end,
    event = { "BufReadPre", "BufNewFile" },
  },

  -- -----------------------------------
  -- -------- Powerful Window
  -- -----------------------------------
  {
    -- DESC: a pretty list to show diagnostics, references and etc (powerful quickfix list).
    "folke/trouble.nvim",
    config = function() require("Fau.core.trouble") end,
    cmd = { "TroubleToggle", "Trouble" },
  },

  {
    -- DESC: a powerful terminal provider in Neovim.
    "akinsho/toggleterm.nvim",
    config = function() require("Fau.core.terminal") end,
    event = "VeryLazy",
  },


}
