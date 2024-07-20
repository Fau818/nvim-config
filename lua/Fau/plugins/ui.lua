-- DESC: This module is for pretty UI; different from `editor.ui` module, this module is more global.

---@type LazySpec[]
return {
  -- ==================== Global ====================
  {
    -- DESC: A fancy UI provider.
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        -- DESC: A fancy notification manager for Neovim.
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

  {
    -- DESC: Add animation for Neovim window actions.
    "anuvyklack/windows.nvim",
    dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
    config = function() require("Fau.configs.ui.windows") end,
    event = "WinNew",
    keys = {
      { "<C-w>z", "<CMD>WindowsMaximize<CR>",             desc = "Window: Maximize" },
      { "<C-w>_", "<CMD>WindowsMaximizeVertically<CR>",   desc = "Window: Maximize Vertically" },
      { "<C-w>|", "<CMD>WindowsMaximizeHorizontally<CR>", desc = "Window: Maximize Horizontally" },
      { "<C-w>=", "<CMD>WindowsEqualize<CR>",             desc = "Window: Equalize" },
    },
  },

}
