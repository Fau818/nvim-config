if not vim.g.vscode then return end
local vscode = require("vscode")


-- =============================================
-- ========== Neovim-VSCode Integration Setup
-- =============================================
_G.vscode = vscode

vim.notify = vscode.notify
vim.g.clipboard = vim.g.vscode_clipboard  -- TEST: Use VSCode clipboard integration, on Dec 13, 2025

vim.g.snacks_animate = false


-- =============================================
-- ========== Keymaps
-- =============================================
-- -----------------------------------
-- -------- Remove vscode-neovim default keymaps
-- -----------------------------------
-- SEE: https://github.com/vscode-neovim/vscode-neovim/blob/master/runtime/vscode/code_actions.lua
vim.keymap.del({ "n", "x" }, "gq")
vim.keymap.del("n", "gqq")
vim.keymap.del({ "n", "x" }, "=")
vim.keymap.del("n","==")

-- SEE: https://github.com/vscode-neovim/vscode-neovim/blob/master/runtime/vscode/overrides/vscode-code-actions.vim
-- vim.keymap.del({ "n", "x" }, "K")
vim.keymap.del({ "n", "x" }, "gh")
vim.keymap.del({ "n", "x" }, "gf")
vim.keymap.del({ "n", "x" }, "gd")
vim.keymap.del({ "n", "x" }, "<C-]>")
-- vim.keymap.del({ "n", "x" }, "gO")
vim.keymap.del({ "n", "x" }, "gF")
vim.keymap.del({ "n", "x" }, "gD")
vim.keymap.del({ "n", "x" }, "gH")
vim.keymap.del({ "n", "x" }, "<C-w>gf")
vim.keymap.del({ "n", "x" }, "<C-w>gd")
vim.keymap.del("n", "z=")

-- SEE: https://github.com/vscode-neovim/vscode-neovim/blob/master/runtime/vscode/overrides/vscode-file-commands.vim
vim.keymap.del("n", "ZZ")
vim.keymap.del("n", "ZQ")


-- -----------------------------------
-- -------- Rewrite Basic Keymaps
-- -----------------------------------
local keymap = vim.keymap.set
local function opts(desc) return { silent = true, desc = desc } end

-- ==================== Buffer Operations ====================
keymap("n", "<A-h>", function() vscode.call("workbench.action.previousEditor") end, opts("VSCode: Previous Tab"))
keymap("n", "<A-l>", function() vscode.call("workbench.action.nextEditor") end,     opts("VSCode: Next Tab"))
keymap("n", "<A-left>",  function() vscode.call("workbench.action.moveEditorLeftInGroup") end,  opts("VSCode: Move Buffer Prev"))
keymap("n", "<A-right>", function() vscode.call("workbench.action.moveEditorRightInGroup") end, opts("VSCode: Move Buffer Next"))
for i = 1, 9 do
  keymap("n", string.format("<A-%d>", i), function() vscode.call(string.format("workbench.action.openEditorAtIndex%d", i)) end, opts(string.format("VSCode: Switch to Tab %d", i)))
  keymap("n", string.format("<LEADER>%d", i), function() vscode.call(string.format("workbench.action.openEditorAtIndex%d", i)) end, opts(string.format("VSCode: Switch to Tab %d", i)))
end

keymap("n", "<leader>bt", function() vscode.call("workbench.action.pinEditor") end,   opts("VSCode: Pin Editor"))
keymap("n", "<leader>bT", function() vscode.call("workbench.action.unpinEditor") end, opts("VSCode: Unpin Editor"))

keymap("n", "<A-q>",   function() vscode.call("workbench.action.closeActiveEditor") end, opts("VSCode: Close Current Tab"))
keymap("n", "Q",       function() vscode.call("workbench.action.closeActiveEditor") end, opts("VSCode: Close Current Tab"))
keymap("n", "<C-S-q>", function() vscode.call("workbench.action.closeWindow") end,       opts("VSCode: Close VSCode"))


-- ==================== Personal Preferences ====================
keymap("n", "<LEADER>e", function() vscode.call("workbench.files.action.focusFilesExplorer") end, opts("VSCode: Focus on File Explorer"))

keymap("n", "<LEADER>i", function() vscode.call("editor.action.inspectTMScopes") end, opts("VSCode: Inspect TM Scopes"))


-- ==================== Navigation ====================
keymap("n", "<C-i>", function() vscode.call("workbench.action.navigateForward") end, opts("VSCode: Navigate Forward"))
keymap("n", "<C-o>", function() vscode.call("workbench.action.navigateBack") end,    opts("VSCode: Navigate Back"))


-- ==================== Window Operations ====================
keymap({ "n", "t" }, "<C-h>", function() vscode.call("workbench.action.navigateLeft") end,  opts("VSCode Window: Focus Left"))
keymap({ "n", "t" }, "<C-j>", function() vscode.call("workbench.action.navigateDown") end,  opts("VSCode Window: Focus Down"))
keymap({ "n", "t" }, "<C-k>", function() vscode.call("workbench.action.navigateUp") end,    opts("VSCode Window: Focus Up"))
keymap({ "n", "t" }, "<C-l>", function() vscode.call("workbench.action.navigateRight") end, opts("VSCode Window: Focus Right"))

keymap({ "n", "t" }, "<C-LEFT>",  function() vscode.call("workbench.action.decreaseViewWidth") end,  opts("VSCode Window: Decrease Width"))
keymap({ "n", "t" }, "<C-RIGHT>", function() vscode.call("workbench.action.increaseViewWidth") end,  opts("VSCode Window: Increase Width"))
keymap({ "n", "t" }, "<C-DOWN>",  function() vscode.call("workbench.action.decreaseViewHeight") end, opts("VSCode Window: Decrease Height"))
keymap({ "n", "t" }, "<C-UP>",    function() vscode.call("workbench.action.increaseViewHeight") end, opts("VSCode Window: Increase Height"))

keymap("n", "<C-v>", function() vscode.call("workbench.action.splitEditorRight") end, opts("VSCode Window: Split Right"))


-- ==================== Diagnostics and LSP ====================
keymap("n", "gl", function() vscode.call("editor.action.showHover") end, opts("VSCode: Show Hover"))

keymap("n", "[d", function() vscode.call("editor.action.marker.prev") end, opts("VSCode: Prev Diagnostic"))
keymap("n", "]d", function() vscode.call("editor.action.marker.next") end, opts("VSCode: Next Diagnostic"))

keymap("n", "<LEADER>ld", function() vscode.call("workbench.actions.view.problems") end, opts("VSCode: Show Problems Panel"))

keymap("n", "gd", function() vscode.call("editor.action.peekDefinition") end,   opts("VSCode LSP: Definition"))
keymap("n", "gD", function() vscode.call("editor.action.peekDeclaration") end,  opts("VSCode LSP: Declaration"))
keymap("n", "gt", function() vscode.call("editor.action.peekTypeDefinition") end, opts("VSCode LSP: Type Definition"))
keymap("n", "gI", function() vscode.call("editor.action.peekImplementation") end, opts("VSCode LSP: Implementation"))
keymap("n", "gr", function() vscode.call("editor.action.referenceSearch.trigger") end,     opts("VSCode LSP: References"))
keymap("n", "gi", function() vscode.call("editor.showIncomingCalls") end,         opts("VSCode LSP: Incoming Calls"))
keymap("n", "go", function() vscode.call("editor.showOutgoingCalls") end,         opts("VSCode LSP: Outgoing Calls"))

keymap("n", "<LEADER>lr", function() vscode.call("editor.action.rename") end,   opts("VSCode LSP: Rename"))
keymap("n", "<LEADER>la", function() vscode.call("editor.action.quickFix") end, opts("VSCode LSP: Code Action"))

keymap({ "n", "i" }, "<C-d>", function() vscode.call("editor.action.showHover") end, opts("VSCode LSP: Document"))
keymap({ "n", "i" }, "<C-p>", function() vscode.call("editor.action.triggerParameterHints") end, opts("VSCode LSP: Signature Help"))

keymap("n", "<LEADER>lf", function() vscode.call("editor.action.formatDocument") end, opts("VSCode LSP: Format Code"))
keymap("n", "<LEADER>lF", function() vscode.call("editor.action.formatDocument") end, opts("VSCode LSP: Format Code (Force)"))
keymap("x", "<LEADER>lf", function() vscode.call("editor.action.formatSelection"); fvim.utils.feedkeys("n", "<ESC>") end, opts("VSCode LSP: Format Code"))
keymap("x", "<LEADER>lF", function() vscode.call("editor.action.formatSelection"); fvim.utils.feedkeys("n", "<ESC>") end, opts("VSCode LSP: Format Code (Force)"))

keymap("n", "<LEADER>lh", function() vim.notify("Please Toggle Inlay Hints in Settings Manually.") end, opts("LSP: Toggle Inlay Hint"))

keymap("n", "<LEADER>lo", function() vscode.call("outline.focus") end, opts("Symbol Outline: Toggle"))


-- ==================== Pickers ====================
keymap("n", "<LEADER>ff", function() vscode.call("workbench.action.quickOpen") end,        opts("VSCode: Find Files"))
keymap("n", "<LEADER>fs", function() vscode.call("workbench.action.findInFiles") end,      opts("VSCode: Find in Files"))
keymap("n", "<LEADER>fr", function() vscode.call("workbench.action.openRecent") end,       opts("VSCode: Open Recent"))
keymap("n", "<LEADER>fp", function() vscode.call("workbench.action.files.openFolder") end, opts("VSCode: Open Project"))

keymap("n", "<LEADER>fc", function() vscode.call("workbench.action.showCommands") end, opts("VSCode: Commands Palette"))
keymap("n", "<LEADER>fe", function() vscode.call("python.setInterpreter") end, opts("VSCode: Select Python Env"))
keymap("n", "<LEADER>fk", function() vscode.call("workbench.action.openGlobalKeybindings") end, opts("VSCode: Open Keyboard Shortcuts"))
keymap("n", "<LEADER>fn", function() vscode.call("notifications.showList") end, opts("VSCode: Show Notifications"))

keymap("n", "<LEADER>ls", function() vscode.call("workbench.action.gotoSymbol") end,     opts("VSCode: Go to Symbol"))
keymap("n", "<LEADER>lS", function() vscode.call("workbench.action.showAllSymbols") end, opts("VSCode: Go to Symbol"))


-- ==================== Terminal ====================
keymap("n", "<C-t>", function() vscode.call("workbench.action.terminal.toggleTerminal") end, opts("VSCode: Toggle Terminal"))


-- ==================== Fold ====================
keymap("n", "za", function() vscode.call("editor.toggleFold") end, opts("VSCode: Toggle Fold"))
keymap("n", "zM", function() vscode.call("editor.foldAll") end,    opts("VSCode: Fold All"))
keymap("n", "zR", function() vscode.call("editor.unfoldAll") end,  opts("VSCode: Unfold All"))
keymap("n", "zo", function() vscode.call("editor.unfold") end,     opts("VSCode: Open Fold"))
keymap("n", "zc", function() vscode.call("editor.fold") end,       opts("VSCode: Close Fold"))

-- TODO: Code Runner Keymaps
-- { "<LEADER>r",  "<NOP>",                          desc = "Code Runner"               },
-- { "<C-r>",      "<CMD>RunFile toggleterm<CR>",    desc = "Run File in Toggleterm"    },
-- { "<LEADER>rt", "<CMD>RunFile term<CR>",          desc = "Run File in Terminal"      },
-- { "<LEADER>rT", "<CMD>RunFile toggle<CR>",        desc = "Run File Toggle"           },
-- { "<LEADER>rf", "<CMD>RunFile float<CR>",         desc = "Run File in Float"         },
-- { "<LEADER>rc", "<CMD>RunClose<CR>",              desc = "Run Close"                 },
-- { "<LEADER>rp", "<CMD>RunProject toggleterm<CR>", desc = "Run Project in Toggleterm" },

-- TODO: Gitsigns Keymaps
-- /Users/fau/.config/nvim/lua/fau/plugins/editor/gitsigns.lua
