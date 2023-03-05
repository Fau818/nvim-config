local gitsigns = {
  ["<LEADER>g"] = {
    name = "+Git Signs",

    -- Toggle
    t = {
      name = "+Toggle",
      b = { "<CMD>Gitsigns toggle_current_line_blame<CR>", "Toggle Line Blame"       },
      s = { "<CMD>Gitsigns toggle_signs<CR>",              "Toggle Column Signs"     },
      n = { "<CMD>Gitsigns toggle_numhl<CR>",              "Toggle Number Highlight" },
      l = { "<CMD>Gitsigns toggle_linehl<CR>",             "Toggle Line Highlight"   },
      w = { "<CMD>Gitsigns toggle_word_diff<CR>",          "Toggle Word Difference"  },
      c = {
        "<CMD>Gitsigns toggle_numhl<CR><CMD>Gitsigns toggle_linehl<CR><CMD>Gitsigns toggle_word_diff<CR>",
        "Toggle Git Check Mode"
      },
    },

    -- -- Show File Diff
    -- D = { "<CMD>Gitsigns diffthis<CR>", "Show the File Diff" },

    -- Preview the current hunk
    c = { "<CMD>Gitsigns preview_hunk_inline<CR>", "Show Current Hunk Changes Inline" },
    C = { "<CMD>Gitsigns preview_hunk<CR>",        "Show Current Hunk Changes Float"  },

    -- Goto Prev/Next Hunk
    p = { "<CMD>Gitsigns prev_hunk<CR>", "Prev Hunk" },
    n = { "<CMD>Gitsigns next_hunk<CR>", "Next Hunk" },

    -- Send to the Quickfix List
    q = { "<CMD>Gitsigns setqflist<CR>", "Show in Quickfix" },

    -- Stage and Reset
    s = { "<CMD>Gitsigns stage_hunk<CR>",      "Stage Current Hunk"   },
    S = { "<CMD>Gitsigns stage_buffer<CR>",    "Stage Current Buffer" },

    r = { "<CMD>Gitsigns reset_hunk<CR>",      "Reset Current Hunk"   },
    R = { "<CMD>Gitsigns reset_buffer<CR>",    "Reset Current Buffer" },

    u = { "<CMD>Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk"      },

    -- Diffview
    d = { "<CMD>DiffviewOpen<CR>",        "Open Diffview" },
    D = { "<CMD>DiffviewFileHistory<CR>", "Open Diffview" },
  },
}


return {
  n = { gitsigns },
  x = { gitsigns },
}
