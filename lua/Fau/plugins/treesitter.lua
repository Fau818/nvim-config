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
    cmd = { "TSCaptureUnderCursor", "TSNodeUnderCursor" },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function() require("Fau.core.context") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" }
  },

}


return treesitter
