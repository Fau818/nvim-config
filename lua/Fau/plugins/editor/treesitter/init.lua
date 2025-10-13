-- DESC: This module is for treesitter.
---@type LazySpec[]
return {
  {
    -- DESC: An incremental parsing system for programming tools for Neovim.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter-textobjects" },
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("Fau.plugins.editor.treesitter.config") end,
  },

  {
    -- DESC: Show context of the current buffer contents.
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
    config = function() require("Fau.plugins.editor.treesitter.context") end,
  },
}
