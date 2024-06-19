-- =============================================
-- ========== Plugin Configurations
-- =============================================
local copilot = require("copilot")

---@type copilot_config
local config = {
  panel = {
    enabled = false,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom",  ---@type "bottom"|"top"|"left"|"right"
      ratio = 0.35
    },
  },
  suggestion = {
    enabled = false,  -- NOTE: Use as cmp source, so keep it disabled.
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = { ["*"] = true },
  copilot_node_command = "node",
  server_opts_overrides = {},
}


copilot.setup(config)
