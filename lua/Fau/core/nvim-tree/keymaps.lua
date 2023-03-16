local function on_attach(bufnr)
  local api = require("nvim-tree.api")


  -- =============================================
  -- ========== Custom Functions
  -- =============================================
  ---Judge whether a file is a binary file.
  ---@return number status_code
  local function __is_binary()
    -- Need `file` and `test` binary file.
    if vim.fn.executable("file") ~= 1 then return -1 end

    local node = require("nvim-tree.lib").get_node_at_cursor()
    if not node then Fau_vim.notify("An Unexcepted Result in nvim-tree hyper_open().", vim.log.levels.ERROR) return -1 end

    -- Read file and Get file information.
    local abs_path = node.absolute_path
    local file_info = vim.loop.fs_stat(abs_path)
    if not file_info then Fau_vim.notify("An Unexcepted Result in nvim-tree hyper_open().", vim.log.levels.ERROR) return -1 end

    -- If it is a folder path, the folder should not be treated as a binary file.
    local is_folder = file_info.type == "directory"
    if is_folder then return 0 end

    -- If it is an empty file, not treat it as a binary file.
    local is_empty = file_info.size == 0
    if is_empty then return 0 end

    -- Run `file` command.
    local command = [[!file --mime-encoding -b ']] .. abs_path .. "'"  -- if a binary file, will return `binary`.
    local result = vim.fn.execute(command)

    if string.find(result, "binary") ~= nil then return 1
    else return 0
    end
  end

  --- A smart open function
  --- For the binary file, will use the `system open`; else will use `edit`
  local function smart_open()
    if __is_binary() == 1 then api.node.run.system()
    else api.node.open.edit()
    end
  end

  --- A smart preview function
  --- For the binary file, will use the `system open`; else will use `preview`
  local function smart_preview()
    if __is_binary() == 1 then api.node.run.system()
    else api.node.open.preview()
    end
  end

  local function opts(desc)
    return { desc="nvim-tree: " .. desc, buffer=bufnr, noremap=true, silent=true, nowait=true }
  end


  -- =============================================
  -- ========== Keymap Bindings
  -- =============================================
  vim.keymap.set("n", "<CR>",           smart_open,                         opts("Smart Open"))
  vim.keymap.set("n", "o",              smart_open,                         opts("Smart Open"))
  vim.keymap.set("n", "<2-LeftMouse>",  smart_open,                         opts("Smart Open"))
  vim.keymap.set("n", "O",              api.node.open.no_window_picker,     opts("Open: No Window Picker"))
  vim.keymap.set("n", "<Tab>",          smart_preview,                      opts("Smart Preview"))

  vim.keymap.set("n", "<C-t>",          api.node.open.tab,                  opts("Open: New Tab"))
  vim.keymap.set("n", "<C-v>",          api.node.open.vertical,             opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-x>",          api.node.open.horizontal,           opts("Open: Horizontal Split"))

  vim.keymap.set("n", "<C-]>",          api.tree.change_root_to_node,       opts("CD"))
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node,       opts("CD"))
  vim.keymap.set("n", "-",              api.tree.change_root_to_parent,     opts("Up"))

  vim.keymap.set("n", "r",              api.fs.rename_basename,             opts("Rename: Basename"))
  vim.keymap.set("n", "lr",             api.fs.rename,                      opts("Rename"))
  vim.keymap.set("n", "<C-r>",          api.fs.rename_sub,                  opts("Rename: Omit Filename"))

  vim.keymap.set("n", "f",              api.live_filter.start,              opts("Filter"))
  vim.keymap.set("n", "F",              api.live_filter.clear,              opts("Clean Filter"))
  vim.keymap.set("n", "s",              api.tree.search_node,               opts("Search"))

  vim.keymap.set("n", "m",              api.marks.toggle,                   opts("Toggle Bookmark"))
  vim.keymap.set("n", "bmv",            api.marks.bulk.move,                opts("Move Bookmarked"))

  vim.keymap.set("n", "a",              api.fs.create,                      opts("Create"))
  vim.keymap.set("n", "x",              api.fs.cut,                         opts("Cut"))
  vim.keymap.set("n", "c",              api.fs.copy.node,                   opts("Copy"))
  vim.keymap.set("n", "d",              api.fs.trash,                       opts("Trash"))
  vim.keymap.set("n", "D",              api.fs.remove,                      opts("Delete"))
  vim.keymap.set("n", "p",              api.fs.paste,                       opts("Paste"))

  vim.keymap.set("n", "y",              api.fs.copy.filename,               opts("Copy Name"))
  vim.keymap.set("n", "Y",              api.fs.copy.relative_path,          opts("Copy Relative Path"))
  vim.keymap.set("n", "gy",             api.fs.copy.absolute_path,          opts("Copy Absolute Path"))

  vim.keymap.set("n", "B",              api.tree.toggle_no_buffer_filter,   opts("Toggle No Buffer"))
  vim.keymap.set("n", "C",              api.tree.toggle_git_clean_filter,   opts("Toggle Git Clean"))

  vim.keymap.set("n", "E",              api.tree.expand_all,                opts("Expand All"))
  vim.keymap.set("n", "W",              api.tree.collapse_all,              opts("Collapse"))

  vim.keymap.set("n", "I",              api.tree.toggle_gitignore_filter,   opts("Toggle Git Ignore"))
  vim.keymap.set("n", "U",              api.tree.toggle_custom_filter,      opts("Toggle Hidden"))

  vim.keymap.set("n", "P",              api.node.navigate.parent,           opts("Parent Directory"))
  vim.keymap.set("n", "<BS>",           api.node.navigate.parent_close,     opts("Close Directory"))
  vim.keymap.set("n", "H",              api.node.navigate.sibling.first,    opts("First Sibling"))
  vim.keymap.set("n", "L",              api.node.navigate.sibling.last,     opts("Last Sibling"))

  vim.keymap.set("n", "gp",             api.node.navigate.git.prev,         opts("Prev Git"))
  vim.keymap.set("n", "gn",             api.node.navigate.git.next,         opts("Next Git"))

  vim.keymap.set("n", "lp",             api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
  vim.keymap.set("n", "ln",             api.node.navigate.diagnostics.next, opts("Next Diagnostic"))

  vim.keymap.set("n", "i",              api.node.show_info_popup,           opts("Info"))
  vim.keymap.set("n", "S",              api.node.run.system,                opts("Run System"))
  vim.keymap.set("n", ".",              api.node.run.cmd,                   opts("Run Command"))

  vim.keymap.set("n", "R",              api.tree.reload,                    opts("Refresh"))
  vim.keymap.set("n", "g?",             api.tree.toggle_help,               opts("Help"))
  vim.keymap.set("n", "?",              api.tree.toggle_help,               opts("Help"))

  vim.keymap.set("n", "q",              api.tree.close,                     opts("Close"))
  vim.keymap.set("n", "<ESC>",          api.tree.close,                     opts("Close"))


  -- vim.keymap.set("n", "<C-e>",          api.node.open.replace_tree_buffer,  opts("Open: In Place"))
  -- vim.keymap.set("n", "H",              api.tree.toggle_hidden_filter,      opts("Toggle Dotfiles"))
  -- vim.keymap.set("n", ">",              api.node.navigate.sibling.next,     opts("Next Sibling"))
  -- vim.keymap.set("n", "<",              api.node.navigate.sibling.prev,     opts("Previous Sibling"))
end


return on_attach
