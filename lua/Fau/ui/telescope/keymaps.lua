local builtin = require("telescope.builtin")
local pickers = require("Fau.ui.telescope.custom_pickers")

local keymap = vim.keymap.set
local function opts(desc) return { desc = "Telescope: " .. desc } end

-- ==================== General ====================
keymap("n", "<LEADER>fa", builtin.autocommands,                                           opts("Autocommands"))
keymap("n", "<LEADER>fb", builtin.buffers,                                                opts("Buffers"))
keymap("n", "<LEADER>fB", builtin.current_buffer_fuzzy_find,                              opts("Find in Current Buffer"))
keymap("n", "<LEADER>fc", builtin.commands,                                               opts("Commands"))
keymap("n", "<LEADER>fC", builtin.command_history,                                        opts("Command History"))
keymap("n", "<LEADER>fe", pickers.conda,                                                  opts("Conda Environments"))
keymap("n", "<LEADER>ff", builtin.find_files,                                             opts("Files"))
keymap("n", "<LEADER>fh", builtin.help_tags,                                              opts("Help"))
keymap("n", "<LEADER>fH", builtin.highlights,                                             opts("Highlights"))
keymap("n", "<LEADER>fk", builtin.keymaps,                                                opts("Keymaps"))
keymap("n", "<LEADER>fn", "<CMD>NoiceSnacks<CR>",                                         opts("NoiceSnacks"))
keymap("n", "<LEADER>fr", builtin.oldfiles,                                               opts("Recent Files"))
keymap("n", "<LEADER>fs", builtin.live_grep,                                              opts("String"))
keymap("n", "<LEADER>fS", function() builtin.live_grep({ grep_open_files = true }) end,   opts("String in Opened Buffers"))
keymap("n", "<LEADER>fw", builtin.grep_string,                                            opts("Under Cursor Word"))
keymap("n", "<LEADER>fW", function() builtin.grep_string({ grep_open_files = true }) end, opts("Under Cursor Word in Opened Buffers"))


-- ==================== LSP ====================
keymap("n", "gd", builtin.lsp_definitions,      opts("Show Definition"))
keymap("n", "gD", builtin.lsp_type_definitions, opts("Show Declaration"))
keymap("n", "gt", builtin.lsp_type_definitions, opts("Show Type Definition"))
keymap("n", "gI", builtin.lsp_implementations,  opts("Show Implementation"))
keymap("n", "gr", builtin.lsp_references,       opts("Show References"))

keymap("n", "gi", builtin.lsp_incoming_calls, opts("Show Incoming Calls"))
keymap("n", "go", builtin.lsp_outgoing_calls, opts("Show Outgoing Calls"))

keymap("n", "<LEADER>ld", function() builtin.diagnostics({ bufnr = 0 }) end, opts("Show Buffer Diagnostics"))
keymap("n", "<LEADER>lD", builtin.diagnostics,                               opts("Show Workspace Diagnostics"))

keymap("n", "<LEADER>ls", builtin.lsp_dynamic_workspace_symbols, opts("Show Dynamic Workspace Symbols"))


-- ==================== Extra ====================
-- TODO: Not finished.
keymap("n", "<LEADER><LEADER>ff", pickers.find_files_by_filetype, opts("Files Filtered by Filetype"))
