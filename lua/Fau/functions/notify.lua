-- ==================== Notify ====================
---@param msg string|string[] Notification message
---@param level? string|number Log level. See vim.log.levels
---@param opts? notify.Options Notification options
-- TODO: 规范这个方法，Fau_vim一定是我的配置报错。
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
-- TODO: Deparecate this function after refactor all plugin loader.
Fau_vim.load_plugin_error = function(plugin)
  vim.notify(plugin .. " not found!", "ERROR", { title = "Fau_vim: Plugin Not Found" })
end


Fau_vim.table2string = function(...) return vim.inspect(...) end

Fau_vim.show = function(...) print(vim.inspect(...)) end
