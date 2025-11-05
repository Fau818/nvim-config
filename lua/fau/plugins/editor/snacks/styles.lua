---@type table<string, snacks.win.Config>
return {
  -- ==================== Module-based ====================
  blame_line = {},

  dashboard = { wo = { foldenable = false } },

  lazygit = {
    width  = 99999999999,
    height = 99999999999,
    border = "none",
    keys = { q = false },
  },

  notification = {},
  notification_history = {},

  scratch = {},

  snacks_image = {},

  terminal = { position = "float", border = "rounded" },

  zen = {},
  zoom_indicator = {},


  -- ==================== Universal ====================
  input = { b = { completion = true }, wo = { foldenable = false } },

  help = {},

  minimal = { wo = { foldenable = false } },
  float = {},
  split = {},
}
