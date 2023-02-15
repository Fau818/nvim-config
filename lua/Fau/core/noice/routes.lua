local config = require("Fau.core.noice.config")


return {
	-- -----------------------------------
	-- -------- Cmdline
	-- -----------------------------------
	{  -- mini.align
		view = "cmdline_popup",
		filter = { event = "cmdline", find = "(mini.align)" },
	},


	-- -----------------------------------
	-- -------- Messages
	-- -----------------------------------
	{  -- mini.align
		view = "notify",
		filter = { event = "msg_show", find = "(mini.align)" },
		opts = { title = "mini.align" },
	},

	{  -- showmode
		view = "mini",
		filter = { event = "msg_showmode" },
	},

	-- bad for showing search count
	-- {
	-- 	view = config.messages.view,
	-- 	filter = { event = "msg_show" },
	-- 	opts = { title = "Messages" }
	-- },

	{
		view = config.messages.view_warn,
		filter = { warning = true },
		opts = { title = "Warning", level = vim.log.levels.WARN }
	},

	{
		view = config.messages.view_error,
		filter = { error = true },
		opts = { title = "Error", level = vim.log.levels.ERROR }
	},


	-- -----------------------------------
	-- -------- Notify
	-- -----------------------------------
	{
		view = config.notify.view,
		filter = { event = "notify" },
		opts = { title = "Notify" }
	},

	{
		view = config.notify.view,
		filter = {
			event = "noice",
			kind = { "stats", "debug" },
		},
		opts = { lang = "lua", title = "Noice", level = vim.log.levels.DEBUG },
	},

}
