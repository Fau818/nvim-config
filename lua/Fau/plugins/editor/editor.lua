-- DESC: This module is for enhancing editor, will be loaded in `VeryLazy` event.
-- \     also maybe in `BufReadPre`, `BufReadPost`, and `BufNewFile` events.

---@type LazySpec[]
return {
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
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.indentline") end,
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
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim"  -- Not necessary, but for loading telescope keybinds first!
    },
    config = function() require("Fau.core.trouble") end,
    event = "LspAttach",
    cmd = "Trouble",
    keys = { "gd", "gD", "gt", "gI", "gr", "gi", "go", "<LEADER>ld", "<LEADER>lD" },
    tag = Fau_vim.plugin.trouble.tag,
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
    dependencies = "nvim-lua/plenary.nvim",
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
    dependencies = "nvim-treesitter/nvim-treesitter",
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
