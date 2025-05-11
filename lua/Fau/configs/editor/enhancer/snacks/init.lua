-- =============================================
-- ========== Plugin Configurations
-- =============================================
local snacks = require("snacks")

---@type snacks.Config
local config = {
  bigfile      = require("Fau.configs.editor.enhancer.snacks.bigfile"),
  dashboard    = { enabled = false },  -- TODO: QwQ
  explorer     = { enabled = false },
  indent       = { enabled = false },
  input        = { enabled = false },
  picker       = { enabled = false },
  notifier     = { enabled = false },
  quickfile    = { enabled = false },
  scope        = { enabled = false },
  scroll       = { enabled = false },
  statuscolumn = { enabled = false },
  words        = { enabled = false },

}

snacks.setup(config)


-- TEST: Test in May 10, 2025
Fau_vim.notify = Snacks.debug.inspect
