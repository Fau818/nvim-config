local builtin = require("telescope.builtin")

local keymap  = vim.keymap.set
local function opts(desc) return { silent = true, desc = desc } end

keymap("n", "gd", builtin.lsp_definitions,      opts("Goto Definition"))
keymap("n", "gD", builtin.lsp_type_definitions, opts("Goto Declaration"))
keymap("n", "gt", builtin.lsp_type_definitions, opts("Goto Type Definition"))
keymap("n", "gI", builtin.lsp_implementations,  opts("Goto Implementation"))
keymap("n", "gr", builtin.lsp_references,      opts("Show References"))

keymap("n", "gi", builtin.lsp_incoming_calls, opts("Show Incoming Calls"))
keymap("n", "go", builtin.lsp_outgoing_calls, opts("Show Outgoing Calls"))

keymap("n", "<LEADER>ld", function() builtin.diagnostic({ bufnr = 0 }) end, opts("buffer Diagnostics"))
keymap("n", "<LEADER>lD", builtin.diagnostics,      opts("Workspace Diagnostics"))
