---@type fun(msg: any, level?: vim.log.levels|integer, opts?: snacks.notifier.Notif.opts)
fvim.notify = vim.schedule_wrap(function(msg, level, opts)
  if type(msg) ~= "string" then msg = vim.inspect(msg) end
  level = level or vim.log.levels.INFO
  opts = vim.tbl_extend("keep", opts or {}, { title = "fau_vim" })
  vim.notify(msg, level, opts)
end)

fvim.format = require("fau.functions.format")
fvim.indent = require("fau.functions.indent")
fvim.utils  = require("fau.functions.utils")
