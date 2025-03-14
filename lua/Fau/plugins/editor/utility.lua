-- DESC: This module is for enhancing editor functionality.

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
    config = function() require("Fau.configs.editor.utility.guess-indent") end,
    event = "BufReadPre",
  },

  {
    -- DESC: Auto remove trailing whitespaces and empty lines.
    "echasnovski/mini.trailspace",
    config = function() require("Fau.configs.editor.utility.mini-trailspace") end,
    event = "BufWritePre",
  },


  -- ==================== Immersive ====================
  {
    -- DESC: Dim inactive portions of the code to focus on coding.
    "folke/twilight.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("Fau.configs.editor.utility.twilight") end,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = { { "<LEADER><LEADER>t", "<CMD>Twilight<CR>", desc = "Twilight: Toggle" } }
  },


  {
    -- DESC: distraction-free coding for Neovim (zen-mode).
    "folke/zen-mode.nvim",
    config = function() require("Fau.configs.editor.utility.zen-mode") end,
    cmd = "ZenMode",
    keys = { { "<LEADER><LEADER>z", "<CMD>ZenMode<CR>", desc = "ZenMode: Toggle" } }
  },


  -- ==================== Code Runner ====================
  {
    -- DESC: Easily run code in Neovim.
    "CRAG666/code_runner.nvim",
    config = function() require("Fau.configs.editor.utility.code_runner") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects", "CrStopHr" },
    keys = { "<C-r>", "<LEADER>r" },
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
      { "<leader>gy", function() require("yazi").yazi() end, desc = "Yazi: Open" },
      { "\\",         function() require("yazi").yazi() end, desc = "Yazi: Open" },
    },
    enabled = vim.fn.executable("yazi") == 1,
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
    config = function() require("Fau.configs.editor.utility.chatgpt") end,
    -- event = "VeryLazy",
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
    keys = require("Fau.configs.editor.utility.chatgpt.lazy_keys"),
  },

}
