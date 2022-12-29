-- Basic (in keymaps)
local basic = {
	["U"]     = "Undo",
	["<A-u>"] = "Undo Line",

	["<A-m>"] = "Merge Line",

	["v"]     = "Visual-Block Mode",
	["<C-v>"] = "Visual Mode",

	["<CR>"]         = "Add New Line",
	["<LEADER><CR>"] = "Normal Enter Key",

	["<LEADER>q"] = "Recording",

	["<LEADER>n"] = "No Highlight Search",

	["<TAB>"]   = "Indent Line",
	["<S-TAB>"] = "Unindent Line",
}


-- Quick Move
local move = {  -- nxo
	["H"] = "Line Begin",
	["J"] = "Five Line Down",
	["K"] = "Five Line Up",
	["L"] = "Line End",
}


-- Cut, Yank and Paste
local edit = {  -- nx
	x = "Delete Char",
	X = "DELETE Char",

	c = "Delete and Enter Insert Mode",
	C = "DELETE and Enter Insert Mode",

	d = "Cut in VIM Clipboard",
	D = "CUT in VIM Clipboard",

	y = "+Yank in System Clipboard",
	Y = "+YANK in System Clipboard",

	p = "+Paste in System Clipboard",
	P = "+PASTE in System Clipboard",

	["<LEADER>d"] = "Cut in System Clipboard",
	["<LEADER>D"] = "CUT in System Clipboard",

	["<LEADER>y"] = "Yank in VIM Clipboard",
	["<LEADER>Y"] = "YANK in VIM Clipboard",

	["<LEADER>p"] = "Paste in VIM Clipboard",
	["<LEADER>P"] = "PASTE in VIM Clipboard",
}


-- Quick Range
local range = {  -- xo
	-- Easy Word Range
	["w"] = "Inside Word",
	["W"] = "Around Word",

	-- Easy Bracket Range
	i = {
		name = "+Inside",
		a = "Inside Angle Bracket",
		r = "Inside Square Bracket",
	},

	a = {
		name = "+Around",
		a = "Around Angle Bracket",
		r = "Around Square Bracket",
	},
}


-- Move Line(s)
local move_line = {  -- ni
	["<A-j>"] = { "<CMD>MoveLine(1)<CR>", "Move Down" },
	["<A-k>"] = { "<CMD>MoveLine(-1)<CR>", "Move Up" },
}


return {
	n = {
		basic, move, edit, move_line,

		-- =============================================
		-- ========== Baisc
		-- =============================================
		-- NvimTree
		["<LEADER>e"] = { "<CMD>NvimTreeFindFileToggle<CR>", "Toggle NvimTree" },

		-- Snippet
		["<LEADER>s"] = { "<CMD>EditSnip<CR>", "Edit Snippet" },

		-- Style
		["<LEADER>S"] = { "<CMD>EditStyle<CR>", "Edit Style" },



		-- =============================================
		-- ========== Window Operations
		-- =============================================
		-- Close
		["Q"]       = "Close Current Window",
		["<C-S-q>"] = "Close VIM",

		-- Focus in Window
		["<C-h>"] = "Focus Shift Left",
		["<C-j>"] = "Focus Shift Down",
		["<C-k>"] = "Focus Shift Up",
		["<C-l>"] = "Focus Shift Right",

		-- Resize Window
		["<C-LEFT>"]  = "Decrease Width",
		["<C-RIGHT>"] = "Increase Width",
		["<C-DOWN>"]  = "Decrease Height",
		["<C-UP>"]    = "Increase Height",



		-- ===================================
		-- ======== Buffer Operations
		-- ===================================
		-- Shift Buffers
		["<A-h>"] = { "<CMD>BufferLineCyclePrev<CR>", "Focus Shift Prev Buffer" },
		["<A-l>"] = { "<CMD>BufferLineCycleNext<CR>", "Focus Shift Next Buffer" },

		-- Save and Close Buffers
		["q"]         = "Save Current Buffer",
		["<LEADER>w"] = "Save All Buffers",

		["<A-w>"] = { "<CMD>update<CR><CMD>Bdelete<CR>", "Save and Close Current Buffer" },
		["<A-q>"] = { "<CMD>Bdelete<CR>", "Close Current Buffer" },


		-- ---------------------------------------------
		-- -------- Select Buffers (relative position)
		-- ---------------------------------------------
		-- By Meta Key
		["<A-1~9>"] = "Switch to Buffer <1~9>",
		["<A-1>"] = { "<CMD>BufferLineGoToBuffer 1<CR>", "which_key_ignore" },
		["<A-2>"] = { "<CMD>BufferLineGoToBuffer 2<CR>", "which_key_ignore" },
		["<A-3>"] = { "<CMD>BufferLineGoToBuffer 3<CR>", "which_key_ignore" },
		["<A-4>"] = { "<CMD>BufferLineGoToBuffer 4<CR>", "which_key_ignore" },
		["<A-5>"] = { "<CMD>BufferLineGoToBuffer 5<CR>", "which_key_ignore" },
		["<A-6>"] = { "<CMD>BufferLineGoToBuffer 6<CR>", "which_key_ignore" },
		["<A-7>"] = { "<CMD>BufferLineGoToBuffer 7<CR>", "which_key_ignore" },
		["<A-8>"] = { "<CMD>BufferLineGoToBuffer 8<CR>", "which_key_ignore" },
		["<A-9>"] = { "<CMD>BufferLineGoToBuffer 9<CR>", "which_key_ignore" },
		["<A-0>"] = { "<CMD>BufferLineGoToBuffer -1<CR>", "Buffer Last" },

		-- -- By Leader Key
		-- ["<LEADER><1~9>"] = "Switch to Buffer <1~9>",
		-- ["<LEADER>1"] = { "<CMD>BufferLineGoToBuffer 1<CR>", "which_key_ignore" },
		-- ["<LEADER>2"] = { "<CMD>BufferLineGoToBuffer 2<CR>", "which_key_ignore" },
		-- ["<LEADER>3"] = { "<CMD>BufferLineGoToBuffer 3<CR>", "which_key_ignore" },
		-- ["<LEADER>4"] = { "<CMD>BufferLineGoToBuffer 4<CR>", "which_key_ignore" },
		-- ["<LEADER>5"] = { "<CMD>BufferLineGoToBuffer 5<CR>", "which_key_ignore" },
		-- ["<LEADER>6"] = { "<CMD>BufferLineGoToBuffer 6<CR>", "which_key_ignore" },
		-- ["<LEADER>7"] = { "<CMD>BufferLineGoToBuffer 7<CR>", "which_key_ignore" },
		-- ["<LEADER>8"] = { "<CMD>BufferLineGoToBuffer 8<CR>", "which_key_ignore" },
		-- ["<LEADER>9"] = { "<CMD>BufferLineGoToBuffer 9<CR>", "which_key_ignore" },
		-- ["<LEADER>0"] = { "<CMD>BufferLineGoToBuffer -1<CR>", "Buffer Last" },

	},



	x = {
		move, edit, range,


		["<A-j>"] = { ":MoveBlock(1)<CR>",   "Move Down"  },
		["<A-k>"] = { ":MoveBlock(-1)<CR>",  "Move Up"    },
		["<A-h>"] = { ":MoveHBlock(-1)<CR>", "Move Left"  },
		["<A-l>"] = { ":MoveHBlock(1)<CR>",  "Move Right" },
	},



	o = { move, range },



	i = { move_line }
}
