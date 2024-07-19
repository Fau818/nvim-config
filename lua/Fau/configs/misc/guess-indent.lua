-- =============================================
-- ========== Plugin Configurations
-- =============================================
local guess_indent = require("guess-indent")

---@type GuessIndentConfig
local config = {
  auto_cmd = true,
  override_editorconfig = false,
  filetype_exclude = Fau_vim.file.excluded_filetypes,
  buftype_exclude  = Fau_vim.file.excluded_buftypes,
  on_tab_options = { ["expandtab"] = false },
  on_space_options = {
    ["expandtab"]   = true,
    ["tabstop"]     = "detected",
    ["softtabstop"] = -1,
    ["shiftwidth"]  = 0,
  },
}

guess_indent.setup(config)
