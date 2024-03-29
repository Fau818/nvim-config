-- =============================================
-- ========== Plugin Loading
-- =============================================
local mlspconfig_ok, mlspconfig = pcall(require, "mason-lspconfig")
if not mlspconfig_ok then Fau_vim.load_plugin_error("mason-lspconfig") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type MasonLspconfigSettings
local config = {
  ensure_installed = { "lua_ls", },
  automatic_installation = false,
  handlers = nil,
}


mlspconfig.setup(config)
