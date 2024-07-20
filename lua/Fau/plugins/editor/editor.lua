-- TODO: ...
-- DESC: This module is for enhancing editor.

---@type LazySpec[]
return {
  -- -----------------------------------
  -- -------- Powerful Window
  -- -----------------------------------
  {
    -- DESC: Terminal enhancer.
    "akinsho/toggleterm.nvim",
    config = function() require("Fau.core.terminal") end,
    lazy = true,
  },

  {
    -- DESC: easily run code in Neovim.
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.code_runner") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    init = function()
      -- Use diagonal lines in place of deleted lines in diff mode.
      vim.opt.fillchars:append{ diff = "╱" }
    end,
    config = function() require("Fau.core.diffview") end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" }
  },


  -- -----------------------------------
  -- -------- Jump
  -- -----------------------------------
  {
    -- DESC: a snazzy jump plugin.
    "folke/flash.nvim",
    config = function() require("Fau.core.flash") end,
    event = "VeryLazy",
    cond = true,
  },


}
