-- =============================================
-- ========== Plugin Loading
-- =============================================
local gitsigns = Fau_vim.load_plugin("gitsigns")
if gitsigns == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	signs = {
		add = {
			hl = "GitSignsAdd",
			text = Fau_vim.gitsigns.BoldLineLeft,
			numhl = "GitSignsAddNr",
			linehl = "GitSignsAddLn",
			show_count = true
		},
		change = {
			hl = "GitSignsChange",
			text = Fau_vim.gitsigns.BoldLineLeft,
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
			show_count = true
		},
		delete = {
			hl = "GitSignsDelete",
			text = Fau_vim.gitsigns.Triangle,
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn"
		},
		topdelete = {
			hl = "GitSignsDelete",
			text = Fau_vim.gitsigns.Triangle,
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn"
		},
		changedelete = {
			hl = "GitSignsChange",
			text = Fau_vim.gitsigns.BoldLineLeft,
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn"
		},
		untracked = {
			hl = "GitSignsAdd",
			text = Fau_vim.gitsigns.Untracked,
			numhl = "GitSignsAddNr",
			linehl = "GitSignsAddLn"
		},
	},

	count_chars = {
		[1] = "¹",   -- '1'  '₁'
		[2] = "²",   -- '2'  '₂'
		[3] = "³",   -- '3'  '₃'
		[4] = "⁴",   -- '4'  '₄'
		[5] = "⁵",   -- '5'  '₅'
		[6] = "⁶",   -- '6'  '₆'
		[7] = "⁷",   -- '7'  '₇'
		[8] = "⁸",   -- '8'  '₈'
		[9] = "⁹",   -- '9'  '₉'
		["+"] = "+", -- '>'  '₊'
	},

	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`

	watch_gitdir = {
		enable = true,
		interval = 1000,
		follow_files = true, -- If a file is moved with `git mv`, switch the buffer to the new location.
	},

	attach_to_untracked = true, -- Attach to untracked files.

	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		virt_text_priority = 100,
		delay = 1000,
		ignore_whitespace = true, -- whether to ignore the whitespace when checking
	},
	current_line_blame_formatter = "<author>, <author_time:%Y/%m/%d>, <committer_time:%H:%M> • <summary>",

	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil,  -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)

	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1
	},
	yadm = { enable = false },
}


gitsigns.setup(config)
