local keymap = vim.keymap.set
local function opts(desc) return { silent = false, desc = desc } end


-- ==================== Yank and Paste ====================
keymap("x", "y", function() fvim.utils.smart_visual_mode(); vim.api.nvim_command("normal! y") end, opts("Yank"))
keymap("x", "<LEADER>d", function() fvim.utils.smart_visual_mode(); vim.api.nvim_command("normal! d") end, opts("Cut"))

-- ==================== Buffer ====================
keymap("n", "<A-q>", fvim.utils.buf_remove,       opts("Buffer: Close Current Buffer"))
keymap("n", "<C-f>", fvim.utils.reveal_in_system, opts("Buffer: Reveal in System"))

-- ==================== Indent ====================
keymap("n", "<LEADER><LEADER>i", fvim.indent.toggle_indent_width, opts("Indent: Toggle Width"))

-- ==================== LSP ====================
keymap("n", "<LEADER>lf", fvim.format.smart_format, opts("LSP: Format Code (Smart)"))
keymap("x", "<LEADER>lf", function()
  fvim.format.smart_format()
  fvim.utils.feedkeys("x", "<ESC>")  -- Exit visual mode after formatting.
end, opts("LSP: Format Code (Smart)"))

keymap("n", "<LEADER>lR", function() fvim.lsp.restart_lsp() end, opts("LSP: Restart LSP for Current Buffer"))
