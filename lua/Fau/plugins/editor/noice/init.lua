---@type LazySpec
return {
  -- DESC: A fancy UI provider.
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    { "rcarriga/nvim-notify", config = function() require("Fau.plugins.editor.noice.notify") end },
  },

  event = "UIEnter",

  config = function()
    require("Fau.plugins.editor.noice.config")
    require("Fau.plugins.editor.noice.keymaps")
  end,
}
