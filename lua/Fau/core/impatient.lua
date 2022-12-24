-- =============================================
-- ========== Plugin Loading
-- =============================================
local impatient = Fau_vim.load_plugin("impatient")
if impatient == nil then return end


impatient.enable_profile()
