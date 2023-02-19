-- NOTE: This module is for better coding, will be loaded in `BufReadPre` and `BufNewFile` events.

return {
  -- =============================================
  -- ========== Surround and Comment
  -- =============================================
  {
    -- DESC: quickly add, modify, and remove surround.
    "kylechui/nvim-surround",
    config = function() require("Fau.core.surround") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: quick comment.
    "numToStr/Comment.nvim",
    dependencies = {
      {
        -- DESC: set the commentstring based on the context.
        "JoosepAlviste/nvim-ts-context-commentstring",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
      },
    },
    config = function() require("Fau.core.comment") end,
    event = { "BufReadPost", "BufNewFile" },
  },

}
