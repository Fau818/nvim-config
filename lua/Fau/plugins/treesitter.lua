-- NOTE: This module is for treesitter, will be loaded in `BufReadPost` and `BufNewFile` event.
-- for playground, will be loaded by its specific commands.

---@type LazySpec[]
local treesitter = {
  {
    -- DESC: a parser generator tool and an incremental parsing library.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require("Fau.core.treesitter") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: a viewer for treesitter, which can show treesitter information directly in Neovim.
    "nvim-treesitter/playground",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = { "TSPlaygroundToggle", "TSCaptureUnderCursor", "TSNodeUnderCursor" },
    keys = {
      { "<LEADER><LEADER>u", "<CMD>TSCaptureUnderCursor<CR>", desc = "Capture Highlight Group Under Cursor" },
      { "<LEADER><LEADER>n", "<CMD>TSNodeUnderCursor<CR>",    desc = "Capture Node Under Cursor" }
    },
  },

  {
    -- DESC: Show context of the current buffer contents.
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("Fau.core.treesitter.context") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
  },

  {
    -- DESC: Enhance textobjects.
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
  },

}


return treesitter
