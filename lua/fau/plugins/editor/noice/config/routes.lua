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


  -- ==================== Mini Align ====================
  {
    view = "notify",
    filter = { event = "msg_show", find = "(mini%.align)" },
    opts = { title = "mini.align", timeout = 0, replace = true, merge = true },
  }
}
