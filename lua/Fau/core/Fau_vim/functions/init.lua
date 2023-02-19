-- =============================================
-- ========== Utils (Initialzation)
-- =============================================
-- -----------------------------------
-- -------- show no plugin message
-- -----------------------------------
---@param plugin string
Fau_vim.load_plugin_error = function(plugin)
  vim.notify(plugin .. " not found!", "ERROR", { title = "Fau_vim: Plugin Not Found" })
end


-- -----------------------------------
-- -------- show lua table
-- -----------------------------------
Fau_vim.table2string = function(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  return table.concat(objects, "\n")
end


Fau_vim.show = function(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
end



-- =============================================
-- ========== Additions
-- =============================================
return {
  format   = require "Fau.core.Fau_vim.functions.format",
  indent   = require "Fau.core.Fau_vim.functions.indent",
  lsp      = require "Fau.core.Fau_vim.functions.lsp",
  terminal = nil,  -- lazy load in terminal.lua file
}
