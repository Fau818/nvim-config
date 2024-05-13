-- Quick Move
local move = {  -- nxo
  ["H"] = "Line Begin",
  ["J"] = "Five Lines Down",
  ["K"] = "Five Lines Up",
  ["L"] = "Line End",
}


-- Basic (in keymaps)
local basic = {  -- n
  ["<MouseMove>"] = "which_key_ignore",

  -- Save and Close Buffers
  ["q"]         = "Save Current Buffer",
  ["<LEADER>w"] = "Save All Buffers",
  ["<A-w>"]     = "Save All Buffers",
  ["<A-q>"]     = { Fau_vim.functions.utils.buf_remove, "Close Current Buffer" },
  ["Q"]         = "Close Current Window",
  ["<C-S-q>"]   = "Close VIM",

  ["<ESC>"] = "Escape and Clear Hlsearch",

  ["U"]     = "Undo",
  ["<A-u>"] = "Undo Line",

  ["<A-m>"] = "Merge Line",

  ["v"]     = "Visual-Block Mode",

  ["<CR>"]         = "Add New Line",
  ["<LEADER><CR>"] = "Normal Enter Key",

  ["<LEADER>N"] = "No Highlight Search",

  ["<LEADER>q"] = "Recording",

  ["<C-f>"] = "Reveal file or Scroll Down",
  ["<C-b>"] = "which_key_ignore",

  ["<LEADER><LEADER>c"] = "Convert Tab and Space",

  ["<TAB>"]   = "Indent Line",
  ["<S-TAB>"] = "Unindent Line",

  ["<C-v>"] = "Vertical Split",

  ["<LEADER>e"] = { "<CMD>NvimTreeFindFileToggle<CR>", "Toggle NvimTree" },

}


-- Cut, Yank and Paste
local edit = {  -- nx
  x = "Delete Char",
  X = "DELETE Char",

  c = "Delete and Enter Insert Mode",
  C = "DELETE and Enter Insert Mode",

  d = "+Cut in VIM Clipboard",
  D = "+CUT in VIM Clipboard",

  y = "+Yank in System Clipboard",
  Y = "+YANK in System Clipboard",

  p = "Paste in System Clipboard",
  P = "PASTE in System Clipboard",

  ["<LEADER>d"] = "+Cut in System Clipboard",
  ["<LEADER>D"] = "+CUT in System Clipboard",

  ["<LEADER>y"] = "+Yank in VIM Clipboard",
  ["<LEADER>Y"] = "+YANK in VIM Clipboard",

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


local move_lines = {  -- nxi
  ["<A-j>"] = "Move Line Down",
  ["<A-k>"] = "Move Line Up",
}


local windows_terminal = {  -- nt
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
}


return {
  n = {
    basic, move, edit, move_lines, windows_terminal,

    -- -----------------------------------
    -- -------- MISC
    -- -----------------------------------
    -- Edit
    ["<LEADER>E"] = {
      name = "+Edit",
      ["s"] = { "<CMD>EditSnip<CR>",  "Edit Snippet" },
      ["c"] = { "<CMD>EditConfiguration<CR>", "Edit Configuration" },
    },

    -- Lazy
    ["<LEADER>ll"] = { require("lazy").home, "Open Lazy (Plugin Manager)" },

    -- Toggle indent
    ["<LEADER><LEADER>i"] = { Fau_vim.functions.indent.toggle_indent_width, "Toggle Indent Width" },
    -- Fau: I don't think this is helpful.
    ["<LEADER><LEADER>I"] = { function() Fau_vim.functions.indent.toggle_indent_width(true) end, "Toggle Indent Width (Force)" },


    -- -----------------------------------
    -- -------- Buffer Navigation
    -- -----------------------------------
    ["<A-1~9>"]       = "Switch to Buffer <1~9>",
    ["<LEADER><1~9>"] = "Switch to Buffer <1~9>",


  },


  x = {
    move, edit, range, move_lines,

    ["<LEADER><LEADER>c"] = "Convert Tab and Space (indent)",

    ["<TAB>"]   = "Indent Line",
    ["<S-TAB>"] = "Unindent Line",
  },


  o = { move, range },
  i = { move_lines },
  t = { windows_terminal },
}
