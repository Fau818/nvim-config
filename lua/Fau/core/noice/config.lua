---@type NoiceConfig
local config = {
  cmdline = require("Fau.core.noice.cmdline"),

  messages = require("Fau.core.noice.messages"),

  popupmenu = require("Fau.core.noice.popupmenu"),

  -- default options for require('noice').redirect
  -- see the section on Command Redirection
  ---@type NoiceRouteConfig
  redirect = { view = "popup", filter = { event = "msg_show" } },

  -- You can add any custom commands below that will be available with `:Noice command`
  ---@type table<string, NoiceCommand>
  commands = require("Fau.core.noice.commands"),

  notify = { enabled = false, view = "notify" },

  lsp = require("Fau.core.noice.lsp"),

  markdown = require("Fau.core.noice.markdown"),

  health = { checker = true },

  smart_move = {
    -- noice tries to move out of the way of existing floating windows.
    enabled = true, -- you can disable this behaviour here
    -- add any filetypes here, that shouldn't trigger smart move.
    excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
  },

  ---@type NoicePresets
  presets = require("Fau.core.noice.presets"),

  throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.

  ---@type NoiceConfigViews
  views  = require("Fau.core.noice.views"), ---@see section on views
  ---@type NoiceRouteConfig[]
  routes = require("Fau.core.noice.routes"), --- @see section on routes
  ---@type table<string, NoiceFilter>
  status = {}, --- @see section on statusline components
  ---@type NoiceFormatOptions
  format = {}, --- @see section on formatting
}


return config
