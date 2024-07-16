local whichkey = require("which-key")


-- ==================== Components ====================
local basic       = require("Fau.core.whichkey.settings.basic")
local lsp         = require("Fau.core.whichkey.settings.lsp")
local git         = require("Fau.core.whichkey.settings.git")
local terminal    = require("Fau.core.whichkey.settings.terminal")
local code_runner = require("Fau.core.whichkey.settings.code_runner")
local chatgpt     = require("Fau.core.whichkey.settings.chatgpt")


-- ==================== Setup ====================
whichkey.add(basic)
whichkey.add(lsp)
whichkey.add(git)
whichkey.add(terminal)
whichkey.add(code_runner)
whichkey.add(chatgpt)
