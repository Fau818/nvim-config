-- =============================================
-- ========== Plugin Loading
-- =============================================
local textcase_ok, textcase  = pcall(require, "textcase")
if not textcase_ok then Fau_vim.load_plugin_error("textcase") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  default_keymappings_enabled = false,
  prefix = nil,  -- Only works when `default_keymappings_enabled` is true.

  substitude_command_name = nil,

  enabled_methods = nil,  -- Enable all
}


textcase.setup(config)
