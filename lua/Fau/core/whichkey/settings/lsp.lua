---@type wk.Spec
return {
  { "g", group = "LSP" },

  { "<LEADER>l", mode = { "n", "x" }, group = "LSP" },
  { "<LEADER>lf", Fau_vim.functions.format.smart_format, desc = "Format Code" },
  {
    "<LEADER>lf",
    function()
      Fau_vim.functions.format.smart_format()
      -- TODO: a wrap function, accept `keys` and `mode`, to trigger keys
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "x", false)
    end,
    desc = "Format Code",
    mode = "x",
  },
  -- TODO: Rename? in current buffer?
  { "<LEADER>lR", Fau_vim.functions.lsp.restart_lsp, desc = "Restart LSP in All Buffers" },
}
