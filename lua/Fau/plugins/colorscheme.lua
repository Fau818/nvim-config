-- DESC: This module is for colorscheme.

---@type LazySpec[]
return {
  {
    -- DESC: A snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    priority = 1000,
    -- tag = "stable",
    config = function()
      Fau_vim.colorscheme = "tokyonight"
      require("Fau.configs.colorscheme")
    end,
  },
}
