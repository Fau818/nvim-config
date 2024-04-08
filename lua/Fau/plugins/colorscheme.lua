-- NOTE: This module is for colorscheme, will be lazy-loaded.

---@type LazySpec[]
local colorscheme = {
  {
    -- DESC: a snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    priority = 1000,
    tag = "stable",
    config = function() require("Fau.core.colorscheme") end,
  },


  {
    -- DESC: the darkplus colorscheme just like VSCode.
    "lunarvim/darkplus.nvim",
    priority = 1000,
    lazy = true, -- when is used, will load automatically.
    enabled = false,
  },
}


return colorscheme
