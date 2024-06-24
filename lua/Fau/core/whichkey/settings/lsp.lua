return {
  n = {
    g = "+LSP",

    ["<LEADER>l"] = {
      name = "+LSP",
      -- Format
      f = { Fau_vim.functions.format.smart_format, "Format Code" },
      -- Restart LSP
      R = { Fau_vim.functions.lsp.restart_lsp,  "Restart LSP in All Buffers" },
    },
  },


  x = {
    ["<LEADER>l"] = {
      name = "+LSP",
      -- Format
      -- f = { "<CMD>lua Fau_vim.functions.format.smart_format()<CR><ESC>", "Format Code" },
      f = { function()
        Fau_vim.functions.format.smart_format()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "x", false)
      end, "Format Code" },
    },
  },

}
