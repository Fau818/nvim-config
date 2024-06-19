-- =============================================
-- ========== Plugin Configurations
-- =============================================
local notify = require("notify")

---@type notify.Config
local config = {
  level = vim.log.levels.INFO,
  background_colour = "#000000",
  timeout = 1000,
  fps = 60,

  -- max_width = nil,
  -- max_height = nil,
  minimum_width = 30,

  -- time_formats = nil,
  render = "default",  ---@type "default"|"minimal"|"simple"
  stages = "fade_in_slide_out",  ---@type "fade_in_slide_out"|"fade"|"slide"|"static"
  top_down = true,

  -- on_open = nil,
  -- on_close = nil,

  icons = {
    DEBUG = Fau_vim.icons.diagnostics.Debug,
    ERROR = Fau_vim.icons.diagnostics.BoldError,
    INFO  = Fau_vim.icons.diagnostics.BoldInfo,
    TRACE = Fau_vim.icons.diagnostics.Trace,
    WARN  = Fau_vim.icons.diagnostics.BoldWarning,
  },
}

notify.setup(config)


-- -----------------------------------
-- -------- Global Notify
-- -----------------------------------
--- use notify to replace vim.notify
---@param msg string
---@param level string|number|nil
---@param opts notify.Options|nil
---@diagnostic disable-next-line: duplicate-set-field
vim.notify = function(msg, level, opts)
  level = level or vim.log.levels.INFO
  if not opts then opts = { title = "Fau_vim" }
  elseif not opts.title or opts.title == "" then opts.title = "Fau_vim"
  end
  notify(msg, level, opts)
end
