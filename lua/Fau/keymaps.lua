-- =============================================
-- ========== Global Config
-- =============================================
local keymap  = vim.keymap.set
local del_map = vim.keymap.del
local opts       = { silent = true }
local opts_remap = { remap  = true, silent = true }



-- =============================================
-- ========== Set Leader key
-- =============================================
keymap({ "n", "x" }, "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "



-- =============================================
-- ========== Quick Moving
-- =============================================
keymap({ "n", "x", "o" }, "H", "^", opts)
keymap({ "x", "o" }, "J", "5j", opts)
keymap({ "x", "o" }, "K", "5k", opts)
keymap({ "n", "x", "o" }, "L", "<END>", opts)
keymap("n", "J", "5j", opts_remap) -- for telescope
keymap("n", "K", "5k", opts_remap) -- for telescope



-- =============================================
-- ========== Quick Save and Close
-- =============================================
keymap("n", "Q", "<CMD>q<CR>", opts)
keymap("n", "<C-S-q>", "<CMD>wall<CR><CMD>qall<CR>", opts)  -- `xall` doesn't work well when use toggle terminal



-- =============================================
-- ========== Personal Preferences
-- =============================================
-- Undo Preferences
keymap("n", "U", "<C-r>", opts)
keymap("n", "<A-u>", "U", opts)

-- Merge Line
keymap("n", "<A-m>", "J", opts)

-- Default Visual-Block Mode
keymap("n", "v", "<C-v>", opts)
keymap("n", "<C-v>", "v", opts)

-- Use Enter Key to Break Line in Normal Mode
keymap("n", "<CR>", "o<ESC>", opts)
keymap("n", "<LEADER><CR>", "<CR>", opts)

-- No Highlight Search
keymap("n", "<LEADER>n", "<CMD>nohlsearch<CR>", opts)

-- Use '<LEADER>q' to Recording
keymap("n", "<LEADER>q", "q", opts)



-- =============================================
-- ========== Quick Range Operations
-- =============================================
-- Word
keymap({ "x", "o" }, "w", "iw", opts)
keymap({ "x", "o" }, "W", "iW", opts)

-- Bracket
keymap({ "x", "o" }, "ia", "i>", opts)
keymap({ "x", "o" }, "ir", "i]", opts)
keymap({ "x", "o" }, "aa", "a>", opts)
keymap({ "x", "o" }, "ar", "a]", opts)



-- =============================================
-- ========== Yank Paste Delete(Cut) Preferences
-- =============================================
-- `x` and `X` using "_ register
keymap({ "n", "x" }, "x", '"_x', opts)
keymap({ "n", "x" }, "X", '"_X', opts)

-- `c` and `C` using "_ register
keymap({ "n", "x" }, "c", '"_c', opts)
keymap({ "n", "x" }, "C", '"_C', opts)

-- `d` and `D` using default register
keymap({ "n", "x" }, "d", '""d', opts)
keymap({ "n", "x" }, "D", '""D', opts)
keymap({ "n", "x" }, "<LEADER>d", 'd',   opts)
keymap({ "n", "x" }, "<LEADER>D", 'D',   opts)

-- '<LEADER>y' and '<LEADER>Y' using default register
keymap({ "n", "x" }, "<LEADER>Y", '""Y', opts)
keymap({ "n", "x" }, "<LEADER>y", '""y', opts)

-- '<LEADER>p' and '<LEADER>P' using default register
keymap({ "n", "x" }, "<LEADER>p", '""p', opts)
keymap({ "n", "x" }, "<LEADER>P", '""P', opts)

-- Delete Neovim Default Keymap Y -> Y$ [TEST]
del_map("n", "Y")

-- Cancel Yank Selection Area When Paste sth in Vim Visual Mode
keymap("x", "p", '"_dP', opts)



-- =============================================
-- ========== Move Line(s) (which-key will redefine them)
-- =============================================
-- Normal Mode
keymap("n", "<A-j>", "<CMD>move . +1<CR>", opts)
keymap("n", "<A-k>", "<CMD>move . -2<CR>", opts)

-- Visual Mode
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)



-- =============================================
-- ========== Indent and Unindent Line(s)
-- =============================================
-- Normal Mode
keymap("n", "<TAB>",   ">>",  opts)
keymap("n", "<S-TAB>", "<<",  opts)

-- Visual Mode
keymap("x", "<TAB>",   ">gv", opts)
keymap("x", "<S-TAB>", "<gv", opts)



-- =============================================
-- ========== Windows Operations
-- =============================================
-- Focus in Windows
keymap({ "n", "t" }, "<C-h>", "<CMD>wincmd h<CR>", opts)
keymap({ "n", "t" }, "<C-j>", "<CMD>wincmd j<CR>", opts)
keymap({ "n", "t" }, "<C-k>", "<CMD>wincmd k<CR>", opts)
keymap({ "n", "t" }, "<C-l>", "<CMD>wincmd l<CR>", opts)

-- Resize Window
keymap({ "n", "t" }, "<C-LEFT>",  "<CMD>vertical resize -2<CR>", opts)
keymap({ "n", "t" }, "<C-RIGHT>", "<CMD>vertical resize +2<CR>", opts)
keymap({ "n", "t" }, "<C-DOWN>",  "<CMD>resize -1<CR>",          opts)
keymap({ "n", "t" }, "<C-UP>",    "<CMD>resize +1<CR>",          opts)



-- ===================================
-- ======== Buffer Operations
-- ===================================
-- Save and Close Buffers
keymap("n", "q",         "<CMD>update<CR>", opts)
keymap("n", "<LEADER>w", "<CMD>wall<CR>",   opts)
