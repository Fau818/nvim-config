-- =============================================
-- ========== Plugin Configurations
-- =============================================
local textcase = require("textcase")

local config = {
  default_keymappings_enabled = true,
  prefix = "<LEADER>t",  -- Only works when `default_keymappings_enabled` is true.

  substitude_command_name = nil,

  enabled_methods = {
    -- "to_upper_case",
    -- "to_lower_case",

    "to_snake_case",
    "to_camel_case",
    "to_pascal_case",

    "to_dash_case",
    "to_dot_case",
    "to_path_case",

    "to_title_case",
    -- "to_title_dash_case",
    "to_constant_case",

    -- "to_phrase_case",

    -- "to_upper_phrase_case",
    -- "to_lower_phrase_case",
  }
}

textcase.setup(config)
