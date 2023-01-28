-- =============================================
-- ========== Plugin Loading
-- =============================================
local impatient_ok, impatient = pcall(require, "impatient")
if not impatient_ok then Fau_vim.load_plugin_error("impatient") return end


impatient.enable_profile()
