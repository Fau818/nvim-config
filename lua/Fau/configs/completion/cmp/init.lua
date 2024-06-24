-- =============================================
-- ========== Plugin Configurations
-- =============================================
local cmp = require("cmp")


-- -----------------------------------
-- -------- Setup
-- -----------------------------------
local config = require("Fau.configs.completion.cmp.config")

cmp.setup(config.global)
cmp.setup.cmdline(":", config.cmdline)
cmp.setup.cmdline({ "/", "?" }, config.search)


-- -----------------------------------
-- -------- Autopairs
-- -----------------------------------
-- for inserting '(' after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
