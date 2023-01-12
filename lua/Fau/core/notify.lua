-- =============================================
-- ========== Plugin Loading
-- =============================================
local notify = Fau_vim.load_plugin("notify")
if notify == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	background_colour = "#D4D4D4",
	fps = 30,
	icons = {
		DEBUG = Fau_vim.icons.diagnostics.Debug,
		ERROR = Fau_vim.icons.diagnostics.BoldError,
		INFO  = Fau_vim.icons.diagnostics.BoldInformation,
		TRACE = Fau_vim.icons.diagnostics.Trace,
		WARN  = Fau_vim.icons.diagnostics.BoldWarning,
	},
	level = 2,
	minimum_width = 50,
	render = "default",  -- values: default|minimal|simple
	stages = "fade_in_slide_out",
	timeout = 1500,
	top_down = true
}

notify.setup(config)


-- replace vim.notify
vim.notify = notify
Fau_vim.notify = vim.notify
