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

  ["<LEADER>N"] = "No Highlight Search",

  ["<TAB>"]   = "Indent Line",
  ["<S-TAB>"] = "Unindent Line",

  ["<LEADER><LEADER>c"] = "Convert Tab and Space",

  ["<C-v>"] = "Vertical Split",
  -- ["<C-x>"] = "Horizontal Split",

  ["<C-f>"] = "Open in System Explorer and Scroll Down",
  ["<C-b>"] = "Scroll Up",

  ["<MouseMove>"] = "which_key_ignore"
}


-- Quick Move
local move = {  -- nxo
  ["H"] = "Line Begin",
  ["J"] = "Five Lines Down",
  ["K"] = "Five Lines Up",
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


local normal_insert = {
  -- Escape
  ["<ESC>"] = "Escape and Clear Hlsearch",

  ["<A-j>"] = "Move Line Down",
  ["<A-k>"] = "Move Line Up",
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
    -- ["<LEADER>t"] = { "<CMD>TodoTrouble keywords=TODO,PERF,TEST,Fau<CR>", "Show Todo Comments" },
    -- Trouble
    ["<LEADER>t"] = { "<CMD>Trouble<CR>", "Show Trouble" },

    -- Treesitter capture under cursor
    ["<LEADER><LEADER>u"] = { "<CMD>TSCaptureUnderCursor<CR>", "Treesitter Capture Highlight Under Cursor" },
    ["<LEADER><LEADER>n"] = { "<CMD>TSNodeUnderCursor<CR>",    "Treesitter Capture Node Under Cursor" },

    -- Lazy
    ["<LEADER>ll"] = { require("lazy").home, "Open Lazy (Plugin Manager)" },

    -- Toggle indent
    ["<LEADER><LEADER>i"] = { Fau_vim.functions.indent.toggle_indent_width, "Toggle Indent Width" },
    -- NOTE: I don't think this is helpful.
    ["<LEADER><LEADER>I"] = { function() Fau_vim.functions.indent.toggle_indent_width(true) end, "Toggle Indent Width (Force)" },

    -- Split and Join
    ["sj"] = { "<CMD>TSJToggle<CR>", "Split and Join" },
    ["<LEADER>n"] = { require('ts-node-action').node_action, "Split and Join" },



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

    -- TODO: move lines and close buffers be a command with fallback
    ["<A-w>"] = "Save All Buffers",
    ["<A-q>"] = { Fau_vim.functions.utils.buf_remove, "Close Current Buffer" },

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

  },



  x = {
    move, edit, range,

    ["<LEADER><LEADER>c"] = "Convert Tab and Space (indent)",

    ["<A-j>"] = "Move Block Down",
    ["<A-k>"] = "Move Block Up",
    ["<A-h>"] = "Move Block Left",
    ["<A-l>"] = "Move Block Right",
  },



  o = { move, range },



  i = { normal_insert }
}
