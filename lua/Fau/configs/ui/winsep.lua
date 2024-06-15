-- =============================================
-- ========== Plugin Configurations
-- =============================================
local winsep = require("colorful-winsep")

local config = {
  -- highlight for Window separator
  highlight = { bg = nil, fg = Fau_vim.colors.dark_purple },
  -- timer refresh rate
  interval = 1000,
  -- This plugin will not be activated for filetype in the following table.
  no_exec_files = nil,
  -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
  symbols = nil,  -- Use default symbols
  smooth = true,
  exponential_smoothing = true,
  anchor = nil,  -- Use default anchor
}

winsep.setup(config)
