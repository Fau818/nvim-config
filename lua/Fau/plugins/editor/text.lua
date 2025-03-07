-- DESC: This module is for enhancing editor text.

---@type LazySpec[]
return {
  -- ==================== Highlight ====================
  {
    -- DESC: Highlight other uses of the word under the cursor.
    "RRethy/vim-illuminate",
    config = function() require("Fau.configs.editor.text.illuminate") end,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      -- BUG: the `goto_next_reference` and `goto_prev_reference` functions don't work.
      { mode = { "n", "i" }, "<A-N>", function() require("illuminate").next_reference({ reverse=true,  wrap=true }) end, desc = "Illuminate: Prev Reference" },
      { mode = { "n", "i" }, "<A-n>", function() require("illuminate").next_reference({ reverse=false, wrap=true }) end, desc = "Illuminate: Next Reference" },
    }
  },


  -- ==================== Indentation ====================
  {
    -- DESC: Indent guides for Neovim.
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("Fau.configs.editor.text.indentline") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Indent guide line with animation.
    "echasnovski/mini.indentscope",
    config = function() require("Fau.configs.editor.text.mini-indentscope") end,
    event = { "BufReadPost", "BufNewFile" },
  },


  -- ==================== Folding ====================
  {
    -- DESC: Folding enhancer.
    "kevinhwang91/nvim-ufo",
    init = function() require("Fau.configs.editor.text.ufo.before_loaded") end,
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter", "luukvbaal/statuscol.nvim" },
    config = function() require("Fau.configs.editor.text.ufo.init") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "UfoEnable", "UfoDisable", "UfoInspect", "UfoAttach", "UfoDetach", "UfoEnableFold", "UfoDisableFold" },
  },


  -- ==================== Text Augmentation ====================
  {
    "zbirenbaum/neodim",
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
    keys = { { "<LEADER>T", "<CMD>TodoTrouble keywords=TODO<CR>", desc = "TODO-Comments: Show in Trouble" } },
  },

}
