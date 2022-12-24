-- =============================================
-- ========== Plugin Loading
-- =============================================
local align = Fau_vim.load_plugin("mini.align")
if align == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	mappings = {
		start = "<LEADER>A",
		start_with_preview = "<LEADER>a",
	},
	modifiers = {
		["-"] = function(steps, opts)
			opts.split_pattern = " %-%- "
			table.insert(steps.pre_justify, MiniAlign.gen_step.trim())
			opts.merge_delimiter = " "
		end,
	},
}

align.setup(config)
