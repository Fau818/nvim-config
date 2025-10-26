---@class snacks.notifier.Config
return {
  enabled = true,

  timeout = 3000,
  width = { min = 40, max = 0.4 },
  height = { min = 1, max = 0.6 },
  margin = { top = 0, right = 1, bottom = 0 },
  padding = true,  -- add 1 cell of left/right padding to the notification window.
  gap = 0,         -- gap between notifications

  sort = { "level", "added" },  -- sort by level and time
  level = vim.log.levels.TRACE,  -- minimum log level to display.

  icons = nil,  -- Use default.
  keep  = nil,  -- Use default.

  style = "compact",  ---@type snacks.notifier.style
  top_down = true,    -- place notifications from top to bottom

  date_format = nil,  -- Use default.
  more_format = nil,  -- Use default.
  refresh = nil,  -- Use default.
}
