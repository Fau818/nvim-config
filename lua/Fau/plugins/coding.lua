-- DESC: This module is for better coding, including some editing utilities.

---@type LazySpec[]
return {
  -- ==================== Text Operation ====================
  {
    -- DESC: Quickly add, modify, and remove surround.
    "kylechui/nvim-surround",
    config = function() require("Fau.configs.coding.surround") end,
    keys = {
      { "s", mode = { "n", "x" }, desc = "+Surround" },
      { "S", mode = { "n", "x" }, desc = "+SURROUND" },
      { "cs", desc = "+Change Surround" },
      { "ds", desc = "+Delete Surround" },
    },
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
    keys = { { "gc", mode = { "n", "x" }, desc = "+Comment" }, { "gb", mode = { "n", "x" }, desc = "+Comment (Block)" } },
    cond = true,
  },

  {
    -- DESC: Align text interactively.
    "echasnovski/mini.align",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("Fau.configs.coding.mini-align") end,
    keys = { { "<LEADER>a", mode = "x", desc = "Edit: Align Text with Preview" }, { "<LEADER>A", mode = "x", desc = "Edit: Align Text" } },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Smartly move lines or selections.
    "echasnovski/mini.move",
    config = function() require("Fau.configs.coding.mini-move") end,
    keys = {
      { "<A-h>", mode = "x",          desc = "Move: Selections Left" },
      { "<A-l>", mode = "x",          desc = "Move: Selections Right" },
      { "<A-j>", mode = { "n", "x" }, desc = "Move: lines Down" },
      { "<A-k>", mode = { "n", "x" }, desc = "Move: lines Up" },
    },
    cond = true,
  },

  {
    -- DESC: Splitting and joining block of code.
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("Fau.configs.coding.treesj") end,
    cmd = { "TSJJoin", "TSJSplit", "TSJToggle" },
    keys = { { "sj", "<CMD>TSJToggle<CR>", mode = "n", desc = "Treesj: Split and Join" } },
  },

  {
    -- DESC: Running code action on nodes(code).
    "ckolkey/ts-node-action",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = true,
    cmd = { "NodeAction", "NodeActionDebug" },
    keys = { { "<LEADER>n", "<CMD>NodeAction<CR>", mode = "n", desc = "Node Action: Node Action" } },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

  {
    -- DESC: Convert text case in Neovim.
    "johmsalas/text-case.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function() require("Fau.configs.coding.textcase") end,
    event = "VeryLazy",  -- Its keymaps are conflicted with `trouble.nvim`, so loaded it manually (VeryLazy).
    cmd = { "Subs", "TextCaseOpenTelescope", "TextCaseOpenTelescopeQuickChange", "TextCaseOpenTelescopeLSPChange", "TextCaseStartReplacingCommand" },
    keys = { { "<LEADER>t", mode = { "n", "x" }, desc = "+Text Case" } },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },


  -- ==================== Code Enhancement ====================
  {
    -- DESC: Auto convert normal string to template string.
    -- Fau: Used to automatically convert string to f-string in python.
    "axelvc/template-string.nvim",
    config = function() require("Fau.configs.completion.template-string") end,
    ft =  { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
  },

  {
    -- DESC: Press <TAB> to jump out of brakets.
    "abecodes/tabout.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "hrsh7th/nvim-cmp" },
    config = function() require("Fau.configs.coding.tabout") end,
    event = "InsertEnter",
    cond = true,
  },

  {
    -- DESC: Multi-cursor support in Neovim.
    "smoka7/multicursors.nvim",
    dependencies = "smoka7/hydra.nvim",
    config = function() require("Fau.configs.coding.multicursors") end,
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "n", "x" },
        "<LEADER>m",
        "<CMD>MCstart<CR>",
        desc = "Multicursors: Create a selection for selected word under the cursor",
      },
      {
        mode = { "n", "x" },
        "<LEADER>M",
        "<CMD>MCunderCursor<CR>",
        desc = "Multicursors: Create a selection for selected text under the cursor",
      },
    },
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

  {
    -- DESC: A snazzy jump plugin.
    "folke/flash.nvim",
    config = function() require("Fau.configs.coding.flash") end,
    event = "VeryLazy",
    cond = true,
  },


}
