-- NOTE: This module is for colorscheme, will be lazy-loaded.

---@type LazySpec[]
local colorscheme = {
  {
    -- DESC: A snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    priority = 1000,
    tag = "stable",
    config = function() require("Fau.core.colorscheme") end,
  },
}


return colorscheme
