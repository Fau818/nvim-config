-- =============================================
-- ========== Plugin Loading
-- =============================================
local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_ok then Fau_vim.load_plugin_error("indent_blankline") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	char = "▏", -- "▎"

	use_treesitter = true, -- use treesitter to calculate.
	use_treesitter_scope = true, -- use treesitter to calculate current context start

	show_current_context = true, -- current indent block
	show_current_context_start = false,

	show_trailing_blankline_indent = false,
}


indent_blankline.setup(config)
