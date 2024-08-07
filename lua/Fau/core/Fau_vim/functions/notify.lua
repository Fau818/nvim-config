-- =============================================
-- ========== Functions: Notify
-- =============================================
-- -----------------------------------
-- -------- Notify
-- -----------------------------------
---@param msg string
---@param level string|number|nil
---@param opts table|notify.Options|nil
Fau_vim.notify = function(msg, level, opts)
  level = level or vim.log.levels.INFO
  if not opts then opts = { title = "Fau_vim" }
  elseif not opts.title or opts.title == "" then opts.title = "Fau_vim"
  end
  vim.notify(msg, level, opts)
end


-- -----------------------------------
-- -------- Show No Plugin Message
-- -----------------------------------
---@param plugin string
Fau_vim.load_plugin_error = function(plugin)
  vim.notify(plugin .. " not found!", "ERROR", { title = "Fau_vim: Plugin Not Found" })
end


-- -----------------------------------
-- -------- Show Lua Table
-- -----------------------------------
Fau_vim.table2string = function(...)
  return vim.inspect(...)
  -- local objects = {}
  -- for i = 1, select("#", ...) do
  --   local v = select(i, ...)
  --   table.insert(objects, vim.inspect(v))
  -- end
  -- return table.concat(objects, "\n")
end

Fau_vim.show = function(...)
  -- local objects = {}
  -- for i = 1, select("#", ...) do
  --   local v = select(i, ...)
  --   table.insert(objects, vim.inspect(v))
  -- end
  -- print(table.concat(objects, "\n"))
  print(vim.inspect(...))
end
