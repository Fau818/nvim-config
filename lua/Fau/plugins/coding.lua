-- NOTE: This module is for better coding, will be loaded in `BufReadPost` and `BufNewFile` events.
-- also maybe in `InsertEnter` event.

---@type LazySpec[]
local coding = {
  {
    -- DESC: quickly add, modify, and remove surround.
    "kylechui/nvim-surround",
    config = function() require("Fau.core.surround") end,
    event = { "BufReadPost", "BufNewFile" },
    cond = true,
  },

  {
    -- DESC: quick comment.
    "numToStr/Comment.nvim",
    dependencies = {
      {
        -- DESC: set the commentstring based on the context.
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
          vim.g.skip_ts_context_commentstring_module = true
          require('ts_context_commentstring').setup({ enable_autocmd = true })
        end,
      },
    },
    config = function() require("Fau.core.comment") end,
    event = { "BufReadPost", "BufNewFile" },
    cond = true,
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
    event = "InsertEnter",
  },

  {
    -- DESC: align text interactively.
    "echasnovski/mini.align",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.mini.align") end,
    event = { "BufReadPost", "BufNewFile" },
    cond = true,  -- FIX: Whether can use vscode's plugin.
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
    enabled = vim.fn.executable("im-select") == 1 and false,  -- BUG: delay in telescope
  },

  {
    -- DESC: auto generate python docstring.
    "pixelneo/vim-python-docstring",
    config = function() require("Fau.core.python-docstring") end,
    ft = "python",
  },

  {
    -- DESC: a plugin for splitting and joining block of code.
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.treesj") end,
    cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
  },

  {
    -- DESC: a plugin for running code action on nodes(code).
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: a plugin to auto change normal string to template string.
    "axelvc/template-string.nvim",
    config = function() require("Fau.core.template-string") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: convert text case in Neovim.
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require("Fau.core.textcase") end,
    keys = {
      {
        "<LEADER>tc",
        "<CMD>Telescope textcase initial_mode=normal layout_strategy=center sorting_strategy=ascending<CR>",
        mode = { "n", "x" },
        desc = "Conver Text Case",
      },
    },
  },

  {
    -- DESC: multi-cursor support in Neovim.
    "smoka7/multicursors.nvim",
    dependencies = { "smoka7/hydra.nvim" },
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "n", "x" },
        "<LEADER>m",
        "<CMD>MCstart<CR>",
        desc = "Create a selection for selected word under the cursor",
      },
      {
        mode = { "n", "x" },
        "<LEADER>M",
        "<CMD>MCunderCursor<CR>",
        desc = "Create a selection for selected text under the cursor",
      }
    },
    config = function() require("Fau.core.multicursor") end
  }

}


return coding
