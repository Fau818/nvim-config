-- NOTE: This module is for enhancing editor, will be loaded in `VeryLazy` event.
-- \     also maybe in `BufReadPre`, `BufReadPost`, and `BufNewFile` events.

---@type LazySpec[]
local editor = {
  -- =============================================
  -- ========== Basic Editor
  -- =============================================
  {
    -- DESC: File explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("Fau.core.nvim-tree") end,
    event = "VeryLazy",
    cmd = { "NvimTreeFindFileToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle", "NvimTreeFocus" },
    -- BUG: Show file tree in iCloud folder leads delay.
  },

  {
    -- DESC: A snazzy tabline for showing opened buffers.
    "akinsho/bufferline.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      {
        "echasnovski/mini.bufremove",
        config = function() require("mini.bufremove").setup() end,
      },
    },
    config = function() require("Fau.core.bufferline") end,
    event = "VeryLazy",
    priority = 900,
    keys = {
      -- Cycle Buffers
      { "<A-h>", "<CMD>BufferLineCyclePrev<CR>", desc = "Focus Shift Prev Buffer" },
      { "<A-l>", "<CMD>BufferLineCycleNext<CR>", desc = "Focus Shift Next Buffer" },

      -- Swap Buffers
      { "<A-left>",  "<CMD>BufferLineMovePrev<CR>", desc = "Move Buffer Prev" },
      { "<A-right>", "<CMD>BufferLineMoveNext<CR>", desc = "Move Buffer Next" },

      -- By Meta Key
      { "<A-1>", "<CMD>BufferLineGoToBuffer 1<CR>",  desc = "which_key_ignore" },
      { "<A-2>", "<CMD>BufferLineGoToBuffer 2<CR>",  desc = "which_key_ignore" },
      { "<A-3>", "<CMD>BufferLineGoToBuffer 3<CR>",  desc = "which_key_ignore" },
      { "<A-4>", "<CMD>BufferLineGoToBuffer 4<CR>",  desc = "which_key_ignore" },
      { "<A-5>", "<CMD>BufferLineGoToBuffer 5<CR>",  desc = "which_key_ignore" },
      { "<A-6>", "<CMD>BufferLineGoToBuffer 6<CR>",  desc = "which_key_ignore" },
      { "<A-7>", "<CMD>BufferLineGoToBuffer 7<CR>",  desc = "which_key_ignore" },
      { "<A-8>", "<CMD>BufferLineGoToBuffer 8<CR>",  desc = "which_key_ignore" },
      { "<A-9>", "<CMD>BufferLineGoToBuffer 9<CR>",  desc = "which_key_ignore" },
      { "<A-0>", "<CMD>BufferLineGoToBuffer -1<CR>", desc = "Buffer Last" },

      -- By Leader Key
      { "<LEADER>1", "<CMD>BufferLineGoToBuffer 1<CR>",  desc = "which_key_ignore" },
      { "<LEADER>2", "<CMD>BufferLineGoToBuffer 2<CR>",  desc = "which_key_ignore" },
      { "<LEADER>3", "<CMD>BufferLineGoToBuffer 3<CR>",  desc = "which_key_ignore" },
      { "<LEADER>4", "<CMD>BufferLineGoToBuffer 4<CR>",  desc = "which_key_ignore" },
      { "<LEADER>5", "<CMD>BufferLineGoToBuffer 5<CR>",  desc = "which_key_ignore" },
      { "<LEADER>6", "<CMD>BufferLineGoToBuffer 6<CR>",  desc = "which_key_ignore" },
      { "<LEADER>7", "<CMD>BufferLineGoToBuffer 7<CR>",  desc = "which_key_ignore" },
      { "<LEADER>8", "<CMD>BufferLineGoToBuffer 8<CR>",  desc = "which_key_ignore" },
      { "<LEADER>9", "<CMD>BufferLineGoToBuffer 9<CR>",  desc = "which_key_ignore" },
      { "<LEADER>0", "<CMD>BufferLineGoToBuffer -1<CR>", desc = "Buffer Last" },

      -- -------- TEST (from lunarvim)
      { "<LEADER>bj", "<CMD>BufferLinePick<CR>",      desc = "Buffer Pick" },
      { "<LEADER>bt", "<CMD>BufferLineTogglePin<CR>", desc = "Buffer Toggle Pin" },
    }
  },

  {
    -- DESC: A fancy and configurable statusline.
    "nvim-lualine/lualine.nvim",
    config = function() require("Fau.core.lualine") end,
    event = "VeryLazy",
    priority = 900,
  },

  {
    -- DESC: A nice scrollbar.
    "lewis6991/satellite.nvim",
    config = function() require("Fau.core.satellite") end,
    event = { "BufReadPost", "BufNewFile" },
    -- enabled = vim.fn.has("nvim-0.10") == 1,
    enabled = false,
  },



  -- =============================================
  -- ========== Fuzzy Finder (Telescope)
  -- =============================================
  {
    -- DESC: Fuzzy finder.
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- -----------------------------------
      -- -------- Extensions
      -- -----------------------------------
      "ahmedkhalf/project.nvim",  ---@see workspace.lua file
      {
        -- DESC: `fzf` sorter for telescope.
        "nvim-telescope/telescope-fzf-native.nvim",  -- for speeding up the fuzzy find
        build = "make",
        -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
      {
        -- DESC: Emoji searcher for telescope
        "xiyaowong/telescope-emoji.nvim",
      },
      {
        -- DESC: LuaSnip searcher for telescope.
        "benfowler/telescope-luasnip.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
      },
      {
        -- DESC: Switch conda environments by telescope.
        "IllustratedMan-code/telescope-conda.nvim",
        enabled = vim.fn.executable("conda") == 1,
      },
      {
        -- DESC: Docker manager in telescope.
        "lpoto/telescope-docker.nvim",
        enabled = vim.fn.executable("docker") == 1,
      },
    },
    config = function() require("Fau.core.telescope") end,
    cmd = "Telescope",  -- hard to be so lazy since which-key used this.
  },



  -- =============================================
  -- ========== Enhancement
  -- =============================================
  -- -----------------------------------
  -- -------- Keymap
  -- -----------------------------------
  {
    -- DESC: Key binding helper.
    "folke/which-key.nvim",
    config = function() require("Fau.core.whichkey") end,
    event = "VeryLazy",
    keys = "<LEADER>e", -- NOTE: Ensure open nvim-tree.
  },


  -- -----------------------------------
  -- -------- Text
  -- -----------------------------------
  {
    -- DESC: Highlight other uses of the word under the cursor.
    "RRethy/vim-illuminate",
    config = function() require("Fau.core.illuminate") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Auto remove trailing whitespaces and empty lines.
    "echasnovski/mini.trailspace",
    config = function() require("Fau.configs.editor.mini-trailspace") end,
    event = "BufWritePre",
  },

  {
    -- DESC: Colorizer for showing color.
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
    -- DESC: Highlight the TODO comment-liked things.
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.todo-comments") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    -- keys = { { "<LEADER>t", "<CMD>TodoTrouble keywords=TODO,PERF,TEST,FIX<CR>", desc = "Show Todo Comments" } }
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
    -- DESC: detect file indentation automatically.
    "nmac427/guess-indent.nvim",
    config = function() require("Fau.core.guess-indent") end,
    event = "BufReadPre",
  },

  {
    -- DESC: indent guides for Neovim.
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("Fau.core.indentline") end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "BufReadPre",
  },
  {
    -- DESC: Indent guide line with animation.
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
    -- DESC: Statusline enhancer.
    "luukvbaal/statuscol.nvim",
    config = function() require("Fau.core.statuscol") end,
    lazy = true,  -- loaded by nvim-ufo
    enabled = vim.fn.has("nvim-0.10") == 1,
  },

  {
    -- DESC: Folding enhancer.
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
    -- DESC: Quickfix list enhancer.
    "folke/trouble.nvim",
    config = function() require("Fau.core.trouble") end,
    cmd = "Trouble",
    keys = { { "<LEADER>tt", "<CMD>Trouble<CR>", desc = "Show Trouble" } },
  },

  {
    -- DESC: Terminal enhancer.
    "akinsho/toggleterm.nvim",
    config = function() require("Fau.core.terminal") end,
    lazy = true,
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
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    config = function() require("Fau.core.diffview") end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" }
  },

  {
    -- DESC: ChatGPT in Neovim!
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function() require("Fau.core.chatgpt") end,
    -- event = "VeryLazy",
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
  },

  {
    -- DESC: Support Yazi file browser in Neovim.
    "mikavilpas/yazi.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { floating_window_scaling_factor = 1, yazi_floating_window_border = "none" },
    keys = {
      { "<leader>gy", function() require("yazi").yazi() end, desc = "Open Yazi" },
      { "\\", function() require("yazi").yazi() end, desc = "Open Yazi" },
    },
    enabled = vim.fn.executable("yazi") == 1,
  },


  -- -----------------------------------
  -- -------- Jump
  -- -----------------------------------
  {
    -- DESC: a snazzy jump plugin.
    "folke/flash.nvim",
    config = function() require("Fau.core.flash") end,
    event = "VeryLazy",
    cond = true,
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
    keys = { { "<LEADER><LEADER>t", "<CMD>Twilight<CR>", desc = "Toggle Twilight" } }
  },

  {
    -- DESC: distraction-free coding for Neovim (zen-mode).
    "folke/zen-mode.nvim",
    config = function() require("Fau.core.zen-mode") end,
    cmd = "ZenMode",
    keys = { { "<LEADER><LEADER>z", "<CMD>ZenMode<CR>", desc = "Toggle ZenMode" } }
  },

}


return editor
