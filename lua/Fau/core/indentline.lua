-- =============================================
-- ========== Plugin Loading
-- =============================================
local indent_blankline_ok, indent_blankline = pcall(require, "ibl")
if not indent_blankline_ok then Fau_vim.load_plugin_error("indent_blankline") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  enabled = true,
  debounce = 200,

  indent = {
    char = Fau_vim.icons.ui.IndentLine,
    smart_indent_cap = true,
  },

  -- viewport_buffer = {},
  whitespace = {},
  scope = { enabled = false },

  exclude = { filetypes = Fau_vim.file.excluded_filetypes },
}


indent_blankline.setup(config)
