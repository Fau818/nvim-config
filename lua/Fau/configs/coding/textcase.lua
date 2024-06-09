-- =============================================
-- ========== Plugin Configurations
-- =============================================
local textcase = require("textcase")

local config = {
  default_keymappings_enabled = false,
  prefix = nil,  -- Only works when `default_keymappings_enabled` is true.

  substitude_command_name = nil,

  enabled_methods = nil,  -- Enable all
}

textcase.setup(config)



-- =============================================
-- ========== Telescope Integration
-- =============================================
require("telescope").load_extension("textcase")
