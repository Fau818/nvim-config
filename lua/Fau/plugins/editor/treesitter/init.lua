-- DESC: This module is for treesitter.
---@type LazySpec[]
return {
  {
    -- DESC: An incremental parsing system for programming tools for Neovim.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require("Fau.plugins.editor.treesitter.config") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Show context of the current buffer contents.
    "nvim-treesitter/nvim-treesitter-context",
    config = function() require("Fau.plugins.editor.treesitter.context") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSContextEnable", "TSContextDisable", "TSContextToggle" },
  },

  {
    -- DESC: Enhance textobjects.
    "nvim-treesitter/nvim-treesitter-textobjects",
    requires = "nvim-treesitter/nvim-treesitter",
    config = nil,   -- Setup in nvim-treesitter
    event = { "BufReadPost", "BufNewFile" },
  }
}
