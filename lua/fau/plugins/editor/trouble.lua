---@type LazySpec
return {
  -- DESC: Quickfix list enhancer.
  ---@module "trouble"
  "folke/trouble.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          win = { input = { keys = { ["<c-t>"] = { "trouble_open", mode = { "n", "i" } } } } },
        },
      })
    end,
  },

  cmd = "Trouble",
  event = "LspAttach",
  keys = {
    { "<LEADER>T", "<CMD>Trouble<CR>", desc = "Troule: Show" },

    { "gd", "<CMD>Trouble lsp_definitions first<CR>",      desc = "Troule: Definition" },
    { "gD", "<CMD>Trouble lsp_declarations first<CR>",     desc = "Troule: Declaration" },
    { "gt", "<CMD>Trouble lsp_type_definitions first<CR>", desc = "Troule: Type Definition" },
    { "gI", "<CMD>Trouble lsp_implementations first<CR>",  desc = "Troule: Implementation" },
    { "gr", "<CMD>Trouble lsp_references first<CR>",       desc = "Troule: References" },
    { "gi", "<CMD>Trouble lsp_incoming_calls first<CR>",   desc = "Troule: Incoming Calls" },
    { "go", "<CMD>Trouble lsp_outgoing_calls first<CR>",   desc = "Troule: Outgoing Calls" },

    { "<LEADER>ld", "<CMD>Trouble diagnostics_buffer toggle<CR>", desc = "Troule: Buffer Diagnostics" },
    { "<LEADER>lD", "<CMD>Trouble diagnostics toggle<CR>",        desc = "Troule: Workspace Diagnostics" },
    { "<LEADER>ft", "<CMD>Trouble todo filter={tag={TODO,FIX,TEST}}<CR>", desc = "Troule: Show TODO Comments" },
  },

  config = function()
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

      indent_guides = true,   -- show indent guides
      max_items     = 200,    -- limit number of items that can be displayed per section
      multiline     = true,   -- render multi-line messages
      pinned        = false,  -- When pinned, the opened trouble window will be bound to the current buffer

      warn_no_results = true,   -- show a warning when there are no results
      open_no_results = false,  -- open the trouble window when there are no results

      ---@type trouble.Window.opts
      win = nil,  -- Use default.

      -- Window options for the preview window. Can be a split, floating window, or `main` to show the preview in the main editor window.
      ---@type trouble.Window.opts
      preview = {
        type = "main",
        scratch = true,
        on_mount = function(self) vim.w.snacks_indent = true end,
      },

      -- Throttle/Debounce settings. Should usually not be changed.
      ---@type table<string, number|{ms:number, debounce?:boolean}>
      throttle = nil,  -- Use default.

      -- Key mappings can be set to the name of a builtin action,
      -- or you can define your own custom action.
      ---@type table<string, trouble.Action.spec|false>
      keys = {
        ["?"] = "help",

        q = "close",
        ["<ESC>"] = "cancel",

        ["<TAB>"] = "jump",
        ["<CR>"]  = "jump_close",
        ["<2-leftmouse>"] = "jump",

        ["<C-s>"] = "jump_split",
        ["<C-v>"] = "jump_vsplit",

        j = "next",
        k = "prev",

        i = "inspect",
        p = "preview",
        P = "toggle_preview",

        r = "refresh",
        R = "toggle_refresh",

        dd = "delete",
        d = { action = "delete", mode = "x" },

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

        s = {
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
        -- HINT: Default config is not working. (Since set `auto_jump = true` manually in plugin config.)
        -- HACK: Set `auto_jump` to `false` to avoid jumping to the only matched item.
        lsp_definitions      = { auto_jump = false, auto_refresh = false },
        lsp_declarations     = { auto_jump = false, auto_refresh = false },
        lsp_implementations  = { auto_jump = false, auto_refresh = false },
        lsp_type_definitions = { auto_jump = false, auto_refresh = false },
        lsp_references       = { auto_jump = false, auto_refresh = false },
        lsp_incoming_calls   = { auto_jump = false, auto_refresh = false },
        lsp_outgoing_calls   = { auto_jump = false, auto_refresh = false },
        todo                 = { auto_jump = false, auto_refresh = false },

        diagnostics_buffer = { mode = "diagnostics", filter = { buf = 0 } },
      },

      icons = {
        ---@type trouble.Indent.symbols
        indent = nil,
        folder_closed = nil,
        folder_open   = nil,
        kinds = fvim.icons.kinds,
      },
    }

    -- ISSUE: Keymaps are case-sensitive. [Error like `<CR>`]
    -- HACK: Force to lowercase.
    for lhs, rhs in pairs(config.keys) do
      if type(lhs) == "string" and lhs:sub(1, 1) == "<" then config.keys[lhs:lower()] = rhs end
    end

    trouble.setup(config)
  end,
}
