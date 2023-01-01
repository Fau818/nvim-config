-- =============================================
-- ========== Plugin Loading
-- =============================================
local im_select = Fau_vim.load_plugin("im_select")
if im_select == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	-- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
	-- For Windows/WSL, default: "1033", aka: English US Keyboard
	-- For macOS, default: "com.apple.keylayout.ABC", aka: US
	-- You can use `im-select` in cli to get the IM name of you preferred
	default_im_select = "com.apple.keylayout.UnicodeHexInput",

	-- Set to 1 if you don't want restore IM status when `InsertEnter`
	disable_auto_restore = 1,
}


im_select.setup(config)
