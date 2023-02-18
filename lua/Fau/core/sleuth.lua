-- =============================================
-- ========== Configuration
-- =============================================
-- Disable in some file types
local disable = {
  "", "checkhealth", "help", "gitcommit", "alpha", "NvimTree", "Trouble",
  "toggleterm", "aerial", "lspinfo", "notify", "noice",
  "packer", "lazy", "mason"
}



for _, filetype in ipairs(disable) do
  local str = "sleuth_" .. filetype .. "_heuristics"
  vim.g[str] = 0
end
