local modifyer = {  -- ni
  -- Document
  ["<C-d>"] = { vim.lsp.buf.hover, "Show Document" },

  -- Signature
  ["<C-p>"] = { vim.lsp.buf.signature_help, "Show Signature" },

  -- Prev/Next Reference
  ["<A-p>"] = { function() require('illuminate').next_reference({reverse=true, wrap=true}) end, "Prev Reference" },
  ["<A-n>"] = { function() require('illuminate').next_reference({wrap=true}) end              , "Next Reference" },
}


---@return string|function
local function get_rename_method()
  return Fau_vim.plugin.inc_rename.enable and ":IncRename " or vim.lsp.buf.rename
end


local builtin = require("telescope.builtin")


local functions = {
  find_symbols = function()
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
    modifyer,


    g = {
      name = "+LSP",
      -- Definition
      -- d = { "<CMD>lua require('telescope.builtin').lsp_definitions()<CR>",       "Go To Definition" },
      -- D = { "<CMD>lua require('telescope.builtin').lsp_type_definitions() <CR>", "Go To Type Definition (Declaration)" },
      -- I = { "<CMD>lua require('telescope.builtin').lsp_implementations()<CR>",   "Go To Implementation" },
      d = { "<CMD>Trouble lsp_definitions<CR>",      "Go To Definition" },
      D = { "<CMD>Trouble lsp_type_definitions<CR>", "Go To Type Definition (Declaration)" },
      I = { "<CMD>Trouble lsp_implementations<CR>",  "Go To Implementation" },

      -- Reference
      -- r = { "<CMD>lua require('telescope.builtin').lsp_references()<CR>", "Show References" },
      r = { "<CMD>Trouble lsp_references<CR>", "Show References" },

      -- Diagnostic Info
      l = { vim.diagnostic.open_float, "Show Long Diagnostic Info" },

      -- Call
      i = { builtin.lsp_incoming_calls, "Show Incoming Calls" },
      o = { builtin.lsp_outgoing_calls, "Show Outgoing Calls" },

    },


    ["<LEADER>l"] = {
      name = "+LSP",
      r = { get_rename_method(), "Rename" },

      a = { vim.lsp.buf.code_action, "Code Action" },

      -- Diagnostic Info
      -- d = { "<CMD>lua require('telescope.builtin').diagnostics({bufnr=0})<CR>", "Document Diagnostics" },
      -- D = { "<CMD>lua require('telescope.builtin').diagnostics()<CR>",          "Workspace Diagnostics" },
      d = { "<CMD>Trouble document_diagnostics<CR>", "Document Diagnostics" },
      D = { "<CMD>Trouble workspace_diagnostics<CR>", "Workspace Diagnostics" },

      -- Goto Prev/Next Diagnostics
      p = { vim.diagnostic.goto_prev, "Goto Prev Diagnostics" },
      n = { vim.diagnostic.goto_next, "Goto Next Diagnostics" },

      -- Format
      f = { Fau_vim.functions.format.smart_format, "Format Code" },
      F = { vim.lsp.buf.format,                    "Format Code (Force Formatter)" },

      -- LSP Manager
      i = { "<CMD>LspInfo<CR>", "LspInfo" },
      I = { "<CMD>Mason<CR>",   "Mason" },

      -- Symbols
      s = { functions.find_symbols, "Dynamic Workspace Symbols" },
      -- s = { "<CMD>lua require('telescope.builtin').lsp_document_symbols()<CR>",  "Buffer Symbols" },
      -- S = { "<CMD>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "Workspace Symbols" },

      -- Virtual Text
      v = { function() vim.diagnostic.config({virtual_text=not vim.diagnostic.config().virtual_text}) end, "Toggle Virtual Text" },
      -- Inlay Hints
      h = { function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })) end, "Toggle Inlay Hints" },
      -- LSP Lines
      L = "Toggle LSP Lines",

      -- Outline (Structure)
      o = { "<CMD>AerialToggle<CR>",    "Toggle Outline" },
      O = { "<CMD>AerialNavToggle<CR>", "Toggle Outline Navigation" },

      -- Restart LSP
      R = { Fau_vim.functions.lsp.restart_lsp,  "Restart LSP in All Buffers" },
    },

  },



  x = {
    ["<LEADER>l"] = {
      name = "+LSP",
      -- Format
      f = { "<CMD>lua Fau_vim.functions.format.smart_format()<CR><ESC>", "Format Code" },
      F = { "<CMD>lua vim.lsp.buf.format()<CR><ESC>",                    "Format Code (Force Formatter)" },
    },
  },



  i = { modifyer }
}
