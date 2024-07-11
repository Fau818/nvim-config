-- =============================================
-- ========== Plugin Configurations
-- =============================================
local nvim_tree = require("nvim-tree")

local config = {
  auto_reload_on_write = true,  -- Reloads the explorer every time a buffer is written to.

  disable_netrw = true,  -- Completely disable netrw
  hijack_netrw  = true,  -- Hijack netrw windows (overridden if |disable_netrw| is `true`)

  hijack_cursor = true,                        -- Keeps the cursor on the first letter of the filename when moving in the tree.
  hijack_unnamed_buffer_when_opening = false,  -- Opens in place of the unnamed buffer if it's empty.

  on_attach = require("Fau.configs.editor.nvim-tree.keymaps"),

  -- root_dirs = {},
  -- prefer_startup_root = false,
  sync_root_with_cwd = true,  -- Changes the tree root directory on `DirChanged` and refreshes the tree.
  reload_on_bufenter = true,  -- Automatically reloads the tree on `BufEnter` nvim-tree.
  respect_buf_cwd = true,     -- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.

  select_prompts = true,  -- Using select-UI like dressing.nvim

  sort = {
    sorter        = "name",
    folders_first = true,
    files_first   = false,
  },

  view = {
    width = { min = 15, max = 30, padding = 1 },
    side = "left",
    cursorline = true,

    debounce_delay = 15,
    centralize_selection = false,
    preserve_window_proportions = false,

    number         = false,
    relativenumber = false,
    signcolumn     = "auto",

    float = { enable = false },
  },

  renderer = {
    add_trailing = false,  -- Appends a trailing slash to folder names.
    group_empty  = false,  -- Compact folders that only contain a single folder into one node in the file tree.
    full_name    = true,   -- Display node whose name length is wider than the width of nvim-tree window in floating window.

    root_folder_label = nil,  -- Use default.
    special_files = Fau_vim.file.special_files,
    symlink_destination = true,  -- Whether to show the destination of the symlink.

    highlight_git          = "name",
    highlight_diagnostics  = "all",
    highlight_opened_files = "name",
    highlight_modified     = "all",
    highlight_clipboard    = "name",

    indent_width = 2,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = nil,  -- Use default.
    },

    icons = {
      web_devicons = {
        file   = { enable = true, color = true },
        folder = { enable = false, color = true },
      },

      git_placement         = "before",
      diagnostics_placement = "signcolumn",
      modified_placement    = "after",
      bookmarks_placement   = "signcolumn",

      padding = nil,        -- Use default.
      symlink_arrow = nil,  -- Use default.

      show = { file = true, folder = true, folder_arrow = true, git = true, modified = true, diagnostics = true, bookmarks = true },

      glyphs = nil,  -- Use default.
    },
  },

  hijack_directories = { enable = true, auto_open = true },

  update_focused_file = {
    enable = false,
    update_root = {enable = false, ignore_list = {}},
    exclude = false,
  },

  system_open = { cmd = "", args = {} },

  filters = {
    enable      = true,
    git_ignored = false,
    dotfiles    = false,
    git_clean   = false,
    no_buffer   = false,
    custom      = Fau_vim.file.ignored_files,
    exclude     = {},  -- List of directories or files to exclude from filtering: always show them.
  },

  live_filter = {
    prefix = "[FILTER]: ",
    always_show_folders = true,
  },

  git = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
    disable_for_dirs = {},
    timeout = 500,
    cygwin_support = nil,  -- Use default (for windows).
  },

  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = false,
    debounce_delay = 50,
    severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR,  },
    icons = {
      hint    = Fau_vim.icons.diagnostics.BoldHint,
      info    = Fau_vim.icons.diagnostics.BoldInfo,
      warning = Fau_vim.icons.diagnostics.BoldWarning,
      error   = Fau_vim.icons.diagnostics.BoldError,
    },
  },

  modified = { enable = true, show_on_dirs = false, show_on_open_dirs = false },

  filesystem_watchers = { enable = true, debounce_delay = 50, ignore_dirs = {} },

  actions = {
    use_system_clipboard = true,
    change_dir = { enable = true, global = true, restrict_above_cwd = false },
    expand_all = { max_folder_discovery = 50, exclude = {} },
    file_popup = { open_win_config = { col = 1, row = 1, relative = "cursor", border = "shadow", style = "minimal" } },
    open_file = {
      quit_on_open = false,
      eject = true,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = Fau_vim.file.excluded_filetypes,
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = { close_window = true },
  },

  trash = { cmd = "trash" },  -- NOTE: Only works on macOS

  tab = { sync = { open = false, close = false, ignore = {} } },

  notify = { threshold = vim.log.levels.INFO, absolute_path = true },

  help = { sort_by = "key" },

  ui = { confirm = { remove = true, trash = true, default_yes = true } },

  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      dev = false,
      diagnostics = false,
      git = false,
      profile = false,
      watcher = false,
    },
  },

  experimental = {},
}

nvim_tree.setup(config)
