local function _on_attach(bufnr)
  local gitsigns = require("gitsigns")
  local keymap  = vim.keymap.set
  local function opts(desc) return { desc = "Gitsigns: " .. desc, buffer = bufnr } end

  -- ==================== Navigation ====================
  ---@diagnostic disable-next-line: param-type-mismatch
  keymap("n", "]g", function() gitsigns.nav_hunk("next") end, opts("Next Hunk"))
  ---@diagnostic disable-next-line: param-type-mismatch
  keymap("n", "[g", function() gitsigns.nav_hunk("prev") end, opts("Prev Hunk"))

  -- ==================== Stage & Reset ====================
  keymap("n", "<LEADER>gs", gitsigns.stage_hunk,   opts("Stage Hunk"))
  keymap("n", "<LEADER>gS", gitsigns.stage_buffer, opts("Stage Buffer"))
  keymap("n", "<LEADER>gr", gitsigns.reset_hunk,   opts("Reset Hunk"))
  keymap("n", "<LEADER>gR", gitsigns.reset_buffer, opts("Reset Buffer"))
  keymap("x", "<LEADER>gs", function() gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts("Stage Hunk"))
  keymap("x", "<LEADER>gr", function() gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, opts("Reset Hunk"))
  keymap("n", "<LEADER>gu", gitsigns.undo_stage_hunk, opts("Gitsigns: Undo"))

  -- ==================== Preview ====================
  keymap({ "n", "x" }, "<LEADER>gc", gitsigns.preview_hunk_inline, opts("Preview Changes Inline"))
  keymap({ "n", "x" }, "<LEADER>gC", gitsigns.preview_hunk,        opts("Preview Changes Float"))

  -- ==================== Blame ====================
  keymap("n", "<LEADER>gb", function() gitsigns.blame_line({ full = true }) end, opts("Show Full Blame"))

  -- ==================== Select Hunk ====================
  keymap("n", "<LEADER>gv", gitsigns.select_hunk, opts("Select Hunk"))
  keymap({ "o", "x" }, "ih", gitsigns.select_hunk, opts("Git Hunk"))

  -- ==================== Diffthis ====================
  ---@diagnostic disable-next-line: param-type-mismatch
  keymap("n", "<LEADER>gf", function() gitsigns.diffthis("HEAD") end, opts("Diff Current Buffer"))

  -- ==================== Quickfix ====================
  keymap("n", "<LEADER>gq", gitsigns.setloclist, opts("Gitsigns: Show in List"))

  -- ==================== Toggle ====================
  -- keymap("n", "<LEADER>gtb", gitsigns.toggle_current_line_blame, opts("Toggle Line Blame"))
  -- keymap("n", "<LEADER>gts", gitsigns.toggle_signs,              opts("Toggle Column Signs"))
  -- keymap("n", "<LEADER>gtn", gitsigns.toggle_numhl,              opts("Toggle Number Highlight"))
  -- keymap("n", "<LEADER>gtl", gitsigns.toggle_linehl,             opts("Toggle Line Highlight"))
  -- keymap("n", "<LEADER>gtw", gitsigns.toggle_word_diff,          opts("Toggle Word Difference"))
  -- keymap(
  --   "n", "<LEADER>gtc",
  --   function() gitsigns.toggle_numhl(); gitsigns.toggle_linehl(); gitsigns.toggle_word_diff() end,
  --   opts("Gitsigns: Toggle Check Mode")
  -- )
end


---@type LazySpec
return {
  ---@module "gitsigns"
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },

  ---@type Gitsigns.Config
  opts = {
    signs = {
      add          = { text = fvim.icons.gitsigns.BoldLine,     show_count = true },
      change       = { text = fvim.icons.gitsigns.BoldLine,     show_count = true },
      delete       = { text = fvim.icons.gitsigns.Delete,       show_count = true },
      topdelete    = { text = fvim.icons.gitsigns.TopDelete,    show_count = true },
      changedelete = { text = fvim.icons.gitsigns.ChangeDelete, show_count = true },
      untracked    = { text = fvim.icons.gitsigns.Untracked,    show_count = true },
    },
    signs_staged = {
      add          = { text = fvim.icons.gitsigns.BoldLine,     show_count = true },
      change       = { text = fvim.icons.gitsigns.BoldLine,     show_count = true },
      delete       = { text = fvim.icons.gitsigns.Delete,       show_count = true },
      topdelete    = { text = fvim.icons.gitsigns.TopDelete,    show_count = true },
      changedelete = { text = fvim.icons.gitsigns.ChangeDelete, show_count = true },
      untracked    = { text = fvim.icons.gitsigns.Untracked,    show_count = true },
    },
    count_chars = { [1] = "¹", [2] = "²", [3] = "³", [4] = "⁴", [5] = "⁵", [6] = "⁶", [7] = "⁷", [8] = "⁸", [9] = "⁹", ["+"] = "+" },

    signs_staged_enable = true,

    auto_attach = true,
    attach_to_untracked = true,
    on_attach = _on_attach,

    signcolumn = true,   -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false,  -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false,  -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false,  -- Toggle with `:Gitsigns toggle_word_diff`
    -- culhl      = false,

    watch_gitdir = { follow_files = true },

    current_line_blame = true,  -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",  ---@type "eol" | "overlay" | "right_align"
      virt_text_priority = fvim.settings.sign_priority.git_blame,
      delay = fvim.settings.debounce.git_blame,
      ignore_whitespace = true,  -- whether to ignore the whitespace when checking
      use_focus = true,  -- Enable only when buffer is in focus
    },
    current_line_blame_formatter = "<author>, <author_time:%R> • <summary>",
    -- current_line_blame_formatter_nc = nil,  -- Use default.

    sign_priority = fvim.settings.sign_priority.gitsigns,
    update_debounce = fvim.settings.debounce.gitsigns,
    -- status_formatter = nil,  -- Use default
    max_file_length = fvim.file.large_file_line,  -- Disable if file is longer than this (in lines)

    preview_config = { border = "single", style = "minimal", relative = "cursor", row = 0, col = 1 },

    trouble = true,
    gh = true,

    -- worktrees = nil,  -- Use default.
    -- watch_gitdir = nil,  -- Use default.
    -- diff_opts = {},  -- Use default.
  }
}
