local gitsigns = require("gitsigns")
local keymap  = vim.keymap.set

return function(bufnr)
  local function opts(desc) return { desc = "Gitsigns: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end

  -- ==================== Toggle ====================
  keymap("n", "<LEADER>gtb", gitsigns.toggle_current_line_blame, opts("Toggle Line Blame"))
  keymap("n", "<LEADER>gts", gitsigns.toggle_signs,              opts("Toggle Column Signs"))
  keymap("n", "<LEADER>gtn", gitsigns.toggle_numhl,              opts("Toggle Number Highlight"))
  keymap("n", "<LEADER>gtl", gitsigns.toggle_linehl,             opts("Toggle Line Highlight"))
  keymap("n", "<LEADER>gtw", gitsigns.toggle_word_diff,          opts("Toggle Word Difference"))
  keymap("n", "<LEADER>gtd", gitsigns.toggle_deleted,            opts("Toggle Deleted"))
  keymap(
  "n", "<LEADER>gtc",
  function() gitsigns.toggle_numhl() gitsigns.toggle_linehl() gitsigns.toggle_word_diff() end,
  opts("Toggle Git Check Mode")
  )

  -- ==================== Preview ====================
  keymap("n", "<LEADER>gc", gitsigns.preview_hunk_inline, opts("Show Current Hunk Changes Inline"))
  keymap("n", "<LEADER>gC", gitsigns.preview_hunk,        opts("Show Current Hunk Changes Float"))

  -- ==================== Goto Prev/Next Hunk ====================
  keymap("n", "<LEADER>gn", function() gitsigns.nav_hunk("next") end, opts("Next Hunk"))
  keymap("n", "<LEADER>gN", function() gitsigns.nav_hunk("prev") end, opts("Prev Hunk"))

  -- ==================== Select Hunk ====================
  keymap("n", "<LEADER>gv", gitsigns.select_hunk, opts("Select Hunk"))

  -- ==================== Stage ====================
  keymap("n", "<LEADER>gs", gitsigns.stage_hunk, opts("Stage Hunk"))
  keymap("n", "<LEADER>gS", gitsigns.stage_buffer, opts("Stage Buffer"))
  keymap("n", "<LEADER>gr", gitsigns.reset_hunk, opts("Reset Hunk"))
  keymap("n", "<LEADER>gR", gitsigns.reset_buffer, opts("Reset Buffer"))
  keymap("x", "<LEADER>gs", function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, opts("Stage Hunk"))
  keymap("x", "<LEADER>gr", function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, opts("Stage Hunk"))

  -- ==================== Undo ====================
  keymap("n", "<LEADER>gu", gitsigns.undo_stage_hunk, opts("Undo Stage"))

  -- ==================== Diffthis ====================
  keymap("n", "<LEADER>gf", function() gitsigns.diffthis("HEAD") end, opts("Show Diff for Current Buffer"))

  -- ==================== Quickfix ====================
  keymap("n", "<LEADER>gq", gitsigns.setqflist, opts("Show in Quickfix"))
end
