local M = {}

M.in_kitty = vim.env.TERM == "xterm-kitty" or vim.env.KITTY_PID ~= nil

local function send(seq)
  if vim.api.nvim_ui_send then vim.api.nvim_ui_send(seq)
  else io.stdout:write(seq)
  end
end

-- ═══════════════════════ Keymappings ════════════════════════

local set_in_editor_var = "\x1b]1337;SetUserVar=in_editor=MQo\007"
local unset_in_editor_var = "\x1b]1337;SetUserVar=in_editor\007"


function M.activate_in_editor()
  if M.in_kitty then send(set_in_editor_var) end
end


function M.deactivate_in_editor()
  if M.in_kitty then send(unset_in_editor_var) end
end


-- ═══════════════════════ Remote Open ════════════════════════

-- NOTE: `SSH_CONNECTION` as well, because tmux leaves a stale `SSH_TTY` behind in the panes it opens later.
local in_ssh = (vim.env.SSH_TTY or vim.env.SSH_CONNECTION or "") ~= ""
local is_remote = M.in_kitty and in_ssh
local fallback = vim.ui.open


---Open a uri through kitty on the local machine when over ssh, otherwise with `vim.ui.open`.
---@param path string
---@param opt? table forwarded to `vim.ui.open`.
---@return vim.SystemObj? cmd nil when kitty opens it.
---@return string? err
function M.open(path, opt)
  if not (is_remote and (path:find("^%w+://") or path:find("^mailto:"))) then return fallback(path, opt) end

  -- Claim an old version: kitty rejects anything newer than itself, and this side cannot see which kitty it is.
  -- `no_response`, or the reply arrives as keystrokes. `open_url` is kitty's own opener, so it stays platform correct.
  -- IMPO: Needs `remote_control_password "" action` in `kitty.conf`.
  local request = vim.json.encode({
    cmd = "action", version = { 0, 30, 0 }, no_response = true,
    payload = { action = "open_url " .. path },
  })
  send("\x1bP@kitty-cmd" .. request .. "\x1b\\")
end


if is_remote then
  vim.ui.open = M.open

  -- lazy.nvim opens uris with its own job instead of `vim.ui.open`.
  local LazyUtil = require("lazy.util")
  local _lazy_open = LazyUtil.open
  function LazyUtil.open(uri, opts)
    if uri:find("^%w+://") then return M.open(uri) end
    return _lazy_open(uri, opts)
  end
end


return M
