-- =============================================
-- ========== Plugin Loading
-- =============================================
local paint = Fau_vim.load_plugin("paint")
if paint == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	---@type PaintHighlight[]
	highlights = {
		{
			-- filter can be a table of buffer options that should match,
			-- or a function called with buf as param that should return true.
			-- The example below will paint @something in comments with Constant
			filter = { filetype = "lua" },
			pattern = "%s*%-%-%-%s*(@%w+)",
			hl = "Constant"
		},

		-- {
		-- 	filter = { filetype = "lua" },
		-- 	pattern = "%s*%-%-%-%s*@%w+ ([%w_]+%[*%]*)",
		-- 	hl = "@parameter",
		-- },



		{
			filter = { filetype = "python" },
			pattern = "%s*([%w_]+ :)",
			hl = "@parameter",
		},


		{
			filter = { filetype = "python" },
			pattern = "Parameters",
			hl = "Identifier",
		},

		{
			filter = { filetype = "python" },
			pattern = "Returns",
			hl = "Identifier",
		},

		-- {
		-- 	filter = { filetype = "python" },
		-- 	pattern = "-----+",
		-- 	hl = "Identifier",
		-- },

	},
}


paint.setup(config)
