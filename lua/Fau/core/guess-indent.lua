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
  filetype_exclude = Fau_vim.file.disabled_filetypes,
  buftype_exclude = {  -- A list of buffer types for which the auto command gets disabled
    "help",
    "nofile",
    "terminal",
    "prompt",
  },
  on_tab_options = { ["expandtab"] = false },
  on_space_options = {  -- A table of vim options when spaces are detected
    ["expandtab"]   = true,
    ["tabstop"]     = "detected",
    ["softtabstop"] = -1,
    ["shiftwidth"]  = 0,
  },
}


guess_indent.setup(config)
