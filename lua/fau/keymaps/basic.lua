-- =============================================
-- ========== Global Config
-- =============================================
local keymap = vim.keymap.set
local function opts(desc) return { silent = true, desc = desc } end


keymap({ "n", "x" }, "<Space>", "<NOP>", opts())
vim.g.mapleader = " "
vim.g.maplocalleader = " "


local function close_editor()
  local tabs_count = vim.fn.tabpagenr("$")

  -- `xall` doesn't work well when use toggle terminal
  if tabs_count == 1 then vim.cmd("wall"); vim.cmd("qall") end
  return vim.cmd("tabclose")
end



-- =============================================
-- ========== Quick Move
-- =============================================
keymap({ "n", "x", "o" }, "H", "^",  opts("Goto: Line Begin"))
keymap({ "n", "x", "o" }, "J", "5j", opts("Goto: Five Lines Down"))
keymap({ "n", "x", "o" }, "K", "5k", opts("Goto: Five Lines Up"))
keymap({ "n", "x", "o" }, "L", "g_", opts("Goto: Line End"))



-- =============================================
-- ========== Quick Save and Close
-- =============================================
keymap("n", "q",         "<CMD>update<CR>",  opts("Editor: Save Current Buffer"))
keymap("n", "<LEADER>w", "<CMD>wall<CR>",    opts("Editor: Save All Buffers"))
keymap("n", "<A-q>",     "<CMD>bdelete<CR>", opts("Editor: Close Current Buffer"))

keymap("n", "Q",       "<CMD>q<CR>", opts("Editor: Quit Current Window"))
keymap("n", "<C-S-q>", close_editor, opts("Editor: Quit Neovim"))



-- =============================================
-- ========== Personal Preferences
-- =============================================
-- Search Word Under Cursor and Clear Highlight Search
keymap("n",          "?",         "*",                        opts("Search Word Under Cursor"))
keymap("n",          "<LEADER>N", "<CMD>nohlsearch<CR>",      opts("Editor: No Highlight Search"))
keymap({ "n", "i" }, "<ESC>",     "<CMD>nohlsearch<CR><ESC>", opts("Escape and Clear Highlight Search"))

-- Undo Preferences
keymap("n", "<C-r>", "<Nop>", opts())
keymap("n", "U",     "<C-r>", opts("Edit: Redo"))
keymap("n", "<A-u>", "U",     opts("Edit: Undo Line"))

-- Merge Line
keymap("n", "<A-m>", "J", opts("Edit: Merge Line"))

-- Default Visual-Block Mode
keymap("n", "v", "<C-v>", opts("Visual-Block Mode"))

-- Use Enter Key to Break Line in Normal Mode
keymap("n", "<CR>",         "o<ESC>", opts("Edit: Add New Line"))
keymap("n", "<LEADER><CR>", "<CR>",   opts("Edit: Normal Enter Key"))

-- Use `<LEADER>q` to Recording
keymap("n", "<LEADER>q", "q", opts("Editor: Recording"))

-- Reveal File
keymap("n", "<C-f>", "<CMD>Open %:p:h<CR>", opts("Editor: Reveal File"))
keymap("n", "<C-b>", "<NOP>",               opts())

-- Open File Explore
keymap("n", "<LEADER>e", "<CMD>Lexplore 25<CR>", opts("Editor: Open File Explore"))

-- Inspect
keymap("n", "<LEADER>i", "<CMD>Inspect<CR>",     opts("Editor: Show Highlight Groups under Cursor"))
keymap("n", "<LEADER>I", "<CMD>InspectTree<CR>", opts("Editor: Show Parsed Syntax Tree"))

-- Disable Built-in Completion
keymap("i", "<C-n>", "<NOP>", opts())

-- Delete Previous Word in Insert Mode [TEST]
keymap("i",  "<C-w>", "<C-s-w>", opts("Delete Previous Word"))


-- =============================================
-- ========== Quick Range Operations
-- =============================================
-- Word
keymap({ "x", "o" }, "w", "iw", opts("Range: Inner Word"))
keymap({ "x", "o" }, "W", "iW", opts("Range: Inner WORD"))

-- Brackets
keymap({ "x", "o" }, "ia", "i>", opts("Range: Inner Angle Bracket"))
keymap({ "x", "o" }, "ir", "i]", opts("Range: Inner Square Bracket"))
keymap({ "x", "o" }, "aa", "a>", opts("Range: Around Angle Bracket"))
keymap({ "x", "o" }, "ar", "a]", opts("Range: Around Square Bracket"))

-- Quotes: for trimming leading/trailing spaces.
keymap({ "x", "o" }, [[a"]], [[2i"]], opts("Range: Around Double Quote"))
keymap({ "x", "o" }, [[a']], [[2i']], opts("Range: Around Single Quote"))
keymap({ "x", "o" }, [[a`]], [[2i`]], opts("Range: Around Back Quote"))

-- Paragraph
keymap("o", "p", "ip", opts("Range: Inner Paragraph"))


-- =============================================
-- ========== Yank Paste Delete(Cut) Preferences
-- =============================================
-- `x` and `X` using "_ register
keymap({ "n", "x" }, "x", [["_x]], opts("Edit: Delete Char"))
keymap({ "n", "x" }, "X", [["_X]], opts("Edit: DELETE Char"))

-- `c` and `C` using "_ register
keymap({ "n", "x" }, "c", [["_c]], opts("Edit: Change"))
keymap({ "n", "x" }, "C", [["_C]], opts("Edit: Change Line"))

-- `d` and `D` using default register
keymap({ "n", "x" }, "d",         [[""d]], opts("Edit: Cut with Vim Clipboard"))
keymap({ "n", "x" }, "D",         [[""D]], opts("Edit: Cut to End of Line with Vim Clipboard"))
keymap({ "n", "x" }, "<LEADER>d", "d",     opts("Edit: Cut with System Clipboard"))
keymap({ "n", "x" }, "<LEADER>D", "D",     opts("Edit: Cut to End of Line with System Clipboard"))

-- '<LEADER>y' and '<LEADER>Y' using default register
keymap({ "n", "x" }, "<LEADER>y", [[""y]], opts("Yank with Vim Clipboard"))
keymap({ "n", "x" }, "<LEADER>Y", [[""Y]], opts("Yank Line with Vim Clipboard"))

-- '<LEADER>p' and '<LEADER>P' using default register
keymap({ "n", "x" }, "<LEADER>p", [[""p]], opts("Paste from Vim Clipboard"))
keymap({ "n", "x" }, "<LEADER>P", [[""P]], opts("PASTE from Vim Clipboard"))

-- Delete Neovim Default Keymap Y -> Y$  ->  Y = yy
vim.keymap.del("n", "Y")

-- Paste with Auto Indent
keymap("n", "p", "p`[v`]=", opts("PASTE with Auto Indent"))
keymap("n", "P", "P`[v`]=", opts("PASTE with Auto Indent"))

-- Cancel Yank Selection Area When Paste sth in Vim Visual Mode
keymap("x", "p", [["_dP]], opts("Paste"))



-- =============================================
-- ========== Move Line(s) (which-key will redefine them)
-- =============================================
-- Normal and Insert Mode
keymap({ "n", "i" }, "<A-j>", "<CMD>move . +1<CR>", opts("Move: Line Down"))
keymap({ "n", "i" }, "<A-k>", "<CMD>move . -2<CR>", opts("Move: Line Up"))

-- Visual Mode
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts("Move: Line Down"))
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts("Move: Line Up"))



-- =============================================
-- ========== Indent and Unindent Line(s)
-- =============================================
-- Normal Mode
keymap("n", "<TAB>",   ">>",    opts("Indent: Add Indent Level"))
keymap("n", "<S-TAB>", "<<",    opts("Indent: Red Indent Level"))  -- Reduce indent level.
keymap("n", "<C-i>",   "<C-i>", opts())  -- For keeping `<C-i>` functionality.

-- Visual Mode
keymap("x", "<TAB>",   ">gv", opts("Indent: Add Indent Level"))
keymap("x", "<S-TAB>", "<gv", opts("Indent: Red Indent Level"))  -- Reduce indent level.



-- =============================================
-- ========== Windows Operations
-- =============================================
-- Focus in Windows
keymap({ "n", "t" }, "<C-h>", "<CMD>wincmd h<CR>", opts("Window: Focus Shift Left"))
keymap({ "n", "t" }, "<C-j>", "<CMD>wincmd j<CR>", opts("Window: Focus Shift Down"))
keymap({ "n", "t" }, "<C-k>", "<CMD>wincmd k<CR>", opts("Window: Focus Shift Up"))
keymap({ "n", "t" }, "<C-l>", "<CMD>wincmd l<CR>", opts("Window: Focus Shift Right"))

-- Resize Window
keymap({ "n", "t" }, "<C-LEFT>",  "<CMD>vertical resize -2<CR>", opts("Window: Decrease Width"))
keymap({ "n", "t" }, "<C-RIGHT>", "<CMD>vertical resize +2<CR>", opts("Window: Increase Width"))
keymap({ "n", "t" }, "<C-DOWN>",  "<CMD>resize -1<CR>",          opts("Window: Decrease Height"))
keymap({ "n", "t" }, "<C-UP>",    "<CMD>resize +1<CR>",          opts("Window: Increase Height"))

-- Split Window
keymap("n", "<C-v>", "<CMD>vsplit<CR>", opts("Editor: Vertical Split"))
-- keymap("n", "<C-x>", "<CMD>split<CR>",  opts)



-- =============================================
-- ========== Terminal
-- =============================================
keymap("t", "<C-r>", "<NOP>", opts())



-- =============================================
-- ========== Diagnostics
-- =============================================
-- Full Diagnostics Infomation
keymap("n", "gl", vim.diagnostic.open_float,   opts("LSP: Full Diagnostics"))

-- Navigation
keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts("LSP: Prev Diagnostics"))
keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,  opts("LSP: Next Diagnostics"))

-- Diagnostics List
keymap("n", "<LEADER>ld", vim.diagnostic.setqflist, opts("LSP: Workspace Diagnostics"))



-- =============================================
-- ========== LSP
-- =============================================
-- Remove Default LSP Keymaps
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "gra")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grt")
vim.keymap.del("i", "<C-s>")

-- Navigation
keymap("n", "gd", vim.lsp.buf.definition,      opts("LSP: Definition"))
keymap("n", "gD", vim.lsp.buf.declaration,     opts("LSP: Declaration"))
keymap("n", "gt", vim.lsp.buf.type_definition, opts("LSP: Type Definition"))
keymap("n", "gI", vim.lsp.buf.implementation,  opts("LSP: Implementation"))
keymap("n", "gr", vim.lsp.buf.references,      opts("LSP: References"))
keymap("n", "gi", vim.lsp.buf.incoming_calls,  opts("LSP: Incoming Calls"))
keymap("n", "go", vim.lsp.buf.outgoing_calls,  opts("LSP: Outgoing Calls"))

keymap("n", "<LEADER>lr", vim.lsp.buf.rename,      opts("LSP: Rename"))
keymap("n", "<LEADER>la", vim.lsp.buf.code_action, opts("LSP: Code Action"))

keymap({ "n", "i" }, "<C-d>", vim.lsp.buf.hover, opts("LSP: Document"))
-- TIPS: If call `vim.lsp.buf.signature_help` directly, no noice markdown rendering.
keymap({ "n", "i" }, "<C-p>", function() vim.lsp.buf.signature_help() end, opts("LSP: Signature Help"))

keymap("n", "<LEADER>lf", vim.lsp.buf.format,                       opts("LSP: Format Code"))
keymap("n", "<LEADER>lF", vim.lsp.buf.format,                       opts("LSP: Format Code (Force)"))
keymap("x", "<LEADER>lf", "<CMD>lua vim.lsp.buf.format()<CR><ESC>", opts("LSP: Format Code"))
keymap("x", "<LEADER>lF", "<CMD>lua vim.lsp.buf.format()<CR><ESC>", opts("LSP: Format Code (Force)"))

keymap("n", "<LEADER>lh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })) end, opts("LSP: Toggle Inlay Hint"))
