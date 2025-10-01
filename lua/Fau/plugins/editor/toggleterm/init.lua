---@type LazySpec
return  {
  -- DESC: Terminal enhancer.
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  keys = { "<C-t>", "<LEADER>gg", "<LEADER>gb" },

  config = function()
    require("Fau.plugins.editor.toggleterm.config")
    require("Fau.plugins.editor.toggleterm.custom_terminal")
  end,
}
