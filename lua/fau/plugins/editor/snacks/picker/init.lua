---@class snacks.picker.Config
return {
  enabled = true,

  prompt = nil,  -- Use default.
  sources = require("fau.plugins.editor.snacks.picker.sources"),
  focus = "input",

  show_delay = nil,  -- Use default.
  limit_live = 5000,

  layout = {
    cycle = true,
    --- Use the default layout or vertical if the window is too narrow
    preset = function() return vim.o.columns >= 120 and "default" or "dropdown" end,
  },

  -- SEE: snacks.nvim/lua/snacks/picker/config/layouts.lua
  layouts = require("fau.plugins.editor.snacks.picker.layouts"),

  ---@class snacks.picker.matcher.Config
  matcher = {
    fuzzy          = true,   -- use fuzzy matching
    smartcase      = true,   -- use smartcase
    ignorecase     = true,   -- use ignorecase
    sort_empty     = false,  -- sort results when the search string is empty
    filename_bonus = false,  -- give bonus for matching file names (last part of the path)  -- TEST: Disabled, Oct 25, 2025
    file_pos       = true,   -- support patterns like `file:line:col` and `file:line`
    -- the bonusses below, possibly require string concatenation and path normalization,
    -- so this can have a performance impact for large lists and increase memory usage
    cwd_bonus      = true,   -- give bonus for matching files in the cwd
    frecency       = true,   -- frecency bonus
    history_bonus  = true,   -- give more weight to chronological order
  },

  sort = nil,  -- Use default.

  ui_select = true,  -- replace `vim.ui.select` with the snacks picker

  ---@class snacks.picker.formatters.Config
  formatters = {
    text = nil,  -- Use default.
    file = {
      filename_first = false,     -- display filename before the file path
      truncate       = "center",  ---@type "left"|"center"|"right"
      min_width      = 20,        -- minimum length of the truncated path
      filename_only  = false,     -- only show the filename
      icon_width     = 2,         -- width of the icon (in characters)
      git_status_hl  = true,      -- use the git status highlight group for the filename
    },
    selected = {
      show_always = false,  -- only show the selected column when there are multiple selections
      unselected  = true,   -- use the unselected icon for unselected items
    },
    severity = {
      icons = true,    -- show severity icons
      level = false,   -- show severity level
      pos   = "left",  ---@type "left"|"right" position of the diagnostics
    },
  },

  ---@class snacks.picker.previewers.Config
  previewers = {
    diff = {
      builtin = true,     -- use Neovim for previewing diffs (true) or use an external tool (false)
      cmd = { "delta" },  -- example to show a diff with delta
    },
    git = {
      builtin = true,  -- use Neovim for previewing git output (true) or use git (false)
      args = {},       -- additional arguments passed to the git command. Useful to set pager options usin `-c ...`
    },
    file = {
      max_size = fvim.file.large_file_size,
      max_line_length = fvim.file.large_file_line,
      ft = nil,  ---@type string? filetype for highlighting. Use `nil` for auto detect
    },
    man_pager = nil,  ---@type string? MANPAGER env to use for `man` preview
  },

  ---@class snacks.picker.jump.Config
  jump = {
    jumplist  = true,   -- save the current position in the jumplist
    tagstack  = false,  -- save the current position in the tagstack
    reuse_win = false,  -- reuse an existing window if the buffer is already open
    close     = true,   -- close the picker when jumping/editing to a location (defaults to true)
    match     = false,  -- jump to the first match position. (useful for `lines`)
  },

  toggles = {
    follow   = "f",
    hidden   = "h",
    ignored  = { icon = "i", value = true },
    modified = "m",
    regex    = { icon = "R", value = false },
  },

  win = {
    -- input window
    input = {
      keys = {
        ["?"] = "toggle_help_input",
        ["/"] = "toggle_focus",
        ["<a-w>"] = { "cycle_win", mode = { "i", "n" } },

        ["<C-c>"] = { "cancel", mode = { "n", "i" } },
        ["<Esc>"] = "cancel",
        ["q"]     = "close",

        ["<C-Up>"]   = { "history_back",    mode = { "i", "n" } },
        ["<C-Down>"] = { "history_forward", mode = { "i", "n" } },

        ["<Tab>"]   = { "select_and_next", mode = { "n" } },
        ["<S-Tab>"] = { "select_and_prev", mode = { "n" } },
        ["<c-a>"]   = { "select_all",      mode = { "n", "i" } },

        ["<CR>"] = { "confirm", mode = { "n", "i" } },
        ---@diagnostic disable-next-line: assign-type-mismatch
        ["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },

        ["<Up>"]   = { "list_up", mode   = { "i", "n" } },
        ["<Down>"] = { "list_down", mode = { "i", "n" } },
        ["j"]  = "list_down",
        ["k"]  = "list_up",
        ["G"]  = "list_bottom",
        ["gg"] = "list_top",

        ["<a-d>"] = { "inspect", mode = { "n", "i" } },

        ["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
        ["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
        ["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
        ["<a-r>"] = { "toggle_regex", mode = { "i", "n" } },
        ["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },

        ["<c-p>"] = { "toggle_preview", mode = { "i", "n" } },
        ["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
        ["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },

        ["<c-g>"] = { "toggle_live", mode = { "i", "n" } },

        ["<c-q>"] = { "qflist", mode = { "i", "n" } },
        -- ["<c-t>"] = { "trouble_open", mode = { "n", "i" } },  -- NOTE: Set by trouble.nvim

        ["<c-s>"] = { "edit_split", mode = { "i", "n" } },
        ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
        -- ["<c-t>"] = { "tab", mode = { "n", "i" } },

        ["<c-r>#"] = { "insert_alt",      mode = "i" },
        ["<c-r>%"] = { "insert_filename", mode = "i" },
        -- ["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
        -- ["<c-r><c-f>"] = { "insert_file", mode = "i" },
        -- ["<c-r><c-l>"] = { "insert_line", mode = "i" },
        -- ["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
        -- ["<c-r><c-w>"] = { "insert_cword", mode = "i" },

        -- ["<c-w>H"] = "layout_left",
        -- ["<c-w>J"] = "layout_bottom",
        -- ["<c-w>K"] = "layout_top",
        -- ["<c-w>L"] = "layout_right",
      },
      b = { minipairs_disable = true },
    },

    -- result list window
    list = {
      keys = {
        ["?"] = "toggle_help_list",
        ["/"] = "toggle_focus",
        ["i"] = "focus_input",
        ["<a-w>"] = "cycle_win",

        ["<2-LeftMouse>"] = "confirm",
        ["<CR>"]          = "confirm",
        ---@diagnostic disable-next-line: assign-type-mismatch
        ["<S-CR>"] = { { "pick_win", "jump" } },

        ["<Esc>"] = "cancel",
        ["q"]     = "close",

        ["<Down>"] = "list_down",
        ["<Up>"]   = "list_up",
        ["j"]      = "list_down",
        ["k"]      = "list_up",
        ["G"]      = "list_bottom",
        ["gg"]     = "list_top",

        ["zb"] = "list_scroll_bottom",
        ["zt"] = "list_scroll_top",
        ["zz"] = "list_scroll_center",

        ["<Tab>"]   = { "select_and_next", mode = { "n", "x" } },
        ["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
        ["<c-a>"]   = "select_all",

        ["<a-d>"] = "inspect",

        ["<a-f>"] = "toggle_follow",
        ["<a-h>"] = "toggle_hidden",
        ["<a-i>"] = "toggle_ignored",
        ["<a-m>"] = "toggle_maximize",

        ["<c-p>"] = "toggle_preview",
        ["<c-f>"] = "preview_scroll_down",
        ["<c-b>"] = "preview_scroll_up",

        ["<c-j>"] = "list_down",
        ["<c-k>"] = "list_up",

        ["<c-q>"] = "qflist",

        ["<c-g>"] = "print_path",

        ["<c-s>"] = "edit_split",
        ["<c-v>"] = "edit_vsplit",
        ["<c-t>"] = "tab",

        -- ["<c-w>H"] = "layout_left",
        -- ["<c-w>J"] = "layout_bottom",
        -- ["<c-w>K"] = "layout_top",
        -- ["<c-w>L"] = "layout_right",
      },
      wo = {
        conceallevel = 2,
        concealcursor = "nvic",
      },
    },

    -- preview window
    preview = {
      minimal = true,
      keys = {
        ["<Esc>"] = "cancel",
        ["q"] = "close",
        ["i"] = "focus_input",
        ["<a-w>"] = "cycle_win",
      },
      wo = {
        conceallevel = 3,
        concealcursor = "nvic",

        wrap = false,
        foldenable = false,
        foldcolumn = "1",
      },
      w = { snacks_indent = false },
    },
  },

  ---@class snacks.picker.icons
  icons = {
    files = { enabled = true },

    keymaps = nil,  -- Use default.
    tree    = nil,  -- Use default.
    undo    = nil,  -- Use default.
    ui      = nil,  -- Use default.

    diagnostics = nil,  -- Use default.
    lsp = nil,          -- Use default.
    git = { enabled = true },
    kinds = fvim.icons.kinds,
  },

  ---@class snacks.picker.db.Config
  db = nil,  -- Use default.

  ---@class snacks.picker.debug
  debug = {
    scores   = false,  -- show scores in the list
    leaks    = false,  -- show when pickers don't get garbage collected
    explorer = false,  -- show explorer debug info
    files    = false,  -- show file debug info
    grep     = false,  -- show file debug info
    proc     = false,  -- show proc debug info
    extmarks = false,  -- show extmarks errors
  },
}
