-- =============================================
-- ========== Plugin Configurations
-- =============================================
local move = require("mini.move")

local config = {
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Move visual selection in Visual mode.
    left       = "<A-h>",
    right      = "<A-l>",
    down       = "<A-j>",
    up         = "<A-k>",

    -- Move current line in Normal mode
    line_left  = "",
    line_right = "",
    line_down  = "<A-j>",
    line_up    = "<A-k>",
  },
  -- Options which control moving behavior
  options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
}

move.setup(config)
