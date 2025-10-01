---@type LazySpec
return {
  -- DESC: A fancy UI provider.
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    { "rcarriga/nvim-notify", config = function() require("Fau.plugins.editor.noice.notify") end },
  },

  event = "UIEnter",

  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "noice",
      group = "Fau_vim",
      desc = "Disable `K` to show hover document keymaps in `noice`.",
      callback = function() vim.b.markdown_keys = true end,
    })
  end,
  config = function()
    require("Fau.plugins.editor.noice.config")
    require("Fau.plugins.editor.noice.keymaps")
  end,
}
