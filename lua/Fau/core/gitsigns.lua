-- =============================================
-- ========== Plugin Loading
-- =============================================
local gitsigns_ok, gitsigns = pcall(require, "gitsigns")
if not gitsigns_ok then Fau_vim.load_plugin_error("gitsigns") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type Gitsigns.Config
local config = {
  signs = {
    add          = { text = Fau_vim.icons.gitsigns.BoldLineLeft, show_count = true },
    change       = { text = Fau_vim.icons.gitsigns.BoldLineLeft, show_count = true },
    delete       = { text = Fau_vim.icons.gitsigns.Triangle, },
    topdelete    = { text = Fau_vim.icons.gitsigns.Triangle, },
    changedelete = { text = Fau_vim.icons.gitsigns.BoldLineLeft, },
    untracked    = { text = Fau_vim.icons.gitsigns.Untracked, },
  },

  count_chars = {
    [1]   = "¹",  -- '1'  '₁'
    [2]   = "²",  -- '2'  '₂'
    [3]   = "³",  -- '3'  '₃'
    [4]   = "⁴",  -- '4'  '₄'
    [5]   = "⁵",  -- '5'  '₅'
    [6]   = "⁶",  -- '6'  '₆'
    [7]   = "⁷",  -- '7'  '₇'
    [8]   = "⁸",  -- '8'  '₈'
    [9]   = "⁹",  -- '9'  '₉'
    ["+"] = "+",  -- '>'  '₊'
  },

  auto_attach = true,
  attach_to_untracked = true, -- Attach to untracked files.
  on_attach = function(bufnr)
    -- TODO: call which-key binding.
  end,

  signcolumn = true,   -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false,  -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false,  -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false,  -- Toggle with `:Gitsigns toggle_word_diff`

  watch_gitdir = { follow_files = true },

  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    virt_text_priority = 100,
    delay = 500,
    ignore_whitespace = true, -- whether to ignore the whitespace when checking
  },
  current_line_blame_formatter = "<author>, <author_time:%Y/%m/%d>, <committer_time:%H:%M> • <summary>",

  sign_priority = 9,  -- set 12 to cover diagnostic
  update_debounce = 100,
  max_file_length = 5000, -- Disable if file is longer than this (in lines)

  preview_config = {
    -- Options passed to nvim_open_win
    border   = "single",
    style    = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
}


gitsigns.setup(config)
