-- NOTE: This module is for pretty UI, most of them should be loaded in `VeryLazy` event.

return {
  {
    -- DESC: a fancy notification manager for Neovim.
    "rcarriga/nvim-notify",
    config = function() require("Fau.core.notify") end,
    event = "VeryLazy",
  },

  {
    -- DESC: a ui selector and receiver.
    "stevearc/dressing.nvim",
    config = function() require("Fau.core.dressing") end,
    event = "VeryLazy"
  },

  {
    -- DESC: a welcome dashboard for Neovim.
    "goolord/alpha-nvim",
    config = function() require("Fau.core.alpha") end,
    event = "VimEnter",
  },

  {
    -- DESC: make background transparent.
    "xiyaowong/nvim-transparent",
    config = function() require("Fau.core.transparent") end,
    -- BUG: needed fix colorscheme
    cmd = { "TransparentToggle", "TransparentEnable", "TransparentDisable" },
  },
}
