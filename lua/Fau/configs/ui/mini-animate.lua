-- =============================================
-- ========== Plugin Configurations
-- =============================================
local animate = require("mini.animate")

local config = {
  cursor = {
    enable = true,
    timing = animate.gen_timing.cubic({ duration = 120, unit = "total" }),
    -- path = animate.gen_path.line(),
  },
  scroll = { enable = false },
  resize = { enable = false },
  open   = { enable = false },
  close  = { enable = false },
}

animate.setup(config)
