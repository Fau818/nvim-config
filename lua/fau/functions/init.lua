---@type fun(msg: any, level?: vim.log.levels|integer, opts?: snacks.notifier.Notif.opts): number|string? The `snacks.notifier` id, or nil for a deferred notification.
fvim.notify = function(msg, level, opts)
  if type(msg) ~= "string" then msg = vim.inspect(msg) end
  level = level or vim.log.levels.INFO
  opts = vim.tbl_extend("keep", opts or {}, { title = "fau_vim" })

  if vim.in_fast_event() then vim.schedule(function() vim.notify(msg, level, opts) end) return end
  return vim.notify(msg, level, opts)
end

fvim.format = require("fau.functions.format")
fvim.indent = require("fau.functions.indent")
fvim.utils  = require("fau.functions.utils")
fvim.python = require("fau.functions.python")
