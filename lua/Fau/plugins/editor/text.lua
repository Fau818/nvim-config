-- DESC: This module is for enhancing editor text, will be loaded in `BufReadPost` and `BufNewFile` event.

---@type LazySpec[]
return {
  -- ==================== Highlight ====================
  {
    -- DESC: Highlight other uses of the word under the cursor.
    "RRethy/vim-illuminate",
    config = function() require("Fau.configs.editor.illuminate") end,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      -- BUG: the `goto_next_reference` and `goto_prev_reference` functions don't work.
      { mode = { "n", "i" }, "<A-N>", function() require("illuminate").next_reference({ reverse=true,  wrap=true }) end, desc = "Prev Reference" },
      { mode = { "n", "i" }, "<A-n>", function() require("illuminate").next_reference({ reverse=false, wrap=true }) end, desc = "Next Reference" },
    }
  },

  -- ==================== Remove Trailing Redundant Spaces and Lines ====================
  {
    -- DESC: Auto remove trailing whitespaces and empty lines.
    "echasnovski/mini.trailspace",
    config = function() require("Fau.configs.editor.mini-trailspace") end,
    event = "BufWritePre",
  },

  -- ==================== Text Augmentation ====================
  {
    -- DESC: Colorizer for showing color.
    "NvChad/nvim-colorizer.lua",
    config = function() require("Fau.configs.editor.colorizer") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Highlight the TODO comment-liked things.
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("Fau.core.todo-comments") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    keys = { { "<LEADER>T", "<CMD>TodoTrouble keywords=TODO<CR>", desc = "Show Todo Comments" } }
  },


}
