Fau_vim = {
	-- =============================================
	-- ========== utility
	-- =============================================
	notify = vim.notify,
	config_path = vim.fn.stdpath("config"),


	-- =============================================
	-- ========== function definition
	-- =============================================
	-- -----------------------------------
	-- -------- load plugin function
	-- -----------------------------------
	---@return nil|table
	load_plugin = function(plugin)
		local status_ok, instance = pcall(require, plugin)
		if not status_ok then
			---@diagnostic disable-next-line: param-type-mismatch
			vim.notify(plugin .. " not found!", "ERROR", { title = "Fau: Plugin Not Found" })
			return nil
		else return instance
		end
	end,

	-- -----------------------------------
	-- -------- show lua table
	-- -----------------------------------
	table2string = function(...)
		local objects = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			table.insert(objects, vim.inspect(v))
		end

		return table.concat(objects, "\n")
	end,

	show = function(...)
		local objects = {}
		for i = 1, select("#", ...) do
			local v = select(i, ...)
			table.insert(objects, vim.inspect(v))
		end

		print(table.concat(objects, "\n"))
	end,


	-- =============================================
	-- ========== icons definition
	-- =============================================
	kind_icons = { -- for completion
		Array = "",
		Boolean = "蘒",
		Class = "",
		Color = "",
		Constant = "",
		Constructor = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		Module = "",
		Namespace = "",
		Null = "ﳠ",
		Number = "",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
	},


	git_icons = { -- for lualine
		LineAdded = "",
		LineModified = "",
		LineRemoved = "",
		FileDeleted = "",
		FileIgnored = "◌",
		FileRenamed = "➜",
		FileStaged = "S",
		FileUnmerged = "",
		FileUnstaged = "",
		FileUntracked = "U",
		Diff = "",
		Repo = "",
		Octoface = "",
		Branch = "",
	},


	gitsigns = { -- for gitsigns
		LineLeft = "│",
		BoldLineLeft = "▎",
		Triangle = "契",
		Untracked = "┆",
	},


	diagnostics = {
		BoldError = "", Error = "",
		BoldWarning = "", Warning = "",
		BoldInformation = "", Information = "",
		BoldHint = "", Hint = "",
		-- BoldQuestion = "", Question = "",  -- unused
		Debug = "",
		Trace = "✎",
	},


	ui = {
		File = "",
		NewFile = "",
		FindFile = "",
		Project = "",
		History = "",
		FindText = "",
		-- Gear = "",

		Tab = "",
		Space = "⎵",

		DividerLeft = "", -- DividerLeft = "",
		DividerRight = "", -- DividerRight = "",
		BoldDividerLeft = "", -- BoldDividerLeft = "",
		BoldDividerRight = "", -- BoldDividerRight = "",

		ChevronRight = ">",

		Tree = "",
	},

	terminal = {}, -- will be redefined in terminal.lua file

	start = nil, -- will be defined in autocmd.lua file
	set_client_by_ft = nil, -- will be defined in lspconfig.lua file
	configured_ft = {},
}



-- =============================================
-- ========== User Commands
-- =============================================
vim.api.nvim_create_user_command("EditSnip",
	function()
		require("luasnip.loaders").edit_snippet_files {
			extend = function(ft, paths)
				if #paths == 0 then return { { ft .. ".snippets",
					string.format("%s/snippets/%s.snippets", vim.fn.stdpath("config"), ft) } } end
				return {}
			end
		}
	end, {}
)


vim.api.nvim_create_user_command("EditStyle",
	function()
		vim.api.nvim_command("edit " .. Fau_vim.config_path .. "/style")
	end, {}
)
