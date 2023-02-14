-- =============================================
-- ========== Plugin Loading
-- =============================================
local guess_indent_ok, guess_indent = pcall(require, "guess-indent")
if not guess_indent_ok then Fau_vim.load_plugin_error("guess-indent") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  auto_cmd = true,
  filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
    "netrw",
    "tutor",

    "NvimTree",
    "TelescopePrompt",
    "alpha",
    "aerial",
    "lspinfo",
    "toggleterm",
    "Trouble",
    "noice",
    "notify",
  },
  buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
    "help",
    "nofile",
    "terminal",
    "prompt",
  }
}



guess_indent.setup(config)
