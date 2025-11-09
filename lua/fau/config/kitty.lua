local M = {}


M.is_enabled = vim.env.TERM == "xterm-kitty" or vim.env.KITTY_PID ~= nil


local set_in_editor_var = "\x1b]1337;SetUserVar=in_editor=MQo\007"
local unset_in_editor_var = "\x1b]1337;SetUserVar=in_editor\007"

function M.activate_in_editor()
  if not M.is_enabled then return end
  if vim.api.nvim_ui_send then vim.api.nvim_ui_send(set_in_editor_var)
  else io.stdout:write(set_in_editor_var)
  end
end


function M.deactivate_in_editor()
  if not M.is_enabled then return end
  if vim.api.nvim_ui_send then vim.api.nvim_ui_send(unset_in_editor_var)
  else io.stdout:write(unset_in_editor_var)
  end
end


return M
