-- =============================================
-- ========== Global Config
-- =============================================
local keymap = vim.keymap.set
local function opts(desc) return { silent = true, desc = desc } end


keymap({ "n", "x" }, "<Space>", "<NOP>", opts())
vim.g.mapleader = " "
vim.g.maplocalleader = " "


local function close_editor()
  local tabs_count = #vim.api.nvim_list_tabpages()

  -- `xall` doesn't work well when use toggle terminal
  if tabs_count == 1 then vim.cmd("wall|qall")
  else vim.cmd("tabclose")
  end
end



-- =============================================
-- ========== Quick Move
-- =============================================
keymap({ "n", "x", "o" }, "H", "^",  opts("Goto: Line Begin"))
keymap({ "n", "x", "o" }, "J", "5j", opts("Goto: Five Lines Down"))
keymap({ "n", "x", "o" }, "K", "5k", opts("Goto: Five Lines Up"))
keymap({ "n", "x", "o" }, "L", "g_", opts("Goto: Line End"))



-- =============================================
-- ========== Buffer Operations
-- =============================================
keymap("n", "<LEADER>q", "q", opts("Editor: Recording"))  -- Use `<LEADER>q` to Recording

keymap("n", "<A-h>", "<CMD>bprevious<CR>", opts("Editor: Previous Buffer"))
keymap("n", "<A-l>", "<CMD>bnext<CR>",     opts("Editor: Next Buffer"))

keymap("n", "q",         "<CMD>update<CR>",  opts("Editor: Save Current Buffer"))
keymap("n", "<D-s>",     "<CMD>update<CR>",  opts("Editor: Save Current Buffer"))
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

-- Reveal File
keymap("n", "<C-f>", "<CMD>Open %:p:h<CR>", opts("Editor: Reveal File"))
keymap("n", "<C-b>", "<NOP>",               opts())

-- Get Current File Absolute Path
keymap("n", "<LEADER><LEADER>p", "<CMD>let @+=expand('%:p')<CR>", opts("Editor: Copy Current File Absolute Path"))

-- Open File Explorer
keymap("n", "<LEADER>e", "<CMD>Lexplore 25<CR>", opts("Editor: Open File Explorer"))

-- Inspect
keymap("n", "<LEADER>i", "<CMD>Inspect<CR>",     opts("Editor: Inspect Element under Cursor"))
keymap("n", "<LEADER>I", "<CMD>InspectTree<CR>", opts("Editor: Show Parsed Syntax Tree"))

-- Disable Built-in Completion
keymap("i", "<C-n>", "<NOP>", opts())

-- Add Undo Breakpoints
keymap("i", ",", ",<c-g>u", opts("Add Undo Breakpoint"))
keymap("i", ".", "<c-g>u.", opts("Add Undo Breakpoint"))
keymap("i", ";", ";<c-g>u", opts("Add Undo Breakpoint"))



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

-- Delete Neovim Default Keymap `Y -> Y$`.  => `Y = yy`
vim.keymap.del("n", "Y")

-- Paste with Auto Indent
keymap("n", "p", "p`[v`]=", opts("PASTE with Auto Indent"))
keymap("n", "P", "P`[v`]=", opts("PASTE with Auto Indent"))

keymap("n", "<D-v>", "p`[v`]=", opts("PASTE with Auto Indent"))
-- keymap("i", "<D-v>", "<C-r>+<Esc>`[v`]=`]a", opts("PASTE with Auto Indent"))
keymap("i", "<D-v>", function()
  -- Trim line break then store to register `z`.
  vim.fn.setreg("z", vim.fn.getreg("+"):gsub("\n$", ""))

  -- Paste from register `z` then record the cursor position and line length.
  vim.api.nvim_paste(vim.fn.getreg("z"), true, -1)
  local p_row, p_col = unpack(vim.api.nvim_win_get_cursor(0))
  local p_line = #vim.api.nvim_get_current_line()

  -- Auto Indent for the pasted content and calculate the new cursor column.
  vim.api.nvim_command("normal! `[v`]=`]")
  local i_line = #vim.api.nvim_get_current_line()
  local gap = i_line - p_line
  local n_col = p_col + gap

  -- Set the cursor to the new position.
  vim.api.nvim_win_set_cursor(0, { p_row, n_col })
  -- dd(string.format("p_row=%d, p_col=%d, n_col=%d, i_line=%d, p_line=%d, gap=%d", p_row, p_col, n_col, i_line, p_line, gap))
end, opts("Paste with Auto Indent"))
keymap("x", "<D-v>", [["_dP]], opts("Paste with Auto Indent"))
keymap("c", "<D-v>", "<C-r>+", { desc = "PASTE from System Clipboard" })  -- NOTE: KEEP `silent = false` for command mode. (Otherwise, it won't work.)

-- Cancel Yank Selection Area When Paste sth in Vim Visual Mode
keymap("x", "p", [["_dP]], opts("Paste"))



-- =============================================
-- ========== Move Line(s)
-- =============================================
keymap("n", "<A-j>", "<CMD>execute 'move .+' . v:count1<CR>==",       opts("Move: Line Down"))
keymap("n", "<A-k>", "<CMD>execute 'move .-' . (v:count1 + 1)<CR>==", opts("Move: Line Up"))
keymap("i", "<A-j>", "<ESC><CMD>m .+1<CR>==gi", opts("Move: Line Down"))
keymap("i", "<A-k>", "<ESC><CMD>m .-2<CR>==gi", opts("Move: Line Up"))
keymap("x", "<A-j>", [[:<C-u>execute "'<, '>move '>+" . v:count1<cr>gv=gv]],       opts("Move: Line Down"))
keymap("x", "<A-k>", [[:<C-u>execute "'<, '>move '<-" . (v:count1 + 1)<cr>gv=gv]], opts("Move: Line Up"))



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
-- ========== Window Operations
-- =============================================
-- Focus in Window
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
keymap("n", "gl", vim.diagnostic.open_float, opts("LSP: Full Diagnostics"))

-- Navigation
keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts("LSP: Prev Diagnostics"))
keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end,  opts("LSP: Next Diagnostics"))
keymap("n", "[e", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR }) end, opts("LSP: Prev Error"))
keymap("n", "]e", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR }) end, opts("LSP: Next Error"))
keymap("n", "[w", function() vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.WARN }) end,  opts("LSP: Prev Warning"))
keymap("n", "]w", function() vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.WARN }) end,  opts("LSP: Next Warning"))

-- Diagnostics List
keymap("n", "<LEADER>ld", vim.diagnostic.setqflist, opts("LSP: Workspace Diagnostics"))



-- =============================================
-- ========== LSP
-- =============================================
-- Remove Default LSP Keymaps
vim.keymap.del("n", "gri")
vim.keymap.del("n", "grr")
vim.keymap.del("n", "grn")
vim.keymap.del("n", "grt")
vim.keymap.del("n", "gO")
vim.keymap.del("n", "<C-w>d")
vim.keymap.del("n", "<C-w><C-d>")
vim.keymap.del({ "n", "x" }, "gra")
vim.keymap.del({ "i", "s" }, "<C-s>")
vim.keymap.del({ "i", "s" }, "<Tab>")
vim.keymap.del({ "i", "s" }, "<S-Tab>")

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
