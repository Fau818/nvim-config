-- NOTE: This is a annotation file for `Fau_vim.keymaps` with a spot of additional overwrite and new key bindings.

return {
  n = {
    -- ==================== Whichkey Ignore ====================
    ["<MouseMove>"] = "which_key_ignore",
    ["<A-CR>"]      = "which_key_ignore",

    -- ==================== Yank and Paste ====================
    y = "Yank with System Clipboard",
    Y = "Yank Line with System Clipboard",
    p = "Paste from System Clipboard",
    P = "PASTE from System Clipboard",

    -- ==================== Override ====================
    ["<A-q>"]     = { Fau_vim.functions.utils.buf_remove, "Close Current Buffer" },

    -- ==================== Fau_vim Custom ====================
    -- ---------- Edit Configuration and Snippet
    ["<LEADER>E"] = {
      name = "+Edit",
      ["c"] = { "<CMD>EditConfiguration<CR>", "Edit Configuration" },
      ["s"] = { "<CMD>EditSnip<CR>",          "Edit Snippet" },
    },

    -- ---------- Lazy
    ["<LEADER>ll"] = { require("lazy").home, "Open Lazy (Plugin Manager)" },

    -- ---------- Toggle Indent
    ["<LEADER><LEADER>i"] = { Fau_vim.functions.indent.toggle_indent_width, "Toggle Indent Width" },
    -- Fau: I don't think this is helpful.
    ["<LEADER><LEADER>I"] = { function() Fau_vim.functions.indent.toggle_indent_width(true) end, "Toggle Indent Width (Force)" },

    -- TODO: Init in Noice (FIXME)
    -- ["<C-f>"] = { Fau_vim.functions.utils.reveal_in_system, "Reveal File" },


    -- -----------------------------------
    -- -------- Buffer Navigation
    -- -----------------------------------
    -- BUG: Not working.
    ["<A-1~9>"]       = "Switch to Buffer <1~9>",
    ["<LEADER><1~9>"] = "Switch to Buffer <1~9>",
  },

}
