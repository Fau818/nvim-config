-- DESC: This module is for treesitter, will be loaded in `BufReadPost` and `BufNewFile` event.

-- TODO: Move this module to `editor` module.
---@type LazySpec[]
return {
  {
    -- DESC: An incremental parsing system for programming tools for Neovim.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require("Fau.configs.treesitter") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Show context of the current buffer contents.
    "nvim-treesitter/nvim-treesitter-context",
    config = function() require("Fau.configs.treesitter.context") end,
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
