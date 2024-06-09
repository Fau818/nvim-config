-- NOTE: This module is for better coding, will be loaded in `BufReadPost` and `BufNewFile` (Rarely loaded in `InsertEnter` and `BufWritePre`) events

---@type LazySpec[]
local coding = {
  -- -----------------------------------
  -- -------- Text Operations
  -- -----------------------------------
  {
    -- DESC: Quickly add, modify, and remove surround.
    "kylechui/nvim-surround",
    config = function() require("Fau.configs.coding.surround") end,
    keys = { { "s", mode = { "n", "x" } }, { "S", mode = { "n", "x" } }, "cs", "ds" },
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
          require("ts_context_commentstring").setup({ enable_autocmd = false })
        end,
      },
    },
    config = function() require("Fau.configs.coding.comment") end,
    keys = { { "gc", mode = { "n", "x" } }, { "gb", mode = { "n", "x" } } },
    cond = true,
  },

  {
    -- DESC: Align text interactively.
    "echasnovski/mini.align",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.configs.coding.mini-align") end,
    keys = { { "<LEADER>a", mode = "x" }, { "<LEADER>A", mode = "x" } },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Smartly move lines or selections.
    "echasnovski/mini.move",
    config = function() require("Fau.configs.coding.mini-move") end,
    keys = {
      { "<A-h>", mode = "x",          desc = "Move Selections left" },
      { "<A-l>", mode = "x",          desc = "Move Selections right" },
      { "<A-j>", mode = { "n", "x" }, desc = "Move lines Down" },
      { "<A-k>", mode = { "n", "x" }, desc = "Move lines Up" },
    },
    cond = true,
  },

  {
    -- DESC: Splitting and joining block of code.
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.configs.coding.treesj") end,
    cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
    keys = { { "sj", "<CMD>TSJToggle<CR>", mode = "n", desc = "Split and Join" } },
  },

  {
    -- DESC: Running code action on nodes(code).
    "ckolkey/ts-node-action",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
    cmd = { "NodeAction", "NodeActionDebug" },
    keys = { { "<LEADER>n", "<CMD>NodeAction<CR>", mode = "n", desc = "Node Action" } },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Convert text case in Neovim.
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require("Fau.configs.coding.textcase") end,
    cmd = { "Subs", "TextCaseOpenTelescope", "TextCaseOpenTelescopeQuickChange", "TextCaseOpenTelescopeLSPChange", "TextCaseStartReplacingCommand" },
    keys = {
      {
        "<LEADER>tc",
        "<CMD>Telescope textcase initial_mode=normal layout_strategy=center sorting_strategy=ascending<CR>",
        mode = { "n", "x" },
        desc = "Conver Text Case",
      },
    },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },


  -- -----------------------------------
  -- -------- Edit Enhancements
  -- -----------------------------------
  {
    -- DESC: Press <TAB> to jump out of brakets.
    "abecodes/tabout.nvim",
    config = function() require("Fau.configs.coding.tabout") end,
    event = "InsertEnter",
    cond = true,
  },

  {
    -- DESC: Auto generate python docstring.
    "pixelneo/vim-python-docstring",
    config = function()
      vim.g.python_style = "numpy"  -- values: google|numpy|rest|epytext
      vim.g.vpd_indent = (" "):rep(vim.bo.tabstop)
    end,
    cmd = { "Docstring", "DostringTypes", "DocstringLine" },
    keys = {
      { "<LEADER><LEADER>d", "<CMD>DocstringTypes<CR>", desc = "Python Docstring with type hints" },
      { "<LEADER><LEADER>D", "<CMD>Docstring<CR>",      desc = "Python Docstring" }
    },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Auto convert normal string to template string.
    -- Fau: Used to automatically convert string to f-string in python.
    "axelvc/template-string.nvim",
    config = function() require("Fau.configs.coding.template-string") end,
    ft =  { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
    cond = true,  -- TESTING: Not TESTED in VSCode.
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
      },
    },
    config = function() require("Fau.configs.coding.multicursors") end,
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Auto switch input method.
    "keaising/im-select.nvim",
    config = function() require("Fau.configs.coding.im-select") end,
    event = "InsertEnter",
    cond = true,  -- TESTING: Not TESTED in VSCode.
    enabled = vim.fn.executable("im-select") == 1 and true or false,
  },

}


return coding
