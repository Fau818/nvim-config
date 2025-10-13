-- =============================================
-- ========== Plugin Configurations
-- =============================================
local whichkey = require("which-key")

---@type wk.Opts
local config = {
  preset = "classic",  ---@type false | "classic" | "modern" | "helix"
  -- delay  = nil,  -- Use default.
  -- filter = nil,  -- Use default.
  -- spec   = nil,  ---@type wk.Spec
  notify = true,

  ---@type wk.Spec
  triggers = { { "<auto>", mode = "nxsot" } },

  -- Start hidden and wait for a key to be pressed before showing the popup
  -- Only used by enabled xo mapping modes.
  ---@param ctx { mode: string, operator: string }
  defer = function(ctx) return ctx.mode == "v" or ctx.mode == "V" or ctx.mode == "<C-V>" end,

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
    -- key  = nil,  -- Use default.
    -- desc = nil,  -- Use default.
  },

  icons = nil,  -- Use default.

  show_help = true,  -- show a help message in the command line for using WhichKey
  show_keys = true,  -- show the currently pressed key and its label as a message in the command line

  disable = {
    -- disable WhichKey for certain buf types and file types.
    -- ft = Fau_vim.file.excluded_filetypes,
    -- bt = Fau_vim.file.excluded_buftypes,
  },

  debug = false,  -- enable wk.log in the current directory
}

whichkey.setup(config)
