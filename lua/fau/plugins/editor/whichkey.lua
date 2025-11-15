---@type LazySpec
return {
  -- DESC: Key binding helper.
  ---@module "which-key"
  "folke/which-key.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "UIEnter",

  ---@type wk.Opts
  opts = {
    preset = "classic",  ---@type false | "classic" | "modern" | "helix"
    -- delay  = nil,  -- Use default.
    -- filter = nil,  -- Use default.

    ---@type wk.Spec
    spec = {
      -- ==================== Whichkey Ignore ====================
      { "<MouseMove>", desc = "which_key_ignore" },
      { "<LeftMouse>", desc = "which_key_ignore" },
      { "<Tab>",       desc = "which_key_ignore" },
      { "<S-Tab>",     desc = "which_key_ignore" },

      -- ==================== Navigation ====================
      { "]", group = "Next", mode = { "n", "x" } },
      { "[", group = "Prev", mode = { "n", "x" } },

      -- ==================== LSP ====================
      { "g", group = "+LSP" },
      { "<LEADER>l", group = "+LSP", mode = { "n", "x" } },

      -- ==================== Git ====================
      { "<LEADER>g", "<Nop>", group = "Git", mode = { "n", "x" } },
      -- { "<LEADER>gt", group = "Gitsigns: Toggle" },

      -- ==================== Surround ====================
      { "s", group = "Surround", mode = { "n", "x" } },
      { "S", group = "SURROUND", mode = { "n", "x" } },
    },

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
    win = { border = "single", height = { min = 2, max = 0.4 } },

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
      -- ft = fvim.file.excluded_filetypes,
      -- bt = fvim.file.excluded_buftypes,
    },

    debug = false,  -- enable wk.log in the current directory
  }
}
