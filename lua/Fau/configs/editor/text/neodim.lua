-- =============================================
-- ========== Plugin Configurations
-- =============================================
local neodim = require("neodim")

local config = {
  alpha = 0.65,
  blend_color = nil,
  hide = {
    underline    = true,
    virtual_text = true,
    signs        = true,
  },
  regex = { "[uU]nused", "[nN]ever [rR]ead", "[nN]ot [rR]ead", "[nN]ot [aA]ccessed" },
  priority = 128,
  disable = {},
}

neodim.setup(config)
