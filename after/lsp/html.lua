---@type vim.lsp.Config
return {
  settings = {
    html = {
      format = {
        indentHandlebars = true,
        templating = true,
      },
    }
  },

  filetypes = { "html", "jinja.html", "htmldjango" }
}
