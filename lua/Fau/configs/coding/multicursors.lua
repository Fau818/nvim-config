-- =============================================
-- ========== Plugin Configurations
-- =============================================
local multicursors = require("multicursors")

local config = {
  DEBUG_MODE = false,
  create_commands = true, -- create Multicursor user commands
  -- updatetime = nil,
  nowait = true,
  mode_keys = {
    append = "a",
    change = "c",
    extend = "e",
    insert = "i",
  },
  -- set bindings to start these modes
  -- normal_keys = normal_keys,
  -- insert_keys = insert_keys,
  -- extend_keys = extend_keys,
  hint_config = { border = "double", position = "bottom" },
  generate_hints = {
    normal = true,
    insert = true,
    extend = true,
    config = { column_count = nil, max_hint_length = 50 }
  },
}

multicursors.setup(config)
