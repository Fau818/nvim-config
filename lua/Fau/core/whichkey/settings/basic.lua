-- Basic (in keymaps)
local basic = {  -- n
	["U"]     = "Undo",
	["<A-u>"] = "Undo Line",

	["<A-m>"] = "Merge Line",

	["v"]     = "Visual-Block Mode",
	-- ["<C-v>"] = "Visual Mode",

	["<CR>"]         = "Add New Line",
	["<LEADER><CR>"] = "Normal Enter Key",

	["<LEADER>q"] = "Recording",

	["<LEADER>n"] = "No Highlight Search",

	["<TAB>"]   = "Indent Line",
	["<S-TAB>"] = "Unindent Line",

	["<LEADER><LEADER>c"] = "Convert Tab and Space",
	["<LEADER><LEADER>C"] = "Convert Tab and Space (Force)",

	["<C-v>"] = "Vertical Split",
	["<C-x>"] = "Horizontal Split",
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


local normal_insert = {  -- ni
	-- Move Line(s)
	["<A-j>"] = { "<CMD>MoveLine(1)<CR>", "Move Down" },
	["<A-k>"] = { "<CMD>MoveLine(-1)<CR>", "Move Up" },

	-- Escape
	["<ESC>"] = "Escape and Clear Hlsearch",
}


return {
	n = {
		basic, move, edit, normal_insert,

		-- =============================================
		-- ========== Baisc
		-- =============================================
		-- NvimTree
		["<LEADER>e"] = { "<CMD>NvimTreeFindFileToggle<CR>", "Toggle NvimTree" },

		-- Edit
		["<LEADER>E"] = {
			name = "+Edit",
			["s"] = { "<CMD>EditSnip<CR>",  "Edit Snippet" },
			["c"] = { "<CMD>EditConfiguration<CR>", "Edit Configuration" },
		},

		-- Dashboard
		[";"] = { "<CMD>Alpha<CR>", "Dashboard" },

		-- Twilight and Zen Mode
		["<LEADER><LEADER>t"] = { "<CMD>Twilight<CR>", "Toggle Twilight" },
		["<LEADER><LEADER>z"] = { "<CMD>ZenMode<CR>", "Toggle ZenMode" },

		-- Todo Comments
		["<LEADER>t"] = { "<CMD>TodoTrouble keywords=TODO,PERF,TEST,Fau<CR>", "Show Todo Comments" },

		-- Treesitter capture under cursor
		["<LEADER><LEADER>u"] = { "<CMD>TSCaptureUnderCursor<CR>", "Treesitter Capture Highlight Under Cursor" },
		["<LEADER><LEADER>n"] = { "<CMD>TSNodeUnderCursor<CR>",    "Treesitter Capture Node Under Cursor" },

		-- Lazy
		["<LEADER>ll"] = { "<CMD>Lazy<CR>", "Open Lazy (Plugin Manager)" },



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

		["<A-left>"]  = { "<CMD>BufferLineMovePrev<CR>", "Move Buffer Prev" },
		["<A-right>"] = { "<CMD>BufferLineMoveNext<CR>", "Move Buffer Next" },


		-- ---------------------------------------------
		-- -------- Select Buffers (relative position)
		-- ---------------------------------------------
		-- By Meta Key
		["<A-1~9>"] = "Switch to Buffer <1~9>",
		["<A-1>"] = { "<CMD>BufferLineGoToBuffer 1<CR>",  "which_key_ignore" },
		["<A-2>"] = { "<CMD>BufferLineGoToBuffer 2<CR>",  "which_key_ignore" },
		["<A-3>"] = { "<CMD>BufferLineGoToBuffer 3<CR>",  "which_key_ignore" },
		["<A-4>"] = { "<CMD>BufferLineGoToBuffer 4<CR>",  "which_key_ignore" },
		["<A-5>"] = { "<CMD>BufferLineGoToBuffer 5<CR>",  "which_key_ignore" },
		["<A-6>"] = { "<CMD>BufferLineGoToBuffer 6<CR>",  "which_key_ignore" },
		["<A-7>"] = { "<CMD>BufferLineGoToBuffer 7<CR>",  "which_key_ignore" },
		["<A-8>"] = { "<CMD>BufferLineGoToBuffer 8<CR>",  "which_key_ignore" },
		["<A-9>"] = { "<CMD>BufferLineGoToBuffer 9<CR>",  "which_key_ignore" },
		["<A-0>"] = { "<CMD>BufferLineGoToBuffer -1<CR>", "Buffer Last" },

		-- By Leader Key
		["<LEADER><1~9>"] = "Switch to Buffer <1~9>",
		["<LEADER>1"] = { "<CMD>BufferLineGoToBuffer 1<CR>",  "which_key_ignore" },
		["<LEADER>2"] = { "<CMD>BufferLineGoToBuffer 2<CR>",  "which_key_ignore" },
		["<LEADER>3"] = { "<CMD>BufferLineGoToBuffer 3<CR>",  "which_key_ignore" },
		["<LEADER>4"] = { "<CMD>BufferLineGoToBuffer 4<CR>",  "which_key_ignore" },
		["<LEADER>5"] = { "<CMD>BufferLineGoToBuffer 5<CR>",  "which_key_ignore" },
		["<LEADER>6"] = { "<CMD>BufferLineGoToBuffer 6<CR>",  "which_key_ignore" },
		["<LEADER>7"] = { "<CMD>BufferLineGoToBuffer 7<CR>",  "which_key_ignore" },
		["<LEADER>8"] = { "<CMD>BufferLineGoToBuffer 8<CR>",  "which_key_ignore" },
		["<LEADER>9"] = { "<CMD>BufferLineGoToBuffer 9<CR>",  "which_key_ignore" },
		["<LEADER>0"] = { "<CMD>BufferLineGoToBuffer -1<CR>", "Buffer Last" },


		-- -----------------------------------
		-- -------- TEST (from lunarvim)
		-- -----------------------------------
		["<LEADER>b"] = {
			name = "+Buffer",
			j = { "<CMD>BufferLinePick<CR>",      "Buffer Pick" },
			t = { "<CMD>BufferLineTogglePin<CR>", "Toggle Pin" },
		},


		-- ["<LEADER>p"] = {
		-- 	name = "+Packer",
		-- 	c = { "<CMD>PackerCompile<CR>", "Packer Compile" },
		-- 	i = { "<CMD>PackerInstall<CR>", "Packer Install" },
		-- 	s = { "<CMD>PackerSync<CR>",    "Packer Sync" },
		-- 	S = { "<CMD>PackerStatus<CR>",  "Packer Status" },
		-- 	u = { "<CMD>PackerUpdate<CR>",  "Packer Update" },
		-- },

	},



	x = {
		move, edit, range,

		["<LEADER><LEADER>c"] = "Convert Tab and Space (indent)",

		["<A-j>"] = { ":MoveBlock(1)<CR>",   "Move Down"  },
		["<A-k>"] = { ":MoveBlock(-1)<CR>",  "Move Up"    },
		["<A-h>"] = { ":MoveHBlock(-1)<CR>", "Move Left"  },
		["<A-l>"] = { ":MoveHBlock(1)<CR>",  "Move Right" },
	},



	o = { move, range },



	i = { normal_insert }
}
