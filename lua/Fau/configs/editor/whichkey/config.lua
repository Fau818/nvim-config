-- =============================================
-- ========== Plugin Configurations
-- =============================================
local whichkey = require("which-key")

---@type wk.Opts
local config = {
  preset = "classic",  ---@type false | "classic" | "modern" | "helix"
  delay  = nil,  -- Use default.
  filter = nil,  -- Use default.
  spec   = {},  ---@type wk.Spec
  notify = true,

  ---@type wk.Spec
  triggers = { "<LEADER>", mode = "nxsot" },  -- Only <LEADER> to trigger whichkey.

  defer = function() end,  -- Disabled

  plugins = {
    marks     = true,
    registers = true,
    spelling  = { enabled = true, suggestions = 20 },
    presets   = { operators = true, motions = true, text_objects = true, windows = true, nav = true, z = true, g = true },
  },

  ---@type wk.Win.opts
  win = {
    no_overlap = true,
    border = "single",
    padding = { 1, 2 },
    title = true,
    title_pos = "center",
    zindex = 1000,
    bo = {},
    wo = {},
  },

  layout = { width = { min = 20 }, spacing = 3 },

  keys = { scroll_down = "<C-f>", scroll_up = "<C-b>" },

  ---@type (string|wk.Sorter)[]
  sort = nil,  -- Use default.

  ---@type number|fun(node: wk.Node):boolean?
  expand = 0,

  ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
  replace = {
    -- key = nil,  -- Use default.
    desc = {
      { "<Plug>%(?(.*)%)?", "%1" },
      { "^%+",              "" },
      { "<[cC][mM][dD]>",   "" },
      { "<[cC][rR]>",       "" },
      { "<[sS]ilent>",      "" },
      { "^lua%s+",          "" },
      { "^call%s+",         "" },
      { "^:%s*",            "" },
    },
  },

  icons = {
    breadcrumb = "»",
    separator  = "➜",
    group      = "+",
    ellipsis   = "…",
    mappings   = true,
    ---See `lua/which-key/icons.lua` for more details
    ---Set to `false` to disable keymap icons
    ---@type wk.IconRule[]|false
    rules = {},
    colors = true,
    keys = nil,  -- Use default.
  },

  show_help = true,  -- show a help message in the command line for using WhichKey
  show_keys = true,  -- show the currently pressed key and its label as a message in the command line

  disable = {
    -- disable WhichKey for certain buf types and file types.
    ft = {},
    bt = {},
  },

  debug = false,  -- enable wk.log in the current directory
}

whichkey.setup(config)
