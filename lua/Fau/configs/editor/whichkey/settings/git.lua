local mode = { "n", "x" }

---@type wk.Spec
return {

    -- ==================== Git Signs ====================
  { "<LEADER>g",  mode = mode, group = "Git Signs" },

  -- ---------- Toggle
  { "<LEADER>gt", mode = mode, group = "Toggle" },
  { "<LEADER>gtb", "<CMD>Gitsigns toggle_current_line_blame<CR>", mode = mode, desc = "Toggle Line Blame" },
  { "<LEADER>gts", "<CMD>Gitsigns toggle_signs<CR>",              mode = mode, desc = "Toggle Column Signs" },
  { "<LEADER>gtn", "<CMD>Gitsigns toggle_numhl<CR>",              mode = mode, desc = "Toggle Number Highlight" },
  { "<LEADER>gtl", "<CMD>Gitsigns toggle_linehl<CR>",             mode = mode, desc = "Toggle Line Highlight" },
  { "<LEADER>gtw", "<CMD>Gitsigns toggle_word_diff<CR>",          mode = mode, desc = "Toggle Word Difference" },
  {
    "<LEADER>gtc",
    "<CMD>Gitsigns toggle_numhl<CR><CMD>Gitsigns toggle_linehl<CR><CMD>Gitsigns toggle_word_diff<CR>",
    mode = mode,
    desc = "Toggle Git Check Mode"
  },

  -- ---------- Preview
  { "<LEADER>gc", "<CMD>Gitsigns preview_hunk_inline<CR>", mode = mode, desc = "Show Current Hunk Changes Inline" },
  { "<LEADER>gC", "<CMD>Gitsigns preview_hunk<CR>",        mode = mode, desc = "Show Current Hunk Changes Float" },

  -- ---------- Goto Prev/Next Hunk
  { "<LEADER>gn", "<CMD>Gitsigns next_hunk<CR>", mode = mode, desc = "Next Hunk" },
  { "<LEADER>gN", "<CMD>Gitsigns prev_hunk<CR>", mode = mode, desc = "Prev Hunk" },

  -- ---------- Stage
  { "<LEADER>gs", ":Gitsigns stage_hunk<CR>",       mode = mode, desc = "Stage Hunk" },
  { "<LEADER>gS", "<CMD>Gitsigns stage_buffer<CR>", mode = mode, desc = "Stage Buffer" },
  { "<LEADER>gr", ":Gitsigns reset_hunk<CR>",       mode = mode, desc = "Reset Hunk" },
  { "<LEADER>gR", "<CMD>Gitsigns reset_buffer<CR>", mode = mode, desc = "Reset Buffer" },

  -- ---------- Undo
  { "<LEADER>gu", "<CMD>Gitsigns undo_stage_hunk<CR>", mode = mode, desc = "Undo Stage" },

  -- ---------- Quickfix
  { "<LEADER>gq", "<CMD>Gitsigns setqflist<CR>", mode = mode, desc = "Show in Quickfix" },

  -- ---------- Diffview
  { "<LEADER>gd", "<CMD>DiffviewOpen<CR>",          mode = mode, desc = "Open Diffview" },
  { "<LEADER>gf", "<CMD>DiffviewFileHistory %<CR>", mode = mode, desc = "Open Diffview for Current File" },
  { "<LEADER>gF", "<CMD>DiffviewFileHistory<CR>",   mode = mode, desc = "Open Diffview for All Files" },

}
