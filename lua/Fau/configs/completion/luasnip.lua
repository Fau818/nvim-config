-- =============================================
-- ========== Plugin Configurations
-- =============================================
local luasnip = require("luasnip")

local config = {
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
}

luasnip.setup(config)



-- =============================================
-- ========== Load Snippets from Snitmate
-- =============================================
require("luasnip.loaders.from_snipmate").lazy_load()
