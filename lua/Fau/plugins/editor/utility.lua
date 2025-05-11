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


  -- ==================== Extension ====================
  {
    -- DESC: Coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    enabled = vim.fn.executable("wakatime-cli") == 1,
  },

}
