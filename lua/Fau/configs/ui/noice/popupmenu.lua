---@type NoiceConfig
local popupmenu = {
  enabled = false,  -- enables the Noice popupmenu UI
  ---@type "nui"|"cmp"
  backend = "nui",  -- backend to use to show regular cmdline completions
  ---@type NoicePopupmenuItemKind|false
  -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
  kind_icons = Fau_vim.icons.kind,  -- set to `false` to disable icons
}

return popupmenu
