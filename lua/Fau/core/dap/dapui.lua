-- ==================================================
-- ========== DAP settings (does not belong to dapui)
-- ==================================================
vim.fn.sign_define("DapBreakpoint", { text = Fau_vim.icons.ui.BreakPoint, texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = Fau_vim.icons.ui.BoldArrowRight, texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "DiagnosticSignWarn" })



-- =============================================
-- ========== Plugin Loading
-- =============================================
local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then Fau_vim.load_plugin_error("dapui") return end



-- =============================================
-- ========== Configuration
-- =============================================
local icons = Fau_vim.icons.dapui
local config = {
  icons = { expanded = icons.Expanded, collapsed = icons.Collapsed, current_frame = icons.Circular },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open   = "o",
    remove = "d",
    edit   = "e",
    repl   = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause     = icons.Pause,
      play      = icons.Play,
      step_into = icons.StepInto,
      step_over = icons.StepOver,
      step_out  = icons.StepOut,
      step_back = icons.StepBack,
      run_last  = icons.RunLast,
      terminate = icons.Terminate,
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
}


dapui.setup(config)
