---@module "noice"
---@type table<string, NoiceViewOptions>
local views = {
  -- ==================== Preset Modification ====================
  notify = { replace = true, merge = true },

  hover = {
    size = { max_width = 100 },
    border = { style = "rounded", padding = { 0, 1 } },
    position = { row = 2, col = 2 },
  },

  cmdline_popup = { size = { width = 60 } },

  mini = { timeout = 500, replace = true, merge = true },


  -- ==================== Custom ====================
  cmdline_popup_top = { view = "cmdline_popup", position = { row = 3, col = "50%" } },
}


return views
