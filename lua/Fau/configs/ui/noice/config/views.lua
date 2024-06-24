---@type table<string, NoiceViewOptions>
local views = {
  -- -----------------------------------
  -- -------- Preset Modification
  -- -----------------------------------
  notify = {
    replace = true,
    merge = true,
    render = "minimal",
  },

  hover = {
    size = { max_width = 100 },
    border = { padding = { 0, 1 }, },
  },

  cmdline_popup = { size = { width = 60 } },

  -- TEST: Maybe not working.
  mini = { replace = true, merge = true },

  -- -----------------------------------
  -- -------- Custom
  -- -----------------------------------
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
        FloatBorder = "NoiceCmdlinePopupBorder",
        IncSearch = "",
        Search = "",
      },
      cursorline = false,
    },
  },
}


return views
