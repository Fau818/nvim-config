require("Fau.functions.notify")

Fau_vim.functions = {
  colorscheme = { setup = nil, fix_comment_hl = nil },  -- SEE: lua/Fau/plugins/editor/colorscheme/init.lua
  format      = require("Fau.functions.format"),
  indent      = require("Fau.functions.indent"),
  utils       = require("Fau.functions.utils"),
}
