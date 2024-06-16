-- =============================================
-- ========== Plugin Configurations
-- =============================================
local trouble = require("trouble")

---@type trouble.Config
local config = {
  auto_close   = false,  -- auto close when there are no items
  auto_open    = false,  -- auto open when there are items
  auto_preview = true,   -- automatically open preview when on an item
  auto_refresh = true,   -- auto refresh when open
  auto_jump    = false,  -- auto jump to the item when there's only one

  focus   = true,  -- Focus the window when opened
  restore = true,  -- restores the last location in the list when opening
  follow  = true,  -- Follow the current item

  indent_guides = true,  -- show indent guides
  max_items = 200,       -- limit number of items that can be displayed per section
  multiline = true,      -- render multi-line messages
  pinned = false,        -- When pinned, the opened trouble window will be bound to the current buffer

  warn_no_results = true,   -- show a warning when there are no results
  open_no_results = false,  -- open the trouble window when there are no results

  ---@type trouble.Window.opts
  win = {}, -- window options for the results window. Can be a split or a floating window.

  -- Window options for the preview window. Can be a split, floating window, or `main` to show the preview in the main editor window.
  ---@type trouble.Window.opts
  preview = {
    type = "main",
    -- when a buffer is not yet loaded, the preview window will be created
    -- in a scratch buffer with only syntax highlighting enabled.
    -- Set to false, if you want the preview to always be a real loaded buffer.
    scratch = true,
  },

  -- Throttle/Debounce settings. Should usually not be changed.
  ---@type table<string, number|{ms:number, debounce?:boolean}>
  throttle = {
    refresh = 20,   -- fetches new data when needed
    update  = 10,   -- updates the window
    render  = 10,   -- renders the window
    follow  = 100,  -- follows the current item
    preview = { ms = 100, debounce = true },  -- shows the preview for the current item
  },

  -- Key mappings can be set to the name of a builtin action,
  -- or you can define your own custom action.
  ---@type table<string, trouble.Action.spec>
  keys = {
    ["?"] = "help",

    q = "close",
    r = "refresh",
    R = "toggle_refresh",

    ["<ESC>"] = "cancel",
    ["<TAB>"] = "jump",
    ["<CR>"]  = "jump_close",

    ["<2-leftmouse>"] = "jump",
    ["<C-s>"] = "jump_split",
    ["<C-v>"] = "jump_vsplit",

    ["j"] = "next",
    ["k"] = "prev",

    dd = "delete",
    d = { action = "delete", mode = "v" },

    i = "inspect",

    p = "preview",
    P = "toggle_preview",

    zo = "fold_open",
    zO = "fold_open_recursive",
    zc = "fold_close",
    zC = "fold_close_recursive",
    za = "fold_toggle",
    zA = "fold_toggle_recursive",
    zm = "fold_more",
    zM = "fold_close_all",
    zr = "fold_reduce",
    zR = "fold_open_all",
    zx = "fold_update",
    zX = "fold_update_all",
    zn = "fold_disable",
    zN = "fold_enable",
    zi = "fold_toggle_enable",

    s = {  -- example of a custom action that toggles the severity
      action = function(view)
        local f = view:get_filter("severity")
        local severity = ((f and f.filter.severity or 0) + 1) % 5
        view:filter({ severity = severity }, {
          id = "severity",
          template = "{hl:Title}Filter:{hl} {severity}",
          del = severity == 0,
        })
      end,
      desc = "Toggle Severity Filter",
    },
  },

  ---@type table<string, trouble.Mode>
  modes = {
    -- FIXME: Default config is not working.
    lsp_references       = { auto_jump = false },
    lsp_definitions      = { auto_jump = false },
    lsp_implementations  = { auto_jump = false },
    -- lsp_type_definitions = { auto_jump = false },
    lsp_declarations     = { auto_jump = false },
    lsp_incoming_calls   = { auto_jump = false },
    lsp_outgoing_calls   = { auto_jump = false },

    diagnostics_buffer = {
      mode = "diagnostics",  -- inherit from diagnostics mode
      filter = { buf = 0 },  -- filter diagnostics to the current buffer
    },
  },

  icons = {
    ---@type trouble.Indent.symbols
    indent = nil,
    folder_closed = nil,
    folder_open   = nil,
    kinds = Fau_vim.icons.kind,
  },
}

trouble.setup(config)
