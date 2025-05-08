-- =============================================
-- ========== Plugin Configurations
-- =============================================
local mlspconfig = require("mason-lspconfig")

---@type MasonLspconfigSettings
local config = {
  automatic_enable = false,
  ensure_installed = { "lua_ls", },
}

mlspconfig.setup(config)
