-- NOTE: This module is for better coding, will be loaded in `BufReadPost` and `BufNewFile` events.
-- also maybe in `InsertEnter` event.

---@type LazySpec[]
local coding = {
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

  {
    "echasnovski/mini.move",
    config = function() require("Fau.core.mini.move") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: type <TAB> could jump out of brakets.
    "abecodes/tabout.nvim",
    config = function() require("Fau.core.tabout") end,
    event = "InsertEnter"
  },

  {
    -- DESC: align text interactively.
    "echasnovski/mini.align",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.mini.align") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    "echasnovski/mini.trailspace",
    config = function() require("Fau.core.mini.trailspace") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: auto switch input method.
    "keaising/im-select.nvim",
    config = function() require("Fau.core.im-select") end,
    event = "InsertEnter",
    -- enabled = not Fau_vim.on_server,
    enabled = vim.fn.executable("im-select") and false,  -- BUG: delay in telescope
  },

  {
    -- DESC: auto generate python docstring.
    "pixelneo/vim-python-docstring",
    config = function() require("Fau.core.python-docstring") end,
    ft = "python",
  },

}


return coding
