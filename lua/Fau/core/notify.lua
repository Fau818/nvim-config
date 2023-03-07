-- =============================================
-- ========== Plugin Loading
-- =============================================
local notify_ok, notify = pcall(require, "notify")
if not notify_ok then Fau_vim.load_plugin_error("notify") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type notify.Config
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
  level = 0,
  minimum_width = 30,
  render = "default",  -- values: default|minimal|simple
  stages = "fade_in_slide_out",  -- values: fade_in_slide_out|fade|slide|static
  timeout = 750,
  top_down = true
}


notify.setup(config)


--- use notify to replace vim.notify
---@param msg string
---@param level string|number|nil
---@param opts table<string, any>|nil
vim.notify = function(msg, level, opts)
  level = level or vim.log.levels.INFO
  if not opts then opts = { title = "Fau_vim" }
  elseif not opts.title or opts.title == "" then opts.title = "Fau_vim"
  end
  notify(msg, level, opts)
end
