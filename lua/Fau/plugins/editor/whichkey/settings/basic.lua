-- NOTE: This is a annotation file for `Fau_vim.keymaps` with a spot of additional overwrite and new key bindings.
---@type wk.Spec
return {
  -- ==================== Whichkey Ignore ====================
  { "<MouseMove>", desc = "which_key_ignore" },
  { "<LeftMouse>", desc = "which_key_ignore" },
  { "n", desc = "Goto: Next" },
  { "N", desc = "Goto: Prev" },

  -- ==================== Yank and Paste ====================
  { "y", group = "Yank with System Clipboard" },
  { "y", function() Fau_vim.functions.utils.smart_visual_mode(); vim.api.nvim_command("normal! y") end, mode = "x", desc = "Yank" },
  { "Y", desc  = "Yank Line with System Clipboard" },
  { "p", desc  = "Paste from System Clipboard" },
  { "P", desc  = "PASTE from System Clipboard" },
  { "<LEADER>d", function() Fau_vim.functions.utils.smart_visual_mode(); vim.api.nvim_command("normal! d") end, mode = "x", desc = "Cut" },

  -- ==================== Override ====================
  { "<A-q>", Fau_vim.functions.utils.buf_remove, desc = "Buffer: Close Current Buffer" },

  -- ==================== Fau_vim Custom ====================
  -- ---------- Edit Configuration and Snippet
  -- TODO: Refactor this. (or move to other place)
  { "<LEADER>E", group = "Edit" },
  { "<LEADER>Ec", "<CMD>EditConfiguration<CR>", desc = "Fau_vim: Edit Configuration" },
  { "<LEADER>Es", "<CMD>EditSnip<CR>",          desc = "Fau_vim: Edit Snippet" },

  -- ---------- Lazy
  { "<LEADER>ll", require("lazy").home, desc = "Lazy: Open" },

  -- ---------- Toggle Indent
  { "<LEADER><LEADER>i", Fau_vim.functions.indent.toggle_indent_width, desc = "Indent: Toggle Width" },
  -- Fau: I don't think this is helpful.
  { "<LEADER><LEADER>I", function() Fau_vim.functions.indent.toggle_indent_width(true) end, desc = "Indent: Toggle Width (Force)" },

  -- ---------- Buffer Navigation
  -- BUG: Not working.
  -- { "<A-1~9>", group = "Switch Buffer" },
  -- { "<LEADER><1~9>", group = "Switch Buffer" },

  -- ==================== Git Signs ====================
  { "<LEADER>g",  group = "Gitsigns", mode = { "n", "x" } },
  { "<LEADER>gt", group = "Gitsigns: Toggle" },
}
