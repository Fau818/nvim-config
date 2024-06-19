-- NOTE: misc plugins.

---@type LazySpec[]
local misc = {
  {
    -- DESC: Coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    enabled = vim.fn.executable("wakatime-cli") == 1,
  },

  {
    -- DESC: Simple session manager for Neovim.
    "folke/persistence.nvim",
    config = function() require("persistence").setup() end,
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
  },

}


return misc
