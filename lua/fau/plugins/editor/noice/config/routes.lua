---@module "noice"
---@type NoiceRouteConfig[]
return {
  -- ==================== Basic Info ====================
  {
    view = "notify",
    filter = { warning = true },
    opts = { title = "Warning", level = vim.log.levels.WARN }
  },

  {
    view = "notify",
    filter = { error = true },
    opts = { title = "Error", level = vim.log.levels.ERROR }
  },

  -- Show `@recoring` Messages
  {
    view = "mini",
    filter = { event = "msg_showmode" },  -- show @recording
  },


  -- ==================== Mini Align ====================
  {
    view = "notify",
    filter = { event = "msg_show", find = "(mini.align)" },
    opts = { title = "mini.align" },
  }
}
