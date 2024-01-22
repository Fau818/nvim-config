-- =============================================
-- ========== Plugin Loading
-- =============================================
local multicursor_ok, multicursor = pcall(require, "multicursors")
if not multicursor_ok then Fau_vim.load_plugin_error("multicursors") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  DEBUG_MODE = false,
  create_commands = true, -- create Multicursor user commands
  updatetime = nil,
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

require("multicursors").setup(config)




multicursor.setup(config)
