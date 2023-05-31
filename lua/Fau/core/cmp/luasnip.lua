-- =============================================
-- ========== Plugin Loading
-- =============================================
local luasnip = require("luasnip")  -- make sure installed



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  history = false,
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave"
}


luasnip.setup(config)


-- require("luasnip/loaders/from_vscode").lazy_load()  -- for support friendly-snippets plugin
require("luasnip.loaders.from_snipmate").lazy_load()  -- for snipmate snippets
