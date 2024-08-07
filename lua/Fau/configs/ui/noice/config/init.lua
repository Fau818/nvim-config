local noice = require("noice")

---@type NoiceConfig
local config = {
  cmdline   = require("Fau.configs.ui.noice.config.cmdline"),
  messages  = require("Fau.configs.ui.noice.config.messages"),
  popupmenu = require("Fau.configs.ui.noice.config.popupmenu"),

  -- default options for require('noice').redirect
  -- see the section on Command Redirection
  ---@type NoiceRouteConfig
  redirect = { view = "popup", filter = { event = "msg_show" } },

  -- You can add any custom commands below that will be available with `:Noice command`
  ---@type table<string, NoiceCommand>
  commands = nil,  -- Use default commands.

  notify = { enabled = false, view = "notify" },

  lsp = require("Fau.configs.ui.noice.config.lsp"),

  markdown = require("Fau.configs.ui.noice.config.markdown"),

  health = { checker = true },

  ---@type NoicePresets
  presets = require("Fau.configs.ui.noice.config.presets"),

  throttle = 1000 / 60,

  ---@type NoiceConfigViews
  views = require("Fau.configs.ui.noice.config.views"),  ---@see section on views
  ---@type NoiceRouteConfig[]
  routes = require("Fau.configs.ui.noice.config.routes"),  ---@see section on routes
  ---@type table<string, NoiceFilter>
  status = nil,  ---@see section on statusline components
  ---@type NoiceFormatOptions
  format = nil,  ---@see section on formatting
}

noice.setup(config)
