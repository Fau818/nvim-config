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
      open = "<A-CR>"
    },
    layout = {
      position = "bottom",  ---@type "bottom"|"top"|"left"|"right"
      ratio = 0.35
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = true,
    debounce = 50,
    keymap = {
      accept = "<TAB>",
      accept_word = "<C-w>",
      accept_line = false,
      next = "<A-l>",
      prev = "<A-h>",
      dismiss = "<C-c>",
    },
  },
  filetypes = { ["*"] = function(bufnr) return not Fau_vim.functions.utils.is_large_file(bufnr) end },
  copilot_node_command = "node",
  server_opts_overrides = {},
}


copilot.setup(config)
