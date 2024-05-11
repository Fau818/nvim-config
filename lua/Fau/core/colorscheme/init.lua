-- TODO: need to be refined, a API to change colorscheme.

-- =============================================
-- ========== Colorscheme Setting
-- =============================================
local colorscheme = "tokyonight"



-- =============================================
-- ========== Configuration
-- =============================================
if colorscheme == "tokyonight" then require "Fau.core.colorscheme.tokyonight" end



-- =============================================
-- ========== Colorscheme Applying
-- =============================================
local status_ok, _ = pcall(vim.api.nvim_command, "colorscheme " .. colorscheme)
if not status_ok then Fau_vim.notify("colorscheme [" .. colorscheme .. "] not found!", "error") return end
