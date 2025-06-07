-- =============================================
-- ========== Plugin Configurations
-- =============================================
local mlspconfig = require("mason-lspconfig")

---@type MasonLspconfigSettings
local config = {
  automatic_enable = true,
  ensure_installed = { "lua_ls", },
}

mlspconfig.setup(config)
