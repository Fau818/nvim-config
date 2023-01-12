return {
	n = {
		-- =============================================
		-- ========== Open Telescope Directly
		-- =============================================
		["<LEADER>F"] = { "<CMD>Telescope<CR>", "Telescope" },



		-- =============================================
		-- ========== Vim Pickers
		-- =============================================
		["<LEADER>f"] = {
			name = "+Telescope",
			a = { "<CMD>lua require('telescope.builtin').autocommands()<CR>", "Find Autocommands" },
			b = { "<CMD>lua require('telescope.builtin').buffers()<CR>",      "Find Buffers" },
			c = { "<CMD>lua require('telescope.builtin').commands()<CR>",     "Find Commands" },
			e = { "<CMD>Telescope emoji<CR>",                                 "Find Emoji" },
			f = { "<CMD>lua require('telescope.builtin').find_files()<CR>",   "Find Files" },
			h = { "<CMD>lua require('telescope.builtin').help_tags()<CR>",    "Find Help" },
			H = { "<CMD>lua require('telescope.builtin').highlights()<CR>",   "Find Highlights" },
			k = { "<CMD>lua require('telescope.builtin').keymaps()<CR>",      "Find Keymaps" },
			l = { "<CMD>Telescope luasnip layout_strategy=vertical<CR>",      "Find Luasnip" },
			n = { "<CMD>Telescope notify layout_strategy=vertical initial_mode=normal<CR>", "Show Notify" },
			p = { "<CMD>Telescope projects layout_strategy=center sorting_strategy=ascending initial_mode=normal<CR>", "Open Projects" },
			r = { "<CMD>lua require('telescope.builtin').oldfiles()<CR>",    "Open Recent Files" },
			s = { "<CMD>lua require('telescope.builtin').live_grep()<CR>",   "Find String" },
			S = { "<CMD>lua require('telescope.builtin').live_grep({grep_open_files=true})<CR>",   "Find String in Opened Buffers" },
			w = { "<CMD>lua require('telescope.builtin').grep_string()<CR>", "Find Word Under Cursor" },
			W = { "<CMD>lua require('telescope.builtin').grep_string({grep_open_files=true})<CR>", "Find Word Under Cursor in Opened Buffers" },
		},
	}
}
