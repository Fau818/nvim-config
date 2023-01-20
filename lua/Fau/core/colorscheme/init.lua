-- =============================================
-- ========== Colorscheme Setting
-- =============================================
local colorscheme = "tokyonight"  -- tokyonight, darkplus,



-- =============================================
-- ========== Configuration
-- =============================================
if colorscheme == "tokyonight" then
	require "Fau.core.colorscheme.tokyonight"
else
	require "Fau.core.transparent"
end



-- =============================================
-- ========== Colorscheme Applying
-- =============================================
---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	Fau_vim.notify("colorscheme [" .. colorscheme .. "] not found!", "error")
	return
end
