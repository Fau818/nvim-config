return {
	enabled = true, -- enables the Noice cmdline UI
	view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
	opts = {}, -- global options for the cmdline. See section on views
	---@type table<string, CmdlineFormat>
	format = {
		cmdline = {
			-- conceal = true,
			-- view = "",
			-- opts = {},
			-- icon_hl_group = "",
			-- title = " WTF ",
			pattern = "^:",
			icon = Fau_vim.icons.ui.Input,
			lang = "vim"
		},
		search_down = {
			view = "cmdline_popup_top",
			kind = "search",
			pattern = "^/",
			icon = Fau_vim.icons.ui.Search .. " " .. Fau_vim.icons.ui.LookDown,
			lang = "regex"
		},
		search_up = {
			view = "cmdline_popup_top",
			kind = "search",
			pattern = "^%?",
			icon = Fau_vim.icons.ui.Search .. " " .. Fau_vim.icons.ui.LookUp,
			lang = "regex"
		},
		zsh = {
			pattern = "^:%s*!",
			icon = Fau_vim.icons.ui.Terminal,
			lang = "bash"
		},
		lua = {
			pattern = "^:%s*lua%s+",
			icon = Fau_vim.icons.filetype.Lua,
			lang = "lua"
		},
		help = {
			pattern = "^:%s*he?l?p?%s+",
			icon = Fau_vim.icons.ui.Help,
			lang = "vim"
		},
		input = {
			icon = Fau_vim.icons.ui.Input,
			lang = "regex",
		},
	},
}
