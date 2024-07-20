-- TODO: ...
-- DESC: This module is for enhancing editor, will be loaded in `VeryLazy` event.
-- \     also maybe in `BufReadPre`, `BufReadPost`, and `BufNewFile` events.

---@type LazySpec[]
return {
  -- -----------------------------------
  -- -------- Powerful Window
  -- -----------------------------------
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
    init = function()
      -- Use diagonal lines in place of deleted lines in diff mode.
      vim.opt.fillchars:append{ diff = "╱" }
    end,
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
