-- =============================================
-- ========== Plugin Loading
-- =============================================
local inlayhints = Fau_vim.load_plugin("lsp-inlayhints")
if inlayhints == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
inlayhints.setup()
