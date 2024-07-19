local builtin = require("telescope.builtin")
local pickers = require("Fau.configs.editor.telescope.custom_pickers")

local keymap = vim.keymap.set
local function opts(desc) return { silent = true, desc = desc } end

-- ==================== General ====================
keymap("n", "<LEADER>fa", builtin.autocommands,                                           opts("Find Autocommands"))
keymap("n", "<LEADER>fb", builtin.buffers,                                                opts("Find Buffers"))
keymap("n", "<LEADER>fB", builtin.current_buffer_fuzzy_find,                              opts("Find in Current Buffer"))
keymap("n", "<LEADER>fc", builtin.commands,                                               opts("Find Commands"))
keymap("n", "<LEADER>fC", builtin.command_history,                                        opts("Find Command History"))
keymap("n", "<LEADER>fe", pickers.conda,                                                  opts("Find Conda Environments"))
keymap("n", "<LEADER>ff", builtin.find_files,                                             opts("Find Files"))
keymap("n", "<LEADER>fh", builtin.help_tags,                                              opts("Find in Help"))
keymap("n", "<LEADER>fH", builtin.highlights,                                             opts("Find Highlights"))
keymap("n", "<LEADER>fk", builtin.keymaps,                                                opts("Find Keymaps"))
keymap("n", "<LEADER>fl", pickers.luasnip,                                                opts("Find in Luasnip"))
keymap("n", "<LEADER>fn", pickers.notify,                                                 opts("Find in Notify"))
keymap("n", "<LEADER>fp", pickers.projects,                                               opts("Find Projects"))
keymap("n", "<LEADER>ft", pickers.todo_comments,                                          opts("Find Todo Comments"))
keymap("n", "<LEADER>fr", builtin.oldfiles,                                               opts("Find Recent Files"))
keymap("n", "<LEADER>fs", builtin.live_grep,                                              opts("Find String"))
keymap("n", "<LEADER>fS", function() builtin.live_grep({ grep_open_files = true }) end,   opts("Find String in Opened Buffers"))
keymap("n", "<LEADER>fw", builtin.grep_string,                                            opts("Find Under Cursor Word"))
keymap("n", "<LEADER>fW", function() builtin.grep_string({ grep_open_files = true }) end, opts("Find Under Cursor Word in Opened Buffers"))


-- ==================== LSP ====================
keymap("n", "gd", builtin.lsp_definitions,      opts("Goto Definition"))
keymap("n", "gD", builtin.lsp_type_definitions, opts("Goto Declaration"))
keymap("n", "gt", builtin.lsp_type_definitions, opts("Goto Type Definition"))
keymap("n", "gI", builtin.lsp_implementations,  opts("Goto Implementation"))
keymap("n", "gr", builtin.lsp_references,       opts("Show References"))

keymap("n", "gi", builtin.lsp_incoming_calls, opts("Show Incoming Calls"))
keymap("n", "go", builtin.lsp_outgoing_calls, opts("Show Outgoing Calls"))

keymap("n", "<LEADER>ld", function() builtin.diagnostics({ bufnr = 0 }) end, opts("Buffer Diagnostics"))
keymap("n", "<LEADER>lD", builtin.diagnostics,                               opts("Workspace Diagnostics"))

keymap("n", "<LEADER>ls", builtin.lsp_dynamic_workspace_symbols, opts("Dynamic Workspace Symbols"))


-- ==================== Extra ====================
keymap("n", "<LEADER><LEADER>ff", pickers.find_files_by_filetype, opts( "Find Files by Filetype"))
