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
  -- A list of filetypes for which the auto command gets disabled
  filetype_exclude = Fau_vim.disabled_filetypes,
  buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
    "help",
    "nofile",
    "terminal",
    "prompt",
  }
}


guess_indent.setup(config)
