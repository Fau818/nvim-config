-- =============================================
-- ========== Plugin Loading
-- =============================================
local illuminate_ok, illuminate = pcall(require, "illuminate")
if not illuminate_ok then Fau_vim.load_plugin_error("illuminate") return end



-- =============================================
-- ========== Configuration
-- =============================================
illuminate.configure()
