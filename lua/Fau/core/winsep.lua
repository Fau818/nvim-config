-- =============================================
-- ========== Plugin Loading
-- =============================================
local winsep_ok, winsep = pcall(require, "colorful-winsep")
if not winsep_ok then Fau_vim.load_plugin_error("colorful-winsep") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  -- highlight for Window separator
  highlight = {
    bg = nil,
    fg = Fau_vim.colors.dark_purple,
  },

  -- timer refresh rate
  interval = 1000,

  -- This plugin will not be activated for filetype in the following table.
  no_exec_files = Fau_vim.disabled_filetypes,

  -- Symbols for separator lines, the order: horizontal, vertical, top left, top right, bottom left, bottom right.
  symbols = { "━", "┃", "┏", "┓", "┗", "┛" },

  -- close_event  = function() end,
  -- create_event = function() end,
}


winsep.setup(config)
