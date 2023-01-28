-- =============================================
-- ========== Plugin Loading
-- =============================================
local inlayhints_ok, inlayhints = pcall(require, "lsp-inlayhints")
if not inlayhints_ok then Fau_vim.load_plugin_error("lsp-inlayhints") return end



-- =============================================
-- ========== Configuration
-- =============================================
inlayhints.setup()
