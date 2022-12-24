-- =============================================
-- ========== Plugin Loading
-- =============================================
local indent_blankline = Fau_vim.load_plugin("indent_blankline")
if indent_blankline == nil then return end



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
