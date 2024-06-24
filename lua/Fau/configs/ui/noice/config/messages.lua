---@type NoiceConfig
local messages = {
  enabled      = true,          -- enables the Noice messages UI
  view         = "notify",      -- default view for messages
  view_error   = "notify",      -- view for errors
  view_warn    = "notify",      -- view for warnings
  view_history = "messages",    -- view for :messages
  view_search  = "virtualtext", -- view for search count messages. Set to `false` to disable
}

return messages
