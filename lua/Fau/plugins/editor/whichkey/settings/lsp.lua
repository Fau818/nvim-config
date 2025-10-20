---@type wk.Spec
return {
  { "g", group = "LSP" },

  { "<LEADER>l", mode = { "n", "x" }, group = "LSP" },
  { "<LEADER>lf", Fau_vim.functions.format.smart_format, desc = "LSP: Format Code (Smart)" },
  {
    "<LEADER>lf",
    function()
      Fau_vim.functions.format.smart_format()
      Fau_vim.functions.utils.feedkeys("x", "<ESC>")
    end,
    desc = "LSP: Format Code (Smart)",
    mode = "x",
  },

  { "<LEADER>lR", Fau_vim.lsp.restart_lsp, desc = "Restart LSP for Current Buffer" },
}
