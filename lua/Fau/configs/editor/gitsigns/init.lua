-- =============================================
-- ========== Plugin Configurations
-- =============================================
local gitsigns = require("gitsigns")

---@type Gitsigns.Config
local config = {
  signs = {
    add          = { text = Fau_vim.icons.gitsigns.BoldLine,     show_count = true },
    change       = { text = Fau_vim.icons.gitsigns.BoldLine,     show_count = true },
    delete       = { text = Fau_vim.icons.gitsigns.Delete,       show_count = true },
    topdelete    = { text = Fau_vim.icons.gitsigns.TopDelete,    show_count = true },
    changedelete = { text = Fau_vim.icons.gitsigns.ChangeDelete, show_count = true },
    untracked    = { text = Fau_vim.icons.gitsigns.Untracked,    show_count = true },
  },

  signs_staged_enable = true,
  signs_staged = {
    add          = { text = Fau_vim.icons.gitsigns.BoldLine,     show_count = true },
    change       = { text = Fau_vim.icons.gitsigns.BoldLine,     show_count = true },
    delete       = { text = Fau_vim.icons.gitsigns.Delete,       show_count = true },
    topdelete    = { text = Fau_vim.icons.gitsigns.TopDelete,    show_count = true },
    changedelete = { text = Fau_vim.icons.gitsigns.ChangeDelete, show_count = true },
    untracked    = { text = Fau_vim.icons.gitsigns.Untracked,    show_count = true },
  },

  count_chars = { [1] = "¹", [2] = "²", [3] = "³", [4] = "⁴", [5] = "⁵", [6] = "⁶", [7] = "⁷", [8] = "⁸", [9] = "⁹", ["+"] = "+" },

  auto_attach = true,
  attach_to_untracked = true,
  on_attach = require("Fau.configs.editor.gitsigns.keymaps"),

  signcolumn = true,   -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false,  -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false,  -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false,  -- Toggle with `:Gitsigns toggle_word_diff`

  watch_gitdir = { follow_files = true },

  current_line_blame = true,  -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",  ---@type "eol" | "overlay" | "right_align"
    virt_text_priority = 100,
    delay = 500,
    ignore_whitespace = true,  -- whether to ignore the whitespace when checking
  },
  -- current_line_blame_formatter = "<author>, <author_time:%Y/%m/%d>, <committer_time:%H:%M> • <summary>",
  current_line_blame_formatter = "<author>, <author_time:%R> • <summary>",

  sign_priority = Fau_vim.settings.sign_priority.gitsigns,  -- set 12 to cover diagnostic
  update_debounce = 100,
  -- status_formatter = nil,  -- Use default
  max_file_length = Fau_vim.file.large_file_line,  -- Disable if file is longer than this (in lines)

  preview_config = { border = "single", style = "minimal", relative = "cursor", row = 0, col = 1 },

  trouble = true,  -- Integrated with trouble.nvim
}


gitsigns.setup(config)
