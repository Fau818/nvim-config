require("Fau.core.Fau_vim.functions.notify")

Fau_vim.functions = {
  colorscheme = { setup = nil, fix_comment_hl = nil },  -- SEE: lua/Fau/plugins/editor/colorscheme/init.lua
  format = require("Fau.core.Fau_vim.functions.format"),
  indent = require("Fau.core.Fau_vim.functions.indent"),
  lsp    = require("Fau.core.Fau_vim.functions.lsp"),
  utils  = require("Fau.core.Fau_vim.functions.utils"),
  test   = require("Fau.core.Fau_vim.functions.test"),
}
