-- =============================================
-- ========== Plugin Loading
-- =============================================
local navic_ok, navic = pcall(require, "nvim-navic")
if not navic_ok then Fau_vim.load_plugin_error("nvim-navic") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  lsp = {
    auto_attach = false,  -- by barbecue
    preference = nil,
  },

  icons = Fau_vim.icons.kind,

  highlight = true,

  separator = " " .. Fau_vim.icons.ui.Separator .. " ",

  depth_limit = 0,
  depth_limit_indicator = Fau_vim.icons.ui.Ellipsis,

  safe_output = true,
  click = true,
}


navic.setup(config)
