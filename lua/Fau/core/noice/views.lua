return {
	virtualtext = {
		backend = "virtualtext",
		format = { "{message}" },
		hl_group = "NoiceVirtualText",
	},


	notify = {
		backend = "notify",
		fallback = "mini",
		format = "notify",
		replace = true,
		merge = true,

		-- stages = "fade_in_slide_out",
		render = "minimal",
	},


	split = {
		backend = "split",
		enter = false,
		relative = "editor",
		position = "bottom",
		size = "20%",
		close = {
			keys = { "q" },
		},
		win_options = {
			winhighlight = { Normal = "NoiceSplit", FloatBorder = "NoiceSplitBorder" },
			wrap = true,
		},
	},

	vsplit = {
		view = "split",
		position = "right",
	},

	cmdline_output = {
		format = "details",
		view = "split",
	},

	messages = {
		view = "split",
		enter = true,
	},


	popup = {
		backend = "popup",
		relative = "editor",
		close = {
			events = { "BufLeave" },
			keys = { "q" },
		},
		enter = true,
		border = {
			style = "rounded",
			padding = { 0, 0 },
		},
		position = "50%",
		size = {
			width = "120",
			height = "20",
		},
		win_options = {
			winhighlight = { Normal = "NoicePopup", FloatBorder = "NoicePopupBorder" },
		},
	},

	hover = {
		view = "popup",
		relative = "cursor",
		zindex = 45,
		enter = false,
		anchor = "auto",
		size = {
			width = "auto",
			height = "auto",
			max_height = 20,
			max_width = 100,
		},
		border = {
			style = "rounded",
			padding = { 0, 1 },
		},
		position = { row = 1, col = 0 },
		win_options = {
			wrap = true,
			linebreak = true,
		},
	},


	cmdline = {
		backend = "popup",
		relative = "editor",
		position = {
			row = "100%",
			col = 0,
		},
		size = {
			height = "auto",
			width = "100%",
		},
		border = {
			style = "none",
		},
		win_options = {
			winhighlight = {
				Normal = "NoiceCmdline",
				IncSearch = "",
				Search = "",
			},
		},
	},


	mini = {
		backend = "mini",
		relative = "editor",
		align = "message-right",
		timeout = 2000,
		reverse = true,
		focusable = false,
		position = {
			row = -1,
			col = "100%",
		},
		size = "auto",
		border = {
			style = "none",
		},
		zindex = 60,
		win_options = {
			winblend = 0,
			winhighlight = {
				Normal = "NoiceMini",
				IncSearch = "",
				Search = "",
			},
		},
	},


	cmdline_popup = {
		backend = "popup",
		relative = "editor",
		focusable = false,
		enter = false,
		zindex = 60,
		position = {
			row = "50%",
			col = "50%",
		},
		size = {
			width = 60,
			height = "auto",
		},
		border = {
			style = "rounded",
			padding = { 0, 1 },
		},
		win_options = {
			winhighlight = {
				Normal = "NoiceCmdlinePopup",
				FloatBorder = "NoiceCmdlinePopupBorder",
				IncSearch = "",
				Search = "",
			},
			cursorline = false,
			wrap = false,
			linebreak = false,
		},
	},

	confirm = {
		backend = "popup",
		relative = "editor",
		focusable = false,
		align = "center",
		enter = false,
		zindex = 60,
		format = { "{confirm}" },
		position = {
			row = "50%",
			col = "50%",
		},
		size = "auto",
		border = {
			style = "rounded",
			padding = { 0, 1 },
			text = {
				top = " Confirm ",
			},
		},
		win_options = {
			winhighlight = {
				Normal = "NoiceConfirm",
				FloatBorder = "NoiceConfirmBorder",
			},
		},
	},


	popupmenu = {
		relative = "editor",
		zindex = 65,
		position = "auto", -- when auto, then it will be positioned to the cmdline or cursor
		size = {
			width = "auto",
			height = "auto",
			max_height = 20,
		},
		win_options = {
			cursorline = true,
			cursorlineopt = "line",
			winhighlight = {
				Normal = "NoicePopupmenu", -- change to NormalFloat to make it look like other floats
				FloatBorder = "NoicePopupmenuBorder", -- border highlight
				CursorLine = "NoicePopupmenuSelected", -- used for highlighting the selected item
				PmenuMatch = "NoicePopupmenuMatch", -- used to highlight the part of the item that matches the input
			},
		},
		border = {
			style = "rounded",
			padding = { 0, 1 },
		},
	},



	-- -----------------------------------
	-- -------- Custom
	-- -----------------------------------
	cmdline_popup_top = {
		backend = "popup",
		relative = "editor",
		focusable = false,
		enter = false,
		zindex = 60,
		position = {
			row = 3,
			col = "50%",
		},
		size = {
			width = 60,
			height = "auto",
		},
		border = {
			style = "rounded",
			padding = { 0, 1 },
		},
		win_options = {
			winhighlight = {
				Normal = "NoiceCmdlinePopup",
				FloatBorder = "NoiceCmdlinePopupBorder",
				IncSearch = "",
				Search = "",
			},
			cursorline = false,
		},
	},


}
