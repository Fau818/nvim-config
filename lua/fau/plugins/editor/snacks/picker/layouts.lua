---@type table<string, snacks.picker.layout.Config>
return {
  -- ==================== Presets ====================
  default = {
    layout = {
      box = "horizontal",
      width = 0.8,
      min_width = 100,
      height = 0.8,
      {
        box = "vertical",
        border = true,
        title = "{title} {live} {flags}",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
      },
      { win = "preview", title = "{preview}", border = true, width = 0.6 },
    },
  },

  dropdown = {
    layout = {
      backdrop = false,
      width = 0.8,
      min_width = 50,
      height = 0.85,
      box = "vertical",
      { win = "preview", title = "{preview}", height = 0.6, border = true },
      {
        box = "vertical",
        border = true,
        title = "{title} {live} {flags}",
        title_pos = "center",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
      },
    },
  },

  ivy = { layout = { height = 0.2 } },
  vscode = { layout = { height = 0.25 } },
  select = { layout = { width = 0.35, min_width = 50, max_width = 80, height = 0.25, min_height = 3 } },
  telescope = { layout = { height = 0.8 } },


  -- ==================== Custom ====================
  main = {
    preview = "main",
    layout = {
      backdrop = false,
      row = 1,
      width = 0.4,
      min_width = 80,
      height = 0.2,
      border = "none",
      box = "vertical",
      { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
      { win = "list", border = "hpad", height = 0.5 },
      { win = "preview", title = "{preview}", border = true },
    },
  },

  stack_rev = {
    reverse = true,
    layout = {
      box = "horizontal",
      width = 0.8,
      height = 0.8,
      {
        box = "vertical",
        { win = "preview", title = "{preview:Preview}", height = 0.65, border = true, title_pos = "center" },
        { win = "list", title = " Results ", title_pos = "center", border = true },
        { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
      },
    },
  },

  stack = {
    layout = {
      box = "horizontal",
      width = 0.8,
      height = 0.65,
      {
        box = "vertical",
        { win = "input", height = 1, border = true, title = "{title} {live} {flags}", title_pos = "center" },
        { win = "list", title = " Results ", title_pos = "center", border = true },
        { win = "preview", title = "{preview:Preview}", height = 0.65, border = true, title_pos = "center" },
      },
    },
  },

}
