local api = require("nvim-tree.api")


-- =============================================
-- ========== Functions
-- =============================================
-- -----------------------------------
-- -------- Private Functions
-- -----------------------------------
---Get the node type.
---@param node Node
---@return "directory"|"file"|"binary"|"error"
local function __get_node_type(node)
  -- CASE 1: Directory
  if node.type == "directory" or node.name == ".." then return "directory" end
  if node.fs_stat == nil then return "error" end
  ---@diagnostic disable-next-line: undefined-field
  if node.fs_stat.type == "directory" then return "directory" end  -- If the node.type is `link`, use fs_stat.type.

  -- CASE 2: File or Binary
  -- If it is an empty file, the `file` command will return `binary`, but it should be regarded as a file.
  ---@diagnostic disable-next-line: undefined-field
  if node.fs_stat.size == 0 then return "file" end

  if vim.fn.executable("file") ~= 1 then return "file" end
  local result = vim.fn.system({ "file", "--mime-encoding", "-b", node.absolute_path }):sub(1, -2)  -- trim line break char
  return result == "binary" and "binary" or "file"
end


---Open binary file will use system open; Decline to open huge folder.
---@param node Node nvim-tree Node
---@param default_method function if not a binary and folder file, will use `default_method` to open it.
local function __hyper_open(node, default_method)
  -- Get basic information.
  node = node or api.tree.get_node_under_cursor()
  if not node then Fau_vim.notify("Get node info error!", vim.log.levels.ERROR) return end  -- error notified in get_cursor_node().

  local file_type = __get_node_type(node)

  if file_type == "binary" then
    api.node.run.system(node)
    Fau_vim.notify("A binary file, use system open to edit it. (Use `o` to force edit it in neovim.)", vim.log.levels.INFO, { render="minimal" })
  elseif file_type == "directory" then
    local file_number = node.nodes and #node.nodes or -1  -- NOTE: if the name of node is `..`, the `nodes` field will be nil.
    if file_number >= 100 then Fau_vim.notify("A large folder. (Use `o` to force expand it.)", vim.log.levels.WARN, { render="minimal" })
    else default_method(node) end
  elseif file_type == "file" then default_method(node)
  elseif file_type == "error" then Fau_vim.notify("Get node type error!", vim.log.levels.ERROR)
  else Fau_vim.notify("Unknown node type!", vim.log.levels.ERROR)
  end
end


-- -----------------------------------
-- -------- Public Functions
-- -----------------------------------
local function smart_open(node) __hyper_open(node, api.node.open.edit) end

local function smart_preview(node) __hyper_open(node, api.node.open.preview) end

local function reveal_in_system(node)
  node = node or api.tree.get_node_under_cursor()
  if not node then Fau_vim.notify("Get node info error!", vim.log.levels.ERROR) return end  -- error notified in get_cursor_node().

  print(("Reveal %s in system."):format(node.absolute_path))
  return Fau_vim.functions.utils.reveal_in_system(node.absolute_path)
end



-- =============================================
-- ========== Keymaps
-- =============================================
local function on_attach(bufnr)
  local function opts(desc) return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

  vim.keymap.set("n", "<CR>",           smart_open,                                 opts("Open: Smart Open"))
  vim.keymap.set("n", "o",              api.node.open.edit,                         opts("Open: Edit in Neovim"))
  vim.keymap.set("n", "<2-LeftMouse>",  smart_open,                                 opts("Open: Smart Open"))
  vim.keymap.set("n", "O",              api.node.open.no_window_picker,             opts("Open: No Window Picker"))
  vim.keymap.set("n", "<Tab>",          smart_preview,                              opts("Open: Smart Preview"))
  vim.keymap.set("n", "<C-f>",          reveal_in_system,                           vim.tbl_extend("error", opts("Open: Reveal in System"), { expr=true }))

  vim.keymap.set("n", "<C-t>",          api.node.open.tab,                          opts("Open: New Tab"))
  vim.keymap.set("n", "<C-v>",          api.node.open.vertical,                     opts("Open: Vertical Split"))
  vim.keymap.set("n", "<C-x>",          api.node.open.horizontal,                   opts("Open: Horizontal Split"))

  vim.keymap.set("n", "<C-]>",          api.tree.change_root_to_node,               opts("CD: Change Root to Node"))
  vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node,               opts("CD: Change Root to Node"))

  vim.keymap.set("n", "r",              api.fs.rename_basename,                     opts("Rename: Basename"))
  vim.keymap.set("n", "lr",             api.fs.rename,                              opts("Rename: Filename"))
  vim.keymap.set("n", "<C-r>",          api.fs.rename_full,                         opts("Rename: Full Path"))

  vim.keymap.set("n", "ge",             api.fs.copy.basename,                       opts("Copy: Basename"))
  vim.keymap.set("n", "y",              api.fs.copy.filename,                       opts("Copy: Filename"))
  vim.keymap.set("n", "Y",              api.fs.copy.relative_path,                  opts("Copy: Relative Path"))
  vim.keymap.set("n", "gy",             api.fs.copy.absolute_path,                  opts("Copy: Absolute Path"))

  vim.keymap.set("n", "f",              api.live_filter.start,                      opts("Filter: Start"))
  vim.keymap.set("n", "F",              api.live_filter.clear,                      opts("Filter: Clear"))
  vim.keymap.set("n", "s",              api.tree.search_node,                       opts("Search File"))

  vim.keymap.set("n", "m",              api.marks.toggle,                           opts("Bookmark: Toggle"))
  vim.keymap.set("n", "bmv",            api.marks.bulk.move,                        opts("Bookmark: Move"))
  vim.keymap.set("n", "bt",             api.marks.bulk.trash,                       opts("Bookmark: Trash"))
  vim.keymap.set("n", "bd",             api.marks.bulk.delete,                      opts("Bookmark: Delete"))

  vim.keymap.set("n", "a",              api.fs.create,                              opts("File: Create"))
  vim.keymap.set("n", "x",              api.fs.cut,                                 opts("File: Cut"))
  vim.keymap.set("n", "c",              api.fs.copy.node,                           opts("File: Copy"))
  vim.keymap.set("n", "d",              api.fs.trash,                               opts("File: Trash"))
  vim.keymap.set("n", "D",              api.fs.remove,                              opts("File: Delete"))
  vim.keymap.set("n", "p",              api.fs.paste,                               opts("File: Paste"))

  vim.keymap.set("n", "B",              api.tree.toggle_no_buffer_filter,           opts("View: Toggle Buffer"))
  vim.keymap.set("n", "C",              api.tree.toggle_git_clean_filter,           opts("View: Toggle Git"))
  vim.keymap.set("n", "I",              api.tree.toggle_gitignore_filter,           opts("View: Toggle Ignore"))
  vim.keymap.set("n", "U",              api.tree.toggle_custom_filter,              opts("View: Toggle Hidden"))

  vim.keymap.set("n", "E",              api.tree.expand_all,                        opts("Node: Expand All"))
  vim.keymap.set("n", "W",              api.tree.collapse_all,                      opts("Node: Collapse All"))

  vim.keymap.set("n", "P",              api.node.navigate.parent,                   opts("Node: Parent Directory"))
  vim.keymap.set("n", "<BS>",           api.node.navigate.parent_close,             opts("Node: Close Directory"))
  vim.keymap.set("n", "H",              api.node.navigate.sibling.first,            opts("Node: First Sibling"))
  vim.keymap.set("n", "L",              api.node.navigate.sibling.last,             opts("Node: Last Sibling"))

  vim.keymap.set("n", "gp",             api.node.navigate.git.prev_skip_gitignored, opts("Git: Prev"))
  vim.keymap.set("n", "gn",             api.node.navigate.git.next_skip_gitignored, opts("Git: Next"))

  vim.keymap.set("n", "lp",             api.node.navigate.diagnostics.prev,         opts("Diagnostic: Prev"))
  vim.keymap.set("n", "ln",             api.node.navigate.diagnostics.next,         opts("Diagnostic: Next"))

  vim.keymap.set("n", "i",              api.node.show_info_popup,                   opts("Node: Info"))
  vim.keymap.set("n", "S",              api.node.run.system,                        opts("Node: Run System"))
  vim.keymap.set("n", ".",              api.node.run.cmd,                           opts("Node: Run Command"))

  vim.keymap.set("n", "R",              api.tree.reload,                            opts("Tree: Refresh"))
  vim.keymap.set("n", "g?",             api.tree.toggle_help,                       opts("Tree: Help"))
  vim.keymap.set("n", "?",              api.tree.toggle_help,                       opts("Tree: Help"))
  vim.keymap.set("n", "q",              api.tree.close,                             opts("Tree: Close"))
  vim.keymap.set("n", "<ESC>",          api.tree.close,                             opts("Tree: Close"))


  -- vim.keymap.set("n", "<C-e>",          api.node.open.replace_tree_buffer,  opts("Open: In Place"))
  -- vim.keymap.set("n", "L",              api.node.open.toggle_group_empty,    opts("Toggle Group Empty"))
  -- vim.keymap.set("n", "M",              api.tree.toggle_no_bookmark_filter,  opts("Toggle Filter: No Bookmark"))
  -- vim.keymap.set("n", "H",              api.tree.toggle_hidden_filter,      opts("Toggle Filter: Dotfiles"))
  -- vim.keymap.set("n", ">",              api.node.navigate.sibling.next,     opts("Next Sibling"))
  -- vim.keymap.set("n", "<",              api.node.navigate.sibling.prev,     opts("Previous Sibling"))
  -- vim.keymap.set("n", "-",              api.tree.change_root_to_parent,     opts("CD: Change Root to Parent"))
end


return on_attach
