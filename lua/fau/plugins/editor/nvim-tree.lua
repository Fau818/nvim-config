---If the file is binary, open it in system file explorer.
---@param mode "edit" | "preview"
---@return nil
local function _smart_open(mode)
  local api = require("nvim-tree.api")
  local function fallback(node)
    if mode == "edit" then api.node.open.edit(node)
    elseif mode == "preview" then api.node.open.preview(node)
    else fvim.notify("nvim-tree: Unknown open mode!", vim.log.levels.ERROR)
    end
  end

  -- Get basic information.
  local node = api.tree.get_node_under_cursor()
  if not node then fvim.notify("nvim-tree: Get node info error!", vim.log.levels.ERROR) return end

  if node.type == "file" then
    -- EXIT: Empty file -> handle as normal file.
    ---@diagnostic disable-next-line: undefined-field
    if node.fs_stat.size == 0 then return fallback(node) end
    -- EXIT: No `file` command -> handle as normal file.
    if vim.fn.executable("file") ~= 1 then return fallback(node) end

    local result = vim.fn.system({ "file", "--mime-encoding", "-b", node.absolute_path }):sub(1, -2)  -- trim line break char
    if result == "binary" then
      fvim.notify("Binary file, open it in system. (Use `o` to force edit it in neovim)", vim.log.levels.INFO)
      return api.node.run.system(node)
    end
  end

  return fallback(node)
end


local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc) return { desc = desc, buffer = bufnr } end

  -- ==================== Open ====================
  vim.keymap.set("n", "<CR>",          function() _smart_open("edit") end,    opts("Open: Smart Open"))
  vim.keymap.set("n", "<2-LeftMouse>", function() _smart_open("edit") end,    opts("Open: Smart Open"))
  vim.keymap.set("n", "o",             api.node.open.edit,                   opts("Open: Edit"))
  vim.keymap.set("n", "O",             api.node.open.no_window_picker,       opts("Open: Edit with Window Picker"))
  vim.keymap.set("n", "<Tab>",         function() _smart_open("preview") end, opts("Open: Smart Preview"))
  vim.keymap.set("n", "<C-f>",         api.node.run.system,                  opts("Open: Reveal in System"))

  vim.keymap.set("n", "<C-t>",         api.node.open.tab,              opts("Open: Open in Tab"))
  vim.keymap.set("n", "<C-v>",         api.node.open.vertical,         opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-x>",         api.node.open.horizontal,       opts("Open: Horizontal Split"))

  -- ==================== Change Work Directory ====================
  vim.keymap.set("n", "<C-]>",          api.tree.change_root_to_node, opts("CD: Change Root"))
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD: Change Root"))

  -- ==================== Filter ====================
  vim.keymap.set("n", "f", api.live_filter.start, opts("Filter: Start"))
  vim.keymap.set("n", "F", api.live_filter.clear, opts("Filter: Clear"))
  -- vim.keymap.set("n", "s", api.tree.search_node,  opts("Search File"))

  -- ==================== Rename ====================
  vim.keymap.set("n", "r",     api.fs.rename_basename, opts("Rename: Basename"))
  vim.keymap.set("n", "lr",    api.fs.rename,          opts("Rename: Filename"))
  vim.keymap.set("n", "<C-r>", api.fs.rename_full,     opts("Rename: Full Path"))

  -- ==================== Copy Name/Path ====================
  vim.keymap.set("n", "ge", api.fs.copy.basename,      opts("Copy: Basename"))
  vim.keymap.set("n", "y",  api.fs.copy.filename,      opts("Copy: Filename"))
  vim.keymap.set("n", "Y",  api.fs.copy.relative_path, opts("Copy: Relative Path"))
  vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy: Absolute Path"))

  -- ==================== File Operations ====================
  vim.keymap.set("n", "a", api.fs.create,    opts("File: Create"))
  vim.keymap.set("n", "x", api.fs.cut,       opts("File: Cut"))
  vim.keymap.set("n", "c", api.fs.copy.node, opts("File: Copy"))
  vim.keymap.set("n", "d", api.fs.trash,     opts("File: Trash"))
  vim.keymap.set("n", "D", api.fs.remove,    opts("File: Delete"))
  vim.keymap.set("n", "p", api.fs.paste,     opts("File: Paste"))

  -- ==================== View ====================
  vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("View: Toggle Buffer"))
  vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("View: Toggle Git"))
  vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("View: Toggle Ignore"))
  vim.keymap.set("n", "U", api.tree.toggle_custom_filter,    opts("View: Toggle Hidden"))

  -- ==================== Expand/Collapse ====================
  vim.keymap.set("n", "E", api.tree.expand_all,   opts("Node: Expand All"))
  vim.keymap.set("n", "W", api.tree.collapse_all, opts("Node: Collapse All"))

  -- ==================== Navigation ====================
  vim.keymap.set("n", "P",    api.node.navigate.parent,        opts("Node: Parent Directory"))
  vim.keymap.set("n", "<BS>", api.node.navigate.parent_close,  opts("Node: Close Directory"))
  vim.keymap.set("n", "H",    api.node.navigate.sibling.first, opts("Node: First Sibling"))
  vim.keymap.set("n", "L",    api.node.navigate.sibling.last,  opts("Node: Last Sibling"))

  vim.keymap.set("n", "[g", api.node.navigate.git.prev_skip_gitignored, opts("Git: Prev"))
  vim.keymap.set("n", "]g", api.node.navigate.git.next_skip_gitignored, opts("Git: Next"))

  vim.keymap.set("n", "[d", api.node.navigate.diagnostics.prev, opts("Diagnostic: Prev"))
  vim.keymap.set("n", "]d", api.node.navigate.diagnostics.next, opts("Diagnostic: Next"))

  -- ==================== Node Operations ====================
  vim.keymap.set("n", "i", api.node.show_info_popup, opts("Node: Info"))
  vim.keymap.set("n", ".", api.node.run.cmd,         opts("Node: Run Command"))

  -- ==================== Tree Operations ====================
  vim.keymap.set("n", "R",     api.tree.reload,      opts("Tree: Refresh"))
  vim.keymap.set("n", "g?",    api.tree.toggle_help, opts("Tree: Help"))
  vim.keymap.set("n", "?",     api.tree.toggle_help, opts("Tree: Help"))
  vim.keymap.set("n", "q",     api.tree.close,       opts("Tree: Close"))
  vim.keymap.set("n", "<ESC>", api.tree.close,       opts("Tree: Close"))

  -- ==================== Marks ====================
  -- vim.keymap.set("n", "m",   api.marks.toggle,                   opts("Bookmark: Toggle"))
  -- vim.keymap.set("n", "bmv", api.marks.bulk.move,                opts("Bookmark: Move"))
  -- vim.keymap.set("n", "bt",  api.marks.bulk.trash,               opts("Bookmark: Trash"))
  -- vim.keymap.set("n", "bd",  api.marks.bulk.delete,              opts("Bookmark: Delete"))
  -- vim.keymap.set("n", "M",   api.tree.toggle_no_bookmark_filter, opts("Toggle Filter: No Bookmark"))

  -- vim.keymap.set("n", "<C-e>",          api.node.open.replace_tree_buffer,  opts("Open: In Place"))
  -- vim.keymap.set("n", "L",              api.node.open.toggle_group_empty,    opts("Toggle Group Empty"))
  -- vim.keymap.set("n", "H",              api.tree.toggle_hidden_filter,      opts("Toggle Filter: Dotfiles"))
  -- vim.keymap.set("n", ">",              api.node.navigate.sibling.next,     opts("Next Sibling"))
  -- vim.keymap.set("n", "<",              api.node.navigate.sibling.prev,     opts("Previous Sibling"))
  -- vim.keymap.set("n", "-",              api.tree.change_root_to_parent,     opts("CD: Change Root to Parent"))
end


---@type LazySpec[]
return {
  {
    -- DESC: File explorer tree for Neovim.
    ---@module "nvim-tree"
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = {
      "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle",
      "NvimTreeFindFile", "NvimTreeFindFileToggle",
      "NvimTreeFocus", "NvimTreeRefresh",
      "NvimTreeCollapse", "NvimTreeCollapseKeepBuffers",
      "NvimTreeClipboard", "NvimTreeResize", "NvimTreeHiTest",
    },
    keys = { { "<LEADER>e", "<CMD>NvimTreeFindFileToggle<CR>", desc = "nvim-tree: Toggle" } },

    init = function()
      -- Disable netrw.
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Show nvim-tree when opening a directory in Neovim.",
        callback = function(data)
          local directory = vim.fn.isdirectory(data.file) == 1
          if not directory then return end

          vim.cmd.enew()
          vim.cmd.bw(data.buf)
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
        end,
      })

    end,

    opts = {
      auto_reload_on_write = true,  -- Reloads the explorer every time a buffer is written to.

      disable_netrw = true,  -- Completely disable netrw
      hijack_netrw  = true,  -- Hijack netrw windows (overridden if |disable_netrw| is `true`)

      hijack_cursor = true,  -- Keeps the cursor on the first letter of the filename when moving in the tree.
      hijack_unnamed_buffer_when_opening = false,  -- Opens in place of the unnamed buffer if it's empty.

      on_attach = on_attach,

      -- root_dirs = {},  -- Use default.
      prefer_startup_root = true,
      sync_root_with_cwd = true,  -- Changes the tree root directory on `DirChanged` and refreshes the tree.
      -- TEST: Disabled as the default behavior.  Oct 29, 2025
      reload_on_bufenter = false,  -- Automatically reloads the tree on `BufEnter` nvim-tree.
      respect_buf_cwd = true,     -- Will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.

      select_prompts = true,

      sort = { sorter = "name", folders_first = true, files_first = false },

      view = {
        width = { min = 15, max = 35, padding = 1 },
        side = "left",

        cursorline = true,
        cursorlineopt = "both",

        debounce_delay = fvim.settings.debounce.explore,

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

        -- root_folder_label   = nil,  -- Use default.
        special_files       = fvim.file.special_files,
        symlink_destination = true,  -- Whether to show the destination of the symlink.
        hidden_display      = "none",  ---@type "none" | "simple" | "all"

        -- decorators = nil,  -- Use default.
        ---@type "all" | "name" | "icon" | "none"
        highlight_git          = "name",
        highlight_diagnostics  = "name",
        highlight_opened_files = "name",
        highlight_modified     = "name",
        highlight_hidden       = "none",
        highlight_bookmarks    = "none",
        highlight_clipboard    = "all",

        indent_width = 2,
        indent_markers = { enable = true, inline_arrows = true, icons = nil },

        icons = {
          web_devicons = {
            file   = { enable = true, color = true },
            folder = { enable = false, color = true },
          },

          ---@type "before" | "after" | "signcolumn" | "right_align"
          git_placement         = "before",
          diagnostics_placement = "right_align",
          modified_placement    = "after",
          hidden_placement      = "before",
          bookmarks_placement   = "signcolumn",

          -- padding = nil,        -- Use default.
          -- symlink_arrow = nil,  -- Use default.

          show = { file = true, folder = true, folder_arrow = true, git = true, hidden = true, modified = true, diagnostics = true, bookmarks = true },

          glyphs = nil,  -- Use default.
        },
      },

      hijack_directories = { enable = true, auto_open = true },

      update_focused_file = {
        enable = true,
        update_root = { enable = true, ignore_list = {} },
        exclude = false,
      },

      system_open = vim.fn.has("mac") == 1 and { cmd = "open", args = { "-R" } } or nil,

      filters = {
        enable      = true,
        git_ignored = true,
        dotfiles    = false,
        git_clean   = false,
        no_buffer   = false,
        custom      = fvim.file.ignored_files,
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
        timeout = fvim.settings.timeout.git,
        cygwin_support = nil,  -- Use default (for windows).
      },

      diagnostics = {
        enable = true,
        show_on_dirs = false,
        show_on_open_dirs = false,
        debounce_delay = fvim.settings.debounce.diagnostics,
        severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR },
        icons = {
          hint    = fvim.icons.diagnostics.BoldHint,
          info    = fvim.icons.diagnostics.BoldInfo,
          warning = fvim.icons.diagnostics.BoldWarn,
          error   = fvim.icons.diagnostics.BoldError,
        },
        diagnostic_opts = false,
      },

      modified = { enable = true, show_on_dirs = false, show_on_open_dirs = false },

      filesystem_watchers = {
        enable = true,
        debounce_delay = fvim.settings.debounce.explore,
        -- ignore_dirs = nil, -- Use default.
      },

      actions = {
        use_system_clipboard = true,
        change_dir = { enable = true, global = true, restrict_above_cwd = false },
        expand_all = { max_folder_discovery = fvim.file.large_folder_count, exclude = {} },
        -- file_popup = nil,  -- Use default.
        open_file = {
          quit_on_open = false,
          eject = true,
          resize_window = true,
          relative_path = true,  -- Buffers opened by nvim-tree will use with relative paths instead of absolute.
          window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = fvim.file.excluded_filetypes,
              buftype = fvim.file.excluded_buftypes,
            },
          },
        },
        remove_file = { close_window = true },
      },

      trash = vim.fn.has("mac") == 1 and { cmd = "trash" } or nil,

      -- tab = nil,  -- Use default.

      notify = { threshold = vim.log.levels.INFO, absolute_path = true },

      help = { sort_by = "key" },

      ui = { confirm = { remove = true, trash = true, default_yes = true } },

      experimental = {},

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
    },
  },


  -- TEST: Use Snacks.reanme module.  Oct 30, 2025
  -- {
  --   -- DESC: Add LSP support for file operations in NvimTree.
  --   ---@module "lsp-file-operations"
  --   "antosha417/nvim-lsp-file-operations",
  --   dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
  --   ft = "NvimTree",
  --   config = true,
  -- },
}
