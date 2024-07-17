-- =============================================
-- ========== Plugin Configurations
-- =============================================
local whichkey = require("which-key")

---@type wk.Opts
local config = {
  preset = "classic",  ---@type false | "classic" | "modern" | "helix"

  ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = nil,  -- Use default.

  ---@param mapping wk.Mapping
  filter = function(mapping)
    -- example to exclude mappings without a description
    -- return mapping.desc and mapping.desc ~= ""
    return true
  end,

  ---@type wk.Spec
  spec = {},

  notify = true,

  modes = {
    n = true,  -- Normal mode
    i = true,  -- Insert mode
    x = true,  -- Visual mode
    s = true,  -- Select mode
    o = true,  -- Operator pending mode
    t = true,  -- Terminal mode
    c = true,  -- Command mode
    -- Start hidden and wait for a key to be pressed before showing the popup
    -- Only used by enabled xo mapping modes.
    -- Set to false to show the popup immediately (after the delay)
    defer = { operators = {} },
  },

  plugins = {
    marks     = true,  -- shows a list of your marks on ' and `
    registers = true,  -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling  = {
      enabled     = true,  -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20,    -- how many suggestions should be shown in the list?
    },
    presets = {
      operators    = true,  -- adds help for operators like d, y, ...
      motions      = true,  -- adds help for motions
      text_objects = true,  -- help for text objects triggered after entering an operator
      windows      = true,  -- default bindings on <c-w>
      nav          = true,  -- misc bindings to work with windows
      z            = true,  -- bindings for folds, spelling and others prefixed with z
      g            = true,  -- bindings for prefixed with g
    },
  },

  ---@type wk.Win.opts
  win = {
    no_overlap = true,  -- don't allow the popup to overlap with the cursor

    -- width = 1,
    -- height = { min = 4, max = 25 },
    -- col = 0,
    -- row = math.huge,
    border = "single",
    padding = { 1, 2 },  -- extra window padding [top/bottom, right/left]
    title = true,
    title_pos = "center",
    zindex = 1000,
    -- Additional vim.wo and vim.bo options
    bo = {},
    wo = {},
  },

  layout = {
    width = { min = 20 },  -- min and max width of the columns
    spacing = 3,           -- spacing between columns
    align = "left",        -- align columns left, center or right
  },

  keys = {
    scroll_down = "<c-f>",  -- binding to scroll down inside the popup
    scroll_up   = "<c-b>",  -- binding to scroll up inside the popup
  },

  ---@type (string|wk.Sorter)[]
  --- Mappings are sorted using configured sorters and natural sort of the keys
  --- Available sorters:
  --- * local: buffer-local mappings first
  --- * order: order of the items (Used by plugins like marks / registers)
  --- * group: groups last
  --- * alphanum: alpha-numerical first
  --- * mod: special modifier keys last
  --- * manual: the order the mappings were added
  --- * case: lower-case first
  sort = { "local", "order", "group", "alphanum", "mod" },

  ---@type number|fun(node: wk.Node):boolean?
  expand = 0,  -- expand groups when <= n mappings
  -- expand = function(node)
  --   return not node.desc -- expand all nodes without a description
  -- end,

  ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
  replace = {
    key = {
      function(key)
        return require("which-key.view").format(key)
      end,
      -- { "<Space>", "SPC" },
    },
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
    breadcrumb = "»",  -- symbol used in the command line area that shows your active key combo
    separator  = "➜",  -- symbol used between a key and it's label
    group      = "+",  -- symbol prepended to a group
    ellipsis   = "…",
    mappings = true,
    --- See `lua/which-key/icons.lua` for more details
    --- Set to `false` to disable keymap icons
    ---@type wk.IconRule[]|false
    rules = {},
    -- use the highlights from mini.icons
    -- When `false`, it will use `WhichKeyIcon` instead
    colors = true,
    -- used by key format
    keys = nil,  -- Use default.
  },

  show_help = true,  -- show a help message in the command line for using WhichKey
  show_keys = true,  -- show the currently pressed key and its label as a message in the command line
  triggers  = true,  -- automatically setup triggers

  disable = {
    -- disable WhichKey for certain buf types and file types.
    ft = Fau_vim.file.excluded_filetypes,
    bt = {},
    -- disable a trigger for a certain context by returning true
    ---@type fun(ctx: { keys: string, mode: string, plugin?: string }):boolean?
    trigger = function(ctx) return false end,
  },

  debug = false,  -- enable wk.log in the current directory
}

whichkey.setup(config)
