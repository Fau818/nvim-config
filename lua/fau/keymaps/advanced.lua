local keymap = vim.keymap.set
local function opts(desc) return { silent = false, desc = desc } end


-- ═══════════════════════════ Move ═══════════════════════════

---In Visual mode, Pressing `H` again at the `^` position escalates to `0`, vice versa.
keymap("x", "H", function()
  local before = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! ^")
  if vim.deep_equal(vim.api.nvim_win_get_cursor(0), before) then vim.cmd("normal! 0") end
end, opts("Goto: Line Begin"))

---In blockwise-visual mode, pressing `L` again at the `g_` position escalates to `$`, vice versa.
keymap("x", "L", function()
  local before = vim.api.nvim_win_get_cursor(0)
  vim.cmd("normal! g_")
  if vim.deep_equal(vim.api.nvim_win_get_cursor(0), before) then vim.cmd("normal! $") end
end, opts("Goto: Line End"))


-- ═══════════════════════════ Edit ═══════════════════════════

keymap("x", "y", function() fvim.utils.smart_visual_mode(); vim.api.nvim_command("normal! y") end, opts("Edit: Yank"))
keymap("x", "<LEADER>d", function() fvim.utils.smart_visual_mode(); vim.api.nvim_command("normal! d") end, opts("Edit: Cut"))

keymap("x", "c", function() fvim.utils.smart_visual_mode(); fvim.utils.feedkeys([["_c]]) end, opts("Edit: Change"))
keymap("x", "C", function() fvim.utils.smart_visual_mode(); fvim.utils.feedkeys([["_C]]) end, opts("Edit: Change"))


-- ═══════════════════════ Tag Comments ═══════════════════════
keymap("n", "<A-m>", function() fvim.format.tag.merge_line() end, opts("Edit: Merge Line"))
keymap("i", "<CR>",  function() fvim.format.tag.newline() end,    opts("Edit: New Line"))


-- ══════════════════════════ Buffer ══════════════════════════

keymap("n", "<A-q>", fvim.utils.buf_remove,       opts("Buffer: Close Current Buffer"))
keymap("n", "<C-f>", fvim.utils.reveal_in_system, opts("Buffer: Reveal in System"))


-- ══════════════════════════ Indent ══════════════════════════

keymap("n", "<LEADER><LEADER>i", fvim.indent.toggle_indent_width, opts("Indent: Toggle Width"))


-- ═══════════════════════════ LSP ════════════════════════════

keymap("n", "<LEADER>lf", fvim.format.smart_format, opts("LSP: Format Code (Smart)"))
keymap("x", "<LEADER>lf", function()
  fvim.format.smart_format()
  fvim.utils.feedkeys("<ESC>")  -- Exit visual mode after formatting.
end, opts("LSP: Format Code (Smart)"))

keymap("n", "<LEADER>lR", function() fvim.lsp.restart_lsp() end, opts("LSP: Restart LSP for Current Buffer"))
