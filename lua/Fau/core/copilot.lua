-- =============================================
-- ========== Plugin Loading
-- =============================================
local copilot_ok, copilot = pcall(require, "copilot")
if not copilot_ok then Fau_vim.load_plugin_error("copilot") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom",  -- | top | left | right
      ratio = 0.35
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
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
  filetypes = {
    gitcommit = true,
    -- help = false,
    -- ["*"] = false,
  },
  copilot_node_command = "node",       -- Node.js version must be > 16.x
  server_opts_overrides = {},
}


copilot.setup(config)
