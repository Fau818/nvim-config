-- DESC: misc plugins.

---@type LazySpec[]
return {
  {
    -- DESC: Coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    enabled = vim.fn.executable("wakatime-cli") == 1,
  },

  {
    -- DESC: Simple session manager for Neovim.
    "folke/persistence.nvim",
    config = true,
    event = "BufReadPre",  -- this will only start session saving when an actual file was opened
  },

  {
    -- DESC: Detect file indentation automatically.
    "nmac427/guess-indent.nvim",
    config = function() require("Fau.configs.misc.guess-indent") end,
    event = "BufReadPre",
  },

}
