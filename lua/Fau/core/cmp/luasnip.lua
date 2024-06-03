-- =============================================
-- ========== Plugin Loading
-- =============================================
local luasnip = require("luasnip")  -- make sure installed



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave"
}


luasnip.setup(config)


--- Load from Snitmate
require("luasnip.loaders.from_snipmate").lazy_load()
