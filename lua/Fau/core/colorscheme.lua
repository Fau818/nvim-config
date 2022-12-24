-- =============================================
-- ========== Configuration
-- =============================================
local colorscheme = "darkplus"  -- tokyonight-moon, darkplus, tokyonight-night


---@diagnostic disable: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	Fau_vim.notify("colorscheme [" .. colorscheme .. "] not found!", "error")
	return
end
