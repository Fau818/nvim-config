---@param plugin string
-- TODO: Deparecate this function after refactor all plugin loader.
Fau_vim.load_plugin_error = function(plugin)
  Fau_vim.notify(plugin .. " not found!", vim.log.levels.ERROR)
end


Fau_vim.functions = {
  colorscheme = { setup = nil, fix_comment_hl = nil },  -- SEE: lua/Fau/plugins/editor/colorscheme/init.lua
  format      = require("Fau.functions.format"),
  indent      = require("Fau.functions.indent"),
  utils       = require("Fau.functions.utils"),
}
