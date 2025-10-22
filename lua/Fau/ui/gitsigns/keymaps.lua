local actions = require("gitsigns.actions")
local keymap  = vim.keymap.set

return function(bufnr)
  local function opts(desc) return { desc = "Gitsigns: " .. desc, buffer = bufnr } end

  -- ==================== Toggle ====================
  keymap("n", "<LEADER>gtb", actions.toggle_current_line_blame, opts("Gitsigns: Toggle Line Blame"))
  keymap("n", "<LEADER>gts", actions.toggle_signs,              opts("Gitsigns: Toggle Column Signs"))
  keymap("n", "<LEADER>gtn", actions.toggle_numhl,              opts("Gitsigns: Toggle Number Highlight"))
  keymap("n", "<LEADER>gtl", actions.toggle_linehl,             opts("Gitsigns: Toggle Line Highlight"))
  keymap("n", "<LEADER>gtw", actions.toggle_word_diff,          opts("Gitsigns: Toggle Word Difference"))
  keymap("n", "<LEADER>gtd", actions.toggle_deleted,            opts("Gitsigns: Toggle Deleted"))

  keymap(
  "n", "<LEADER>gtc",
  function() actions.toggle_numhl() actions.toggle_linehl() actions.toggle_word_diff() end,
  opts("Gitsigns: Toggle Check Mode")
  )

  -- ==================== Preview ====================
  keymap("n", "<LEADER>gc", actions.preview_hunk_inline, opts("Gitsigns: Show Current Hunk Changes Inline"))
  keymap("n", "<LEADER>gC", actions.preview_hunk,        opts("Gitsigns: Show Current Hunk Changes Float"))

  -- ==================== Goto Prev/Next Hunk ====================
  keymap("n", "<LEADER>gn", function() actions.nav_hunk("next") end, opts("Gitsigns: Next Hunk"))
  keymap("n", "<LEADER>gN", function() actions.nav_hunk("prev") end, opts("Gitsigns: Prev Hunk"))

  -- ==================== Select Hunk ====================
  keymap("n", "<LEADER>gv", actions.select_hunk, opts("Gitsigns: Select Hunk"))

  -- ==================== Stage ====================
  keymap("n", "<LEADER>gs", actions.stage_hunk,   opts("Gitsigns: Stage Hunk"))
  keymap("n", "<LEADER>gS", actions.stage_buffer, opts("Gitsigns: Stage Buffer"))
  keymap("n", "<LEADER>gr", actions.reset_hunk,   opts("Gitsigns: Reset Hunk"))
  keymap("n", "<LEADER>gR", actions.reset_buffer, opts("Gitsigns: Reset Buffer"))
  keymap("x", "<LEADER>gs", function() actions.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, opts("Gitsigns: Stage Hunk"))
  keymap("x", "<LEADER>gr", function() actions.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, opts("Gitsigns: Reset Hunk"))

  -- ==================== Undo ====================
  keymap("n", "<LEADER>gu", actions.undo_stage_hunk, opts("Gitsigns: Undo"))

  -- ==================== Diffthis ====================
  keymap("n", "<LEADER>gf", function() actions.diffthis("HEAD") end, opts("Gitsigns: Show Diff for Current Buffer"))

  -- ==================== Quickfix ====================
  keymap("n", "<LEADER>gq", actions.setqflist, opts("Gitsigns: Show in List"))
end
