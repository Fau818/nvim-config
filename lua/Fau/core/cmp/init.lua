-- =============================================
-- ========== Plugin Loading
-- =============================================
local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then Fau_vim.load_plugin_error("cmp") return end

local luasnip_ok, _ = pcall(require, "luasnip")
if not luasnip_ok then Fau_vim.load_plugin_error("luasnip") return end



-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Submodule
-- -----------------------------------
require("Fau.core.cmp.luasnip")
require("Fau.core.cmp.cmp_zsh")


-- -----------------------------------
-- -------- Setup
-- -----------------------------------
local config  = require("Fau.core.cmp.config")

cmp.setup(config.global)
cmp.setup.cmdline(":", config.cmdline)
cmp.setup.cmdline({ "/", "?" }, config.search)


-- -----------------------------------
-- -------- Autopairs
-- -----------------------------------
local npairs_ok, npairs = pcall(require, "nvim-autopairs.completion.cmp")
if not npairs_ok then npairs = nil end

-- for inserting '(' after select function or method item
if npairs then cmp.event:on("confirm_done", npairs.on_confirm_done()) end
