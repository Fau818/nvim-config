---@type LazySpec
return {
  -- DESC: Key binding helper.
  "folke/which-key.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "UIEnter",
  config = function()
    require "Fau.plugins.editor.whichkey.config"
    require "Fau.plugins.editor.whichkey.settings"
  end,
}
