local functions = {
  find_symbols = function()
    local builtin = require("telescope.builtin")
    local config = {
      symbols = { "class", "function" },
      layout_strategy = "center",
      sorting_strategy = "ascending",
    }
    builtin.lsp_dynamic_workspace_symbols(config)
  end,
}


return {
  n = {
    g = "+LSP",

    ["<LEADER>l"] = {
      name = "+LSP",
      -- Format
      f = { Fau_vim.functions.format.smart_format, "Format Code" },
      -- Symbols
      s = { functions.find_symbols, "Dynamic Workspace Symbols" },
      -- Restart LSP
      R = { Fau_vim.functions.lsp.restart_lsp,  "Restart LSP in All Buffers" },
    },

  },


  x = {
    ["<LEADER>l"] = {
      name = "+LSP",
      -- Format
      f = { Fau_vim.functions.format.smart_format, "Format Code" },
    },
  },

}
