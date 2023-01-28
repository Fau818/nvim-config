-- =============================================
-- ========== Plugin Loading
-- =============================================
local notify_ok, notify = pcall(require, "notify")
if not notify_ok then Fau_vim.load_plugin_error("notify") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	background_colour = "#000000",
	fps = 60,
	icons = {
		DEBUG = Fau_vim.icons.diagnostics.Debug,
		ERROR = Fau_vim.icons.diagnostics.BoldError,
		INFO  = Fau_vim.icons.diagnostics.BoldInformation,
		TRACE = Fau_vim.icons.diagnostics.Trace,
		WARN  = Fau_vim.icons.diagnostics.BoldWarning,
	},
	level = 2,
	minimum_width = 35,
	render = "default",  -- values: default|minimal|simple
	stages = "fade_in_slide_out",  -- values: fade_in_slide_out|fade|slide|static
	timeout = 1000,
	top_down = true
}


notify.setup(config)

-- replace vim.notify
vim.notify = notify
