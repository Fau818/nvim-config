-- NOTE: This module is for enhancing editor, will be loaded in `VeryLazy` event.
-- also maybe in `BufReadPre`, `BufReadPost`, and `BufNewFile` events.

---@type LazySpec[]
local editor = {
  -- =============================================
  -- ========== Basic Editor
  -- =============================================
  {
    -- DESC: a file explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    config = function() require("Fau.core.nvim-tree") end,
    event = "VeryLazy",
  },

  {
    -- DESC: a snazzy tabline to show opened buffers.
    "akinsho/bufferline.nvim",
    dependencies = {
      {
        "echasnovski/mini.bufremove",
        config = function() require("mini.bufremove").setup() end,
      }
    },
    config = function() require("Fau.core.bufferline") end,
    event = "VeryLazy",
    priority = 998,
  },

  {
    -- DESC: a fancy and configurable statusline.
    "nvim-lualine/lualine.nvim",
    config = function() require("Fau.core.lualine") end,
    event = "VeryLazy",
    priority = 998,
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
      "ahmedkhalf/project.nvim",  ---@see workspace.lua file
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
      {
        -- DESC: an extension to switch conda environments.
        "IllustratedMan-code/telescope-conda.nvim",
      },
      {
        -- DESC: an extension to manage the docker containers.
        "lpoto/telescope-docker.nvim",
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
    -- event = { "BufReadPost", "BufNewFile" },
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

  {
    -- DESC: support highlighting in kitty config file.
    "fladson/vim-kitty",
    ft = "kitty",
  },


  -- -----------------------------------
  -- -------- View Guide
  -- -----------------------------------
  {
    -- DESC: indent guides for Neovim.
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("Fau.core.indentline") end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    -- DESC: an indent guide line with animation.
    "echasnovski/mini.indentscope",
    config = function() require("Fau.core.mini.indentscope") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: git integration for buffer.
    "lewis6991/gitsigns.nvim",
    config = function() require("Fau.core.gitsigns") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: a statusline enhancement plugin.
    "luukvbaal/statuscol.nvim",
    config = function() require("Fau.core.statuscol") end,
    lazy = true,  -- loaded by nvim-ufo
    enabled = vim.fn.has("nvim-0.9") == 1,
  },

  {
    -- DESC: a modern fold plugin.
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
      "luukvbaal/statuscol.nvim",
    },
    config = function() require("Fau.core.ufo") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "UfoEnable", "UfoDisable", "UfoInspect", "UfoAttach", "UfoDetach", "UfoEnableFold", "UfoDisableFold" },
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

  {
    -- DESC: easily run code in Neovim.
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.code_runner") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
    config = function() require("Fau.core.diffview") end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" }
  },


  -- -----------------------------------
  -- -------- Jump
  -- -----------------------------------
  {
    -- DESC: a quick global jumper.
    "ggandor/leap.nvim",
    dependencies = { "ggandor/flit.nvim" },
    config = function() require("Fau.core.leap") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: an enhancer for f/t motion.
    "ggandor/flit.nvim",
    config = function() require("Fau.core.flit") end,
    lazy = true  -- loaded by leap
  },



  -- =============================================
  -- ========== Immersive
  -- =============================================
  {
    -- DESC: dim inactive portions of the code to focus on coding.
    "folke/twilight.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.twilight") end,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },

  {
    -- DESC: distraction-free coding for Neovim (zen-mode).
    "folke/zen-mode.nvim",
    config = function() require("Fau.core.zen-mode") end,
    cmd = "ZenMode",
  },

}


return editor
