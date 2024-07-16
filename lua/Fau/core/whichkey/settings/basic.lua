-- NOTE: This is a annotation file for `Fau_vim.keymaps` with a spot of additional overwrite and new key bindings.
---@type wk.Spec
return {
  -- ==================== Whichkey Ignore ====================
  { "<MouseMove>", desc = "which_key_ignore" },
  { "<LeftMouse>", desc = "which_key_ignore" },

  -- ==================== Yank and Paste ====================
  { "y", group = "Yank with System Clipboard" },
  { "Y", desc  = "Yank Line with System Clipboard" },
  { "p", desc  = "Paste from System Clipboard" },
  { "P", desc  = "PASTE from System Clipboard" },

  -- ==================== Override ====================
  { "<A-q>", Fau_vim.functions.utils.buf_remove, desc = "Close Current Buffer" },


  -- ==================== Fau_vim Custom ====================
  -- ---------- Edit Configuration and Snippet
  -- TODO: Refactor this. (or move to other place)
  { "<LEADER>E", group = "Edit" },
  { "<LEADER>Ec", "<CMD>EditConfiguration<CR>", desc = "Edit Configuration" },
  { "<LEADER>Es", "<CMD>EditSnip<CR>",          desc = "Edit Snippet" },

  -- ---------- Lazy
  { "<LEADER>ll", require("lazy").home, desc = "Open Lazy (Plugin Manager)" },

  -- ---------- Toggle Indent
  { "<LEADER><LEADER>i", Fau_vim.functions.indent.toggle_indent_width, desc = "Toggle Indent Width" },
  -- Fau: I don't think this is helpful.
  { "<LEADER><LEADER>I", function() Fau_vim.functions.indent.toggle_indent_width(true) end, decs = "Toggle Indent Width (Force)" },

  -- ---------- Buffer Navigation
  -- BUG: Not working.
  ["<A-1~9>"]       = "Switch to Buffer <1~9>",
  ["<LEADER><1~9>"] = "Switch to Buffer <1~9>",
}
