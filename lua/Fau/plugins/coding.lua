-- NOTE: This module is for better coding, will be loaded in `BufReadPost` and `BufNewFile` (Rarely loaded in `InsertEnter` and `BufWritePre`) events

---@type LazySpec[]
local coding = {
  {
    -- DESC: Quickly add, modify, and remove surround.
    "kylechui/nvim-surround",
    config = function() require("Fau.core.surround") end,
    event = { "BufReadPost", "BufNewFile" },
    cond = true,
  },

  {
    -- DESC: Powerful comment plugin for Neovim.
    "numToStr/Comment.nvim",
    dependencies = {
      {
        -- DESC: Set the commentstring based on the context.
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
    -- DESC: Smartly move lines or selections.
    "echasnovski/mini.move",
    config = function() require("Fau.core.mini.move") end,
    -- event = { "BufReadPost", "BufNewFile" },
    keys = {
      { "<A-h>", mode = "x", desc = "Move Selections left" },
      { "<A-l>", mode = "x", desc = "Move Selections right" },
      { "<A-j>", mode = { "n", "x" }, desc = "Move lines Down" },
      { "<A-k>", mode = { "n", "x" }, desc = "Move lines Up" },
    },
    cond = true,
  },

  {
    -- DESC: Press <TAB> to jump out of brakets.
    "abecodes/tabout.nvim",
    config = function() require("Fau.core.tabout") end,
    event = { "InsertEnter" },
    cond = true,
  },

  {
    -- DESC: Align text interactively.
    "echasnovski/mini.align",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.mini.align") end,
    -- event = { "BufReadPost", "BufNewFile" },
    keys = { { "<LEADER>a", mode = "x" }, { "<LEADER>A", mode = "x" } },
    cond = true,  -- Fau: Whether can use vscode's plugin.
  },

  {
    -- DESC: Auto remove trailing whitespaces and empty lines.
    "echasnovski/mini.trailspace",
    config = function() require("Fau.core.mini.trailspace") end,
    event = { "BufWritePre" },
  },

  {
    -- DESC: Auto switch input method.
    "keaising/im-select.nvim",
    config = function() require("Fau.core.im-select") end,
    event = { "InsertEnter" },
    enabled = vim.fn.executable("im-select") == 1 and true or false,
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Auto generate python docstring.
    "pixelneo/vim-python-docstring",
    config = function() require("Fau.core.python-docstring") end,
    ft = "python",
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Auto change normal string to template string.
    -- Fau: Used to automatically convert string to f-string in python.q
    "axelvc/template-string.nvim",
    config = function() require("Fau.core.template-string") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Splitting and joining block of code.
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.treesj") end,
    cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
    keys = { { "<LEADER>sj", "<CMD>TSJToggle<CR>", mode = "n", desc = "Split and Join" } },
  },

  {
    -- DESC: Running code action on nodes(code).
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    -- event = { "BufReadPost", "BufNewFile" },
    keys = { { "<LEADER>n", [[<CMD>lua require("ts-node-action").node_action()<CR>]], mode = "n", desc = "Node Action" } }
  },

  {
    -- DESC: Convert text case in Neovim.
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require("Fau.core.textcase") end,
    cmd = { "Subs", "TextCaseOpenTelescope", "TextCaseOpenTelescopeQuickChange", "TextCaseOpenTelescopeLSPChange", "TextCaseStartReplacingCommand" },
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
    -- DESC: Multi-cursor support in Neovim.
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
  },

}


return coding
