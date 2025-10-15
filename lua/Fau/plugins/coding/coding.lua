-- DESC: This module is for better coding, including some editing utilities.

---@type LazySpec[]
return {
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
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.configs.coding.tabout") end,
    event = { "InsertEnter", "CmdlineEnter" },
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
    cond = true,
  },

  {
    -- DESC: Auto switch input method.
    "keaising/im-select.nvim",
    config = function() require("Fau.configs.coding.im-select") end,
    event = { "InsertEnter", "CmdlineEnter" },
    cond = true,
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
