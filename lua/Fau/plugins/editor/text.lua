-- TODO: Refactor this file.
-- DESC: This module is for enhancing editor text.

---@type LazySpec[]
return {
  -- ==================== Text Augmentation ====================
  {
    -- "zbirenbaum/neodim",
    "ALVAROPING1/neodim",  -- NOTE: Use a forked version to fix the issue with Neovim 0.11
    branch = "fix-nvim-0.11",
    config = function() require("Fau.configs.editor.text.neodim") end,
    event = "LspAttach",
  },

  {
    -- DESC: Colorizer for showing color.
    "NvChad/nvim-colorizer.lua",
    config = function() require("Fau.configs.editor.text.colorizer") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Highlight the TODO comment-liked things.
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("Fau.configs.editor.text.todo-comments") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    keys = { { "<LEADER>T", "<CMD>Trouble todo filter = {tag = {TODO,FIX,TEST}}<CR>", desc = "TODO-Comments: Show in Trouble" } },
  },

}
