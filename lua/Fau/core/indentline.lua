-- =============================================
-- ========== Plugin Loading
-- =============================================
local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_ok then Fau_vim.load_plugin_error("indent_blankline") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  char                   = Fau_vim.icons.ui.IndentLine,
  char_blankline         = Fau_vim.icons.ui.IndentLine,
  context_char           = Fau_vim.icons.ui.IndentLine,
  context_char_blankline = Fau_vim.icons.ui.IndentLine,

  space_char_blankline = " ",

  use_treesitter = true, -- use treesitter to calculate.
  use_treesitter_scope = true, -- use treesitter to calculate current context start

  show_current_context = false, -- current indent block
  show_current_context_start = false,
  show_current_context_start_on_current_line = true,  -- need `show_current_context_start`

  show_trailing_blankline_indent = false,
  show_end_of_line = true,

  indent_level = 10, -- maximum indent level to display
  char_priority = 1,
  context_start_priority = 10000,

  filetype_exclude = {
    "", "help", "man", "checkhealth", "alpha", "NvimTree", "Trouble",
    "toggleterm", "aerial", "lspinfo", "notify", "noice", "TelescopePrompt",
    "packer", "lazy", "mason"
  },
}


indent_blankline.setup(config)
