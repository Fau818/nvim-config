-- NOTE: This module is for pretty UI, most of them should be loaded in `VeryLazy` and `UIEnter` events.

---@type LazySpec[]
local ui = {
  -- ==================== Global ====================
  {
    -- DESC: A fancy UI provider.
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        -- DESC: a fancy notification manager for Neovim.
        "rcarriga/nvim-notify",
        config = function() require("Fau.configs.ui.notify") end,
      },
    },
    config = function() require("Fau.configs.ui.noice") end,
    event = "UIEnter",
  },

  -- ==================== Selector ====================
  {
    -- DESC: UI selector for Neovim.
    "stevearc/dressing.nvim",
    config = function() require("Fau.configs.ui.dressing") end,
    event = "UIEnter"
  },

  -- ==================== Animation ====================
  {
    -- DESC: Add animation for Neovim actions.
    "echasnovski/mini.animate",
    config = function() require("Fau.configs.ui.mini-animate") end,
    event = "UIEnter",
  },

  -- ==================== Window ====================
  {
    -- DESC: Colorful window separator.
    "nvim-zh/colorful-winsep.nvim",
    config = function() require("Fau.configs.ui.winsep") end,
    event = { "WinLeave" },
  },

  {
    -- DESC: Add animation for Neovim window actions.
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
    config = function() require("Fau.configs.ui.windows") end,
    event = { "WinNew" },
    keys = {
      { "<C-w>z", "<CMD>WindowsMaximize<CR>",             desc = "Maximize Window" },
      { "<C-w>_", "<CMD>WindowsMaximizeVertically<CR>",   desc = "Maximize Window Vertically" },
      { "<C-w>|", "<CMD>WindowsMaximizeHorizontally<CR>", desc = "Maximize Window Horizontally" },
      { "<C-w>=", "<CMD>WindowsEqualize<CR>",             desc = "Equalize Window" },
    },
  },

}


return ui
