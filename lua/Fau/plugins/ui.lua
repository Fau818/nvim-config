-- NOTE: This module is for pretty UI, most of them should be loaded in `VeryLazy` event.

---@type LazySpec[]
local ui = {
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
    -- DESC: a fancy UI provider.
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        -- DESC: a fancy notification manager for Neovim.
        "rcarriga/nvim-notify",
        config = function() require("Fau.core.notify") end,
      },
    },
    config = function() require("Fau.core.noice") end,
    event = "VeryLazy",
    priority = 999, -- quciker than lualine
  },

  {
    -- DESC: a colorful window separator.
    "nvim-zh/colorful-winsep.nvim",
    config = function() require("Fau.core.winsep") end,
    event = { "WinNew" },
  },


}


return ui
