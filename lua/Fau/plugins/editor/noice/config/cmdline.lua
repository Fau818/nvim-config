---@type NoiceConfig
return {
  enabled = true,          -- enables the Noice cmdline UI
  view = "cmdline_popup",  -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
  opts = {},               -- global options for the cmdline. See section on views
  ---@type table<string, CmdlineFormat>
  format = {
    cmdline = { pattern = "^:", icon = Fau_vim.icons.ui.Input, lang = "vim" },
    filter = { title = " ZSH ", pattern = "^:%s*!", icon = Fau_vim.icons.ui.Terminal, lang = "bash" },
    help = { pattern = "^:%s*he?l?p?%s+", icon = Fau_vim.icons.ui.Help, lang = "vim" },
    calculator = { title = "Calculator", pattern = "^:%s*=", icon = Fau_vim.icons.ui.Calculator, lang = "vimnormal" },
    lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = Fau_vim.icons.ui.Lua, lang = "lua" },

    search_down = {
      view = "cmdline_popup_top",
      kind = "search",
      pattern = "^/",
      icon = ("%s %s"):format(Fau_vim.icons.ui.Search, Fau_vim.icons.ui.LookDown),
      lang = "regex",
    },
    search_up = {
      view = "cmdline_popup_top",
      kind = "search",
      pattern = "^%?",
      icon = ("%s %s"):format(Fau_vim.icons.ui.Search, Fau_vim.icons.ui.LookUp),
      lang = "regex",
    },

    input = { icon = Fau_vim.icons.ui.Input, lang = "regex" },
  },
}
