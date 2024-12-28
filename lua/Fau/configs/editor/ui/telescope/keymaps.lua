local builtin = require("telescope.builtin")
local pickers = require("Fau.configs.editor.ui.telescope.custom_pickers")

local keymap = vim.keymap.set
local function opts(desc) return { silent = true, desc = desc } end

-- ==================== General ====================
keymap("n", "<LEADER>fa", builtin.autocommands,                                           opts("Telescope: Autocommands"))
keymap("n", "<LEADER>fb", builtin.buffers,                                                opts("Telescope: Buffers"))
keymap("n", "<LEADER>fB", builtin.current_buffer_fuzzy_find,                              opts("Telescope: Find in Current Buffer"))
keymap("n", "<LEADER>fc", builtin.commands,                                               opts("Telescope: Commands"))
keymap("n", "<LEADER>fC", builtin.command_history,                                        opts("Telescope: Command History"))
keymap("n", "<LEADER>fe", pickers.conda,                                                  opts("Telescope: Conda Environments"))
keymap("n", "<LEADER>ff", builtin.find_files,                                             opts("Telescope: Files"))
keymap("n", "<LEADER>fh", builtin.help_tags,                                              opts("Telescope: Help"))
keymap("n", "<LEADER>fH", builtin.highlights,                                             opts("Telescope: Highlights"))
keymap("n", "<LEADER>fk", builtin.keymaps,                                                opts("Telescope: Keymaps"))
keymap("n", "<LEADER>fl", pickers.luasnip,                                                opts("Telescope: Luasnip"))
keymap("n", "<LEADER>fn", pickers.notify,                                                 opts("Telescope: Notify"))
keymap("n", "<LEADER>fp", pickers.projects,                                               opts("Telescope: Projects"))
keymap("n", "<LEADER>ft", pickers.todo_comments,                                          opts("Telescope: Todo Comments"))
keymap("n", "<LEADER>fr", builtin.oldfiles,                                               opts("Telescope: Recent Files"))
keymap("n", "<LEADER>fs", builtin.live_grep,                                              opts("Telescope: String"))
keymap("n", "<LEADER>fS", function() builtin.live_grep({ grep_open_files = true }) end,   opts("Telescope: String in Opened Buffers"))
keymap("n", "<LEADER>fw", builtin.grep_string,                                            opts("Telescope: Under Cursor Word"))
keymap("n", "<LEADER>fW", function() builtin.grep_string({ grep_open_files = true }) end, opts("Telescope: Under Cursor Word in Opened Buffers"))


-- ==================== LSP ====================
keymap("n", "gd", builtin.lsp_definitions,      opts("Telescope LSP: Definition"))
keymap("n", "gD", builtin.lsp_type_definitions, opts("Telescope LSP: Declaration"))
keymap("n", "gt", builtin.lsp_type_definitions, opts("Telescope LSP: Type Definition"))
keymap("n", "gI", builtin.lsp_implementations,  opts("Telescope LSP: Implementation"))
keymap("n", "gr", builtin.lsp_references,       opts("Telescope LSP: References"))

keymap("n", "gi", builtin.lsp_incoming_calls, opts("Telescope LSP: Show Incoming Calls"))
keymap("n", "go", builtin.lsp_outgoing_calls, opts("Telescope LSP: Show Outgoing Calls"))

keymap("n", "<LEADER>ld", function() builtin.diagnostics({ bufnr = 0 }) end, opts("Telescope LSP: Buffer Diagnostics"))
keymap("n", "<LEADER>lD", builtin.diagnostics,                               opts("Telescope LSP: Workspace Diagnostics"))

keymap("n", "<LEADER>ls", builtin.lsp_dynamic_workspace_symbols, opts("Telescope LSP: Dynamic Workspace Symbols"))


-- ==================== Extra ====================
-- TODO: Not finished.
keymap("n", "<LEADER><LEADER>ff", pickers.find_files_by_filetype, opts("Telescope: Files Filtered by Filetype"))
