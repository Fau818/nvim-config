local config = require("Fau.core.noice.config")


return {
	-- -----------------------------------
	-- -------- Cmdline
	-- -----------------------------------
	{
		view = "cmdline_popup_top",
		opts = { enter = true },  -- BUG: waiting for a fix
		filter = { event = "cmdline", find = "(mini.align)" },
	},


	-- -----------------------------------
	-- -------- Messages
	-- -----------------------------------
	{
		view = "notify",
		filter = { find = "(mini.align)" },
		opts = { title = "mini.align" },
	},

	{
		view = config.messages.view,
		filter = {
			event = "msg_show",
			kind = { "", "echo", "echomsg" },
		},
		opts = { title = "Messages" }
	},

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
		opts = { lang = "lua", title = "Noice" },
	},


}
