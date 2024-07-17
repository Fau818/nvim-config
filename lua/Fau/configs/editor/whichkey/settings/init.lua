local whichkey = require("which-key")


-- ==================== Components ====================
local basic       = require("Fau.configs.editor.whichkey.settings.basic")
local lsp         = require("Fau.configs.editor.whichkey.settings.lsp")
local git         = require("Fau.configs.editor.whichkey.settings.git")
local terminal    = require("Fau.configs.editor.whichkey.settings.terminal")
local code_runner = require("Fau.configs.editor.whichkey.settings.code_runner")
local chatgpt     = require("Fau.configs.editor.whichkey.settings.chatgpt")


-- ==================== Setup ====================
whichkey.add(basic)
whichkey.add(lsp)
whichkey.add(git)
whichkey.add(terminal)
whichkey.add(code_runner)
whichkey.add(chatgpt)
