-- DESC: This module is for enhancing editor.

---@type LazySpec[]
return {
  -- ==================== Enhancer ====================
  {
    -- DESC: Simple session manager for Neovim.
    "folke/persistence.nvim",
    config = true,
    event = "BufReadPre",  -- this will only start session saving when an actual file was opened
  },

  {
    -- DESC: Detect file indentation automatically.
    "nmac427/guess-indent.nvim",
    config = function() require("Fau.configs.editor.guess-indent") end,
    event = "BufReadPre",
  },


  -- ==================== Immersive ====================
  {
    -- DESC: Dim inactive portions of the code to focus on coding.
    "folke/twilight.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("Fau.configs.editor.twilight") end,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = { { "<LEADER><LEADER>t", "<CMD>Twilight<CR>", desc = "Twilight: Toggle" } }
  },


  {
    -- DESC: distraction-free coding for Neovim (zen-mode).
    "folke/zen-mode.nvim",
    config = function() require("Fau.configs.editor.zen-mode") end,
    cmd = "ZenMode",
    keys = { { "<LEADER><LEADER>z", "<CMD>ZenMode<CR>", desc = "ZenMode: Toggle" } }
  },


  -- ==================== Extension ====================
  {
    -- DESC: Coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    enabled = vim.fn.executable("wakatime-cli") == 1,
  },

  {
    -- DESC: Support Yazi file browser in Neovim.
    "mikavilpas/yazi.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = { floating_window_scaling_factor = 1, yazi_floating_window_border = "none" },
    keys = {
      { "<leader>gy", function() require("yazi").yazi() end, desc = "Open Yazi" },
      { "\\",         function() require("yazi").yazi() end, desc = "Open Yazi" },
    },
    enabled = vim.fn.executable("yazi") == 1,
  },

}
