-- =============================================
-- ========== Plugin Loading
-- =============================================
local mlspconfig_ok, mlspconfig = pcall(require, "mason-lspconfig")
if not mlspconfig_ok then Fau_vim.load_plugin_error("mason-lspconfig") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  ensure_installed = { "lua_ls", "clangd", "pyright", },
  automatic_installation = true
}


mlspconfig.setup(config)
