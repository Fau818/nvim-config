---@class snacks.scratch.Config
return {
  enabled = true,

  name = "Snacks Scratch",
  ft = nil,  -- Use default.

  ---@type string|string[]?
  icon = nil,  -- `icon|{icon, icon_hl}`. defaults to the filetype icon
  root = nil,  -- Use default.

  autowrite = true,  -- automatically write when the buffer is hidden

  filekey = nil,  -- Use default.

  win = {
    style = "scratch",
    keys = {
      q = false,
      ["<S-q>"] = "close",
    }
  },

  ---@type table<string, snacks.win.Config>
  win_by_ft = nil,  -- Use default.
}
