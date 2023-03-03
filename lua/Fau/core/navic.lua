-- =============================================
-- ========== Plugin Loading
-- =============================================
local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then Fau_vim.load_plugin_error("nvim-navic") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  icons = Fau_vim.icons.kind,

  highlight = true,

  separator = " " .. Fau_vim.icons.ui.ChevronRight .. " ",

  depth_limit = 0,
  depth_limit_indicator = "..",

  safe_output = true
}


navic.setup(config)
