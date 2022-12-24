-- =============================================
-- ========== Plugin Loading
-- =============================================
local surround = Fau_vim.load_plugin("nvim-surround")
if surround == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	keymaps = {
		insert = false,
		insert_line = false,
		normal = "s",
		normal_cur = "ss",
		normal_line = false,
		normal_cur_line = "S",
		visual = "s",
		visual_line = "S",
		delete = "ds",
		change = "cs",
	},
	-- aliases = {
	-- 	["a"] = ">",
	-- 	["b"] = ")",
	-- 	["B"] = "}",
	-- 	["r"] = "]",
	-- 	["q"] = { '"', "'", "`" },
	-- 	["s"] = { "}", "]", ")", ">", '"', "'", "`" },
	-- },
}


surround.setup(config)
