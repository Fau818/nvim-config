---@type NoiceConfig
return {
  enabled = true,          -- enables the Noice cmdline UI
  view = "cmdline_popup",  -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
  opts = {},               -- global options for the cmdline. See section on views
  ---@type table<string, CmdlineFormat>
  format = {
    cmdline = { pattern = "^:", icon = fvim.icons.ui.Input, lang = "vim" },
    filter = { title = " ZSH ", pattern = "^:%s*!", icon = fvim.icons.ui.Terminal, lang = "bash" },
    help = { pattern = "^:%s*he?l?p?%s+", icon = fvim.icons.ui.Help, lang = "vim" },
    calculator = { title = "Calculator", pattern = "^:%s*=", icon = fvim.icons.ui.Calculator, lang = "vimnormal" },
    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = fvim.icons.ui.Lua, lang = "lua" },

    search_down = {
      view = "cmdline_popup_top",
      kind = "search",
      pattern = "^/",
      icon = ("%s %s"):format(fvim.icons.ui.Search, fvim.icons.ui.LookDown),
      lang = "regex",
    },
    search_up = {
      view = "cmdline_popup_top",
      kind = "search",
      pattern = "^%?",
      icon = ("%s %s"):format(fvim.icons.ui.Search, fvim.icons.ui.LookUp),
      lang = "regex",
    },

    input = { icon = fvim.icons.ui.Input, lang = "regex" },
  },
}
