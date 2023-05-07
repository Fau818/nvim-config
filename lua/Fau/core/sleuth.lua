-- WARNING: This plugin is deprecated!
-- =============================================
-- ========== Configuration
-- =============================================
-- Disable in some file types
local disable = Fau_vim.disabled_filetypes


for _, filetype in ipairs(disable) do
  local str = "sleuth_" .. filetype .. "_heuristics"
  vim.g[str] = 0
end
