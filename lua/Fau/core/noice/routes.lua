local config = require("noice.config").defaults()


---@type NoiceRouteConfig[]
local routes = {
  -- -----------------------------------
  -- -------- Basic Info
  -- -----------------------------------
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
  -- -------- Mini Align
  -- -----------------------------------
  {
    view = "notify",
    filter = { event = "msg_show", find = "(mini.align)" },
    opts = { title = "mini.align" },
  },

}


return routes
