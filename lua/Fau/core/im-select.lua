-- =============================================
-- ========== Plugin Loading
-- =============================================
local im_select_ok, im_select = pcall(require, "im_select")
if not im_select_ok then Fau_vim.load_plugin_error("im_select") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  -- IM will be set to `default_im_select` in `normal` mode
  -- For Windows/WSL, default: "1033", aka: English US Keyboard
  -- For macOS, default: "com.apple.keylayout.ABC", aka: US
  -- For Linux, default: "keyboard-us" for Fcitx5, "1" for Fcitx, and "xkb:us::eng" for ibus
  -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
  default_im_select = Fau_vim.os_name == "Darwin" and "com.apple.keylayout.UnicodeHexInput" or nil,

  -- Can be binary's name or binary's full path,
  -- e.g. 'im-select' or '/usr/local/bin/im-select'
  -- For Windows/WSL, default: "im-select.exe"
  -- For macOS, default: "im-select"
  -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
  -- default_command = nil,

  -- Restore the default input method state when the following events are triggered
  -- set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

  -- Restore the previous used input method state when the following events are triggered.
  set_previous_events = {},

  -- Show notification about how to install executable binary when binary missed.
  keep_quiet_on_no_binary = false,

  -- Async run `default_command` to switch IM or not.
  async_switch_im = true,
}


im_select.setup(config)
