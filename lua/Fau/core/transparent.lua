-- =============================================
-- ========== Plugin Loading
-- =============================================
local transparent = Fau_vim.load_plugin("transparent")
if transparent == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	enable = true,
	extra_groups = {
		"MsgArea",
		"VertSplit",

		"BufferLineFill",

		"NvimTreeNormal",
		"NvimTreeWinSeparator",
	},
	exclude = {  -- the plugin will disable the following by default.
		-- "Normal",
		-- "NormalNC",
		"Comment",
		"Constant",
		"Special",
		"Identifier",
		"Statement",
		"PreProc",
		"Type",
		"Underlined",
		"Todo",
		"String",
		"Function",
		"Conditional",
		"Repeat",
		"Operator",
		"Structure",
		"LineNr",
		"NonText",
		-- "SignColumn",
		"CursorLineNr",
	},
}


transparent.setup(config)
