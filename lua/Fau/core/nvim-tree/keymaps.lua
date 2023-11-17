-- TODO: Expand all folders to filter huge directories.
local function on_attach(bufnr)
  local api = require("nvim-tree.api")


  -- =============================================
  -- ========== Custom Functions
  -- =============================================
  ---@return table|unknown|nil
  local function __get_cursor_node()
    local node = require("nvim-tree.lib").get_node_at_cursor()
    if not node then Fau_vim.notify("An Unexcepted Result in nvim-tree get_cursor_node().", vim.log.levels.ERROR) end
    return node
  end


  ---Get the file type.
  ---return values: -1, 0, 1, 2 -> error, normal file, binary file, folder
  ---@param abs_path string
  ---@return number status_code
  local function __get_file_type(abs_path)
    -- Need `file` binary file.
    if vim.fn.executable("file") ~= 1 then return -1 end

    -- Read file and Get file information.
    local file_info = vim.loop.fs_stat(abs_path)
    if not file_info then Fau_vim.notify("Not found file in given abs_path.", vim.log.levels.ERROR) return -1 end

    -- If it is a folder path, the folder should not be treated as a binary file.
    local is_folder = file_info.type == "directory"
    if is_folder then return 2 end

    -- If it is an empty file, not treat it as a binary file.
    local is_empty = file_info.size == 0
    if is_empty then return 0 end

    -- Run `file` command.
    -- if a binary file, will return `binary`.
    local result = vim.fn.system({ "file", "--mime-encoding", "-b", abs_path }):sub(1, -2)  -- trim line break char

    if result == "binary" then return 1
    else return 0
    end
  end


  ---Open binary file will use system open; Disable to open huge folder.
  ---@param default_method function if not a binary and folder file, will use default_method to open it.
  local function __hyper_open(default_method)
    -- Get basic information.
    local node = __get_cursor_node()
    if not node then return end  -- error notified in get_cursor_node().
    local abs_path = node.absolute_path

    -- NOTE: for go back to the previous directory
    if abs_path == nil then default_method(node) return end

    local file_type = __get_file_type(abs_path)

    if file_type == 1 then  -- binary file
      api.node.run.system(node)
      Fau_vim.notify("A binary file, use system open to edit it. (Use `o` to force edit it in neovim.)", vim.log.levels.INFO, { render="minimal" })
    elseif file_type == 2 then  -- folder
      local command = string.format([[ls -1 "%s" | wc -l]], abs_path)
      local file_number = tonumber(vim.fn.system(command))

      if file_number >= 1000 then Fau_vim.notify("A large folder. (Use `o` to force expand it.)", vim.log.levels.WARN, { render="minimal" })
      else default_method(node) end
    else default_method(node)
    end
  end


  local function smart_open() __hyper_open(api.node.open.edit) end
  local function smart_preview() __hyper_open(api.node.open.preview) end
  local function reveal_in_system()
    local node = __get_cursor_node()
    if not node then return end  -- error notified in get_cursor_node().
    local abs_path = node.absolute_path
    print(string.format("Reveal %s in system.", abs_path))
    return Fau_vim.functions.utils.reveal_in_system(abs_path)
  end


  local function opts(desc) return { desc="nvim-tree: " .. desc, buffer=bufnr, noremap=true, nowait=true } end


  -- =============================================
  -- ========== Keymap Bindings
  -- =============================================
  vim.keymap.set("n", "<CR>",           smart_open,                         opts("Smart Open"))
  vim.keymap.set("n", "o",              api.node.open.edit,                 opts("Open"))
  vim.keymap.set("n", "<2-LeftMouse>",  smart_open,                         opts("Smart Open"))
  vim.keymap.set("n", "O",              api.node.open.no_window_picker,     opts("Open: No Window Picker"))
  vim.keymap.set("n", "<Tab>",          smart_preview,                      opts("Smart Preview"))
  vim.keymap.set("n", "<C-f>",          reveal_in_system,                   vim.tbl_extend("error", opts("Reveal in System"), { expr=true }))

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
  vim.keymap.set("n", "bt",             api.marks.bulk.trash,                opts("Move Bookmarked"))
  vim.keymap.set("n", "bd",             api.marks.bulk.delete,                opts("Move Bookmarked"))

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
