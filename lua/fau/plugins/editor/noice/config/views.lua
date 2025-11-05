---@type table<string, NoiceViewOptions>
local views = {
  -- ==================== Preset Modification ====================
  notify = { replace = true, merge = true, render = "minimal" },

  hover = {
    size = { max_width = 100 },
    border = { style = "rounded", padding = { 0, 1 } },
    position = { row = 2, col = 2 },
  },

  cmdline_popup = { zindex = 60, size = { width = 60 } },

  mini = { timeout = 500, replace = true, merge = true },


  -- ==================== Custom ====================
  cmdline_popup_top = {
    backend = "popup",
    relative = "editor",
    focusable = false,
    enter = false,
    zindex = 60,
    position = { row = 3, col = "50%" },
    size = { width = 60, height = "auto" },
    border = { style = "rounded", padding = { 0, 1 } },
    win_options = {
      winhighlight = {
        Normal = "NoiceCmdlinePopup",
        FloatTitle = "NoiceCmdlinePopupTitle",
        FloatBorder = "NoiceCmdlinePopupBorder",
        IncSearch = "",
        CurSearch = "",
        Search = "",
      },
      winbar = "",
      cursorline = false,
      foldenable = false,
    },
  },
}


return views
