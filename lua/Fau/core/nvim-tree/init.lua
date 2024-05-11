-- =============================================
-- ========== Plugin Loading
-- =============================================
local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_ok then Fau_vim.load_plugin_error("nvim-tree") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  auto_reload_on_write = true, -- Reloads the explorer every time a buffer is written to.

  create_in_closed_folder = false, -- true: new file in folder; false: new file in current level.

  disable_netrw = true, -- Completely disable netrw
  hijack_netrw  = true, -- Hijack netrw windows (overridden if |disable_netrw| is `true`)

  hijack_cursor = true,                       -- Keeps the cursor on the first letter of the filename when moving in the tree.
  hijack_unnamed_buffer_when_opening = false, -- Opens in place of the unnamed buffer if it's empty.

  on_attach = require("Fau.core.nvim-tree.keymaps"),

  sort = {
    sorter        = "name",
    folders_first = true,
    files_first   = false,
  },

  -- root_dirs = {},
  -- prefer_startup_root = false,
  sync_root_with_cwd = true, -- Changes the tree root directory on `DirChanged` and refreshes the tree.
  reload_on_bufenter = true, -- Automatically reloads the tree on `BufEnter` nvim-tree.

  respect_buf_cwd = true, -- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.

  select_prompts = true, -- using select-UI like dressing.nvim

  view = { -- Window / buffer setup.
    width = {
      min = 15,
      max = 25,
      padding = 1,
    },
    debounce_delay = 15,

    centralize_selection = false, -- When entering nvim-tree, reposition the view so that the current node is initially centralized, see |zz|.

    side = "left",
    cursorline = true,
    preserve_window_proportions = false,

    number         = false,
    relativenumber = false,
    signcolumn     = "yes",

    float = { -- Configuration options for floating window
      enable = false, -- Tree window will be floating.
      quit_on_focus_loss = true, -- Close the floating tree window when it loses focus.
      open_win_config = { -- Floating window config. See |nvim_open_win| for more details.
        relative = "editor",
        border = "rounded",
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },

  renderer = { -- UI rendering setup
    add_trailing  = false,  -- Appends a trailing slash to folder names.
    group_empty   = false, -- Compact folders that only contain a single folder into one node in the file tree.
    highlight_git = true,  -- Enable file highlight for git attributes using `NvimTreeGit` highlight groups.
    highlight_diagnostics = false,
    full_name     = true,  -- Display node whose name length is wider than the width of nvim-tree window in floating window.

    highlight_opened_files = "name", -- Highlight icons and/or names for opened files. value: `none`, `icon`, `name` or `all`
    highlight_modified = "name",
    highlight_clipboard = "name",

    root_folder_label = ":~:s?$?/..?", -- :help filename-modifiers

    indent_width = 2, --  Number of spaces for an each tree nesting level. Minimum 1.
    indent_markers = { -- Configuration options for tree indent markers.
      enable = true,        -- Display indent markers when folders are open
      inline_arrows = true, -- Display folder arrows in the same column as indent marker
      icons = { -- Icons shown before the file/directory. Length 1.
        corner = "└",
        edge   = "│",
        item   = "│",
        bottom = "─",
        none   = " ",
      },
    },

    icons = { -- Place where the git icons will be rendered.
      web_devicons = {
        file   = { enable = true, color = true },
        folder = { enable = false, color = true },
      },
      git_placement = "before", -- Place where the git icons will be rendered. value: `after` or `before`
      diagnostics_placement = "signcolumn",
      bookmarks_placement = "signcolumn",
      modified_placement = "after",
      padding = " ", -- Inserted between icon and filename.
      symlink_arrow = " ➛ ", -- Used as a separator between symlinks' source and target.
      show = { -- Configuration options for showing icon types.
        file = true, -- Show an icon before the file name.
        folder = true, -- Show an icon before the folder name.
        folder_arrow = true, -- Show a small arrow before the folder node. Arrow will be a part of the node when using |renderer.indent_markers|.
        git = true, -- Show a git status icon, see |renderer.icons.git_placement|
        modified = true,
        diagnostics = true,
        bookmarks = true,
      },

      glyphs = { -- Configuration options for icon glyphs.
        default  = Fau_vim.icons.ui.File, -- Glyph for files. Will be overridden by `nvim-web-devicons` if available.
        symlink  = Fau_vim.icons.ui.Symlink, -- Glyph for symlinks to files.
        bookmark = Fau_vim.icons.ui.Bookmark,
        modified = Fau_vim.icons.ui.Modified,
        folder = { -- Glyphs for directories.
          arrow_closed = Fau_vim.icons.ui.FoldClosed,
          arrow_open   = Fau_vim.icons.ui.FoldOpened,
          default      = Fau_vim.icons.ui.FolderOpened,
          open         = Fau_vim.icons.ui.FolderOpened,
          empty        = Fau_vim.icons.ui.EmptyFolderClosed,
          empty_open   = Fau_vim.icons.ui.EmptyFolderOpened,
          symlink      = Fau_vim.icons.ui.SymlinkFolder,
          symlink_open = Fau_vim.icons.ui.SymlinkFolder,
        },
        git = { -- Glyphs for git status.
          unstaged  = Fau_vim.icons.git.FileUnstaged,
          staged    = Fau_vim.icons.git.FileStaged,
          unmerged  = Fau_vim.icons.git.FileUnmerged,
          renamed   = Fau_vim.icons.git.FileRenamed,
          untracked = Fau_vim.icons.git.FileUntracked,
          deleted   = Fau_vim.icons.git.FileDeleted,
          ignored   = Fau_vim.icons.git.FileIgnored,
        },
      },
    },

    special_files = Fau_vim.file.special_files,
    symlink_destination = true, -- Whether to show the destination of the symlink.
  },

  hijack_directories = { -- hijacks new directory buffers when they are opened (`:e dir`).
    enable = true,    -- Enable the feature.
    auto_open = true, -- Opens the tree if the tree was previously closed.
  },

  update_focused_file = { -- Update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file.
    enable = false, -- Enable this feature.
    update_root = {
      enable = false,
      ignore_list = {},
    },
    exclude = false,
    ignore_list = {}, -- List of buffer names and filetypes that will not update the root dir of the tree if the file isn't found under the current root directory.
  },

  system_open = { -- Configuration options for the system open command.
    cmd = "", -- The command to run, leaving empty should work but useful if you want to override the default command with another one.
    args = {}, -- The command arguments as a list.
  },

  diagnostics = { -- Show LSP and COC diagnostics in the signcolumn
    enable = true,
    show_on_dirs = false, -- Show diagnostic icons on parent directories.
    show_on_open_dirs = false,
    debounce_delay = 50, -- Idle milliseconds between diagnostic event and update.
    severity = {
      min = vim.diagnostic.severity.WARN,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint    = Fau_vim.icons.diagnostics.BoldHint,
      info    = Fau_vim.icons.diagnostics.BoldInfo,
      warning = Fau_vim.icons.diagnostics.BoldWarning,
      error   = Fau_vim.icons.diagnostics.BoldError,
    },
  },

  filters = { -- Filtering options.
    enable      = true,
    git_ignored = false,
    dotfiles    = false, -- Whether show dotfiles. [Default Keymaps: H]
    git_clean   = false,
    no_buffer   = false,
    custom      = Fau_vim.file.ignored_files,
    exclude     = {}, -- List of directories or files to exclude from filtering: always show them.
  },

  filesystem_watchers = { -- Will use file system watcher to watch the filesystem for changes.
    enable = true, -- Enable / disable the feature.
    debounce_delay = 50, -- Idle milliseconds between filesystem change and action.
    ignore_dirs = {},
  },

  git = { -- Git integration with icons and colors.
    enable = true, -- Enable / disable the feature.
    show_on_dirs = true, -- Show status icons of children when directory itself has no status icon.
    show_on_open_dirs = true,
    disable_for_dirs = {},
    timeout = 500, -- Kills the git process after some time if it takes too long.
  },

  modified = { -- Indicate which file have unsaved modification.
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = false,
  },

  actions = { -- Configuration for various actions.
    use_system_clipboard = true, -- A boolean value that toggle the use of system clipboard when copy/paste function are invoked.
    change_dir = { -- vim |current-directory| behaviour.
      enable = true, -- Change the working directory when changing directories in the tree.
      global = true, -- Use `:cd` instead of `:lcd` when changing directories.
      restrict_above_cwd = false, -- Restrict changing to a directory above the global current working directory.
    },
    expand_all = { -- Configuration for expand_all behaviour.
      max_folder_discovery = 50, -- Limit the number of folders being explored when expanding every folders.
      exclude = {}, -- A list of directories that should not be expanded automatically.
    },
    file_popup = { -- Configuration for file_popup behaviour (file_info)
      open_win_config = {
        col = 1,
        row = 1,
        relative = "cursor",
        border = "shadow",
        style = "minimal",
      },
    },
    open_file = { -- Configuration options for opening a file from nvim-tree.
      quit_on_open = false, -- Closes the explorer when opening a file.
      eject = true,
      resize_window = true, -- Resizes the tree when opening a file.
      window_picker = {
        enable = true, -- If the feature is not enabled, files will open in window from which you last opened the tree.
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          -- Table of buffer option names mapped to a list of option values that indicates
          -- to the picker that the buffer's window should not be selectable.
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
    remove_file = { close_window = true }, -- Close any window displaying a file when removing the file from the tree.
  },

  trash = { -- Configuration options for trashing.
    cmd = "trash", -- The command used to trash items.  default needs `glib2` package.
  },

  live_filter = { -- Configurations for the live_filtering feature.
    prefix = "[FILTER]: ", -- Prefix of the filter displayed in the buffer.
    always_show_folders = true, -- Whether to filter folders or not.
  },

  tab = { -- Configuration for tab behaviour.
    sync = { -- Configuration for syncing nvim-tree across tabs.
      open = false, -- Opens the tree automatically when switching tabpage or opening a new tabpage if the tree was previously open.
      close = false, -- Closes the tree across all tabpages when the tree is closed.
      ignore = {}, -- List of filetypes or buffer names on new tab that will prevent
    },
  },

  notify = { threshold = vim.log.levels.INFO, absolute_path = true },

  help = { sort_by = "key" },

  ui = { confirm = { remove = true, trash = true, default_yes = true } },

  log = { -- Configuration for diagnostic logging.
    enable = false,   -- Enable logging to a file `$XDG_CACHE_HOME/nvim/nvim-tree.log`
    truncate = false, -- Remove existing log file at startup.
    types = { -- Specify which information to log.
      all = false,         -- Everything.
      config = false,      -- Options and mappings, at startup.
      copy_paste = false,  -- File copy and paste actions.
      dev = false,         -- Used for local development only. Not useful for users.
      diagnostics = false, -- LSP and COC processing, verbose.
      git = false,         -- Git processing, verbose.
      profile = false,     -- Timing of some operations.
      watcher = false,     -- |nvim-tree.filesystem_watchers| processing, verbose.
    },
  },

  experimental = {},
}


nvim_tree.setup(config)
