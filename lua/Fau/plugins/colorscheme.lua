-- NOTE: This module is for colorscheme, will be lazy-loaded.

return {
  {
    -- DESC: a snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function() require("Fau.core.colorscheme") end,
  },


  {
    -- DESC: the darkplus colorscheme just like VSCode.
    "lunarvim/darkplus.nvim",
    lazy = true, -- when is used, will load automatically.
  },
}