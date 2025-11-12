-- DESC: This module is for enhancing editor functionality.

---@type LazySpec[]
return {
  {
    ---@module "ts-comments"
    "folke/ts-comments.nvim",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
    event = { "BufReadPost", "BufNewFile" },
    config = true,
  },

  {
    -- DESC: Simple session manager for Neovim.
    ---@module "persistence"
    "folke/persistence.nvim",
    init = function() vim.opt.sessionoptions = { "buffers", "curdir", "folds", "globals", "help", "skiprtp", "tabpages", "winsize" } end,
    config = true,
    event = "BufReadPre",  -- this will only start session saving when an actual file was opened
  },

  {
    -- DESC: Coding time tracker (for wakatime statistics).
    ---@module "wakatime"
    "wakatime/vim-wakatime",
    enabled = vim.fn.executable("wakatime-cli") == 1,
    event = "VeryLazy",
  },

}
