-- TODO: need to be refined, a API to change colorscheme.

-- =============================================
-- ========== Colorscheme Setting
-- =============================================
local colorscheme = Fau_vim.on_server and "darkplus" or "tokyonight"



-- =============================================
-- ========== Configuration
-- =============================================
if colorscheme == "tokyonight" then require "Fau.core.colorscheme.tokyonight"
else require "Fau.core.transparent"
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
