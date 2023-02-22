-- NOTE: This module is for testing new plugins.

return {
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    enabled = false,
    config = function() require("Fau.core.lsp_signature") end,
    lazy = true,
  },

  {
    -- DESC: an incremental LSP rename supporter, which has a preview feature.
    -- WARNING: This plugin is disabled.
    "smjonas/inc-rename.nvim",
    enabled = Fau_vim.inc_rename.enable,
    config = function() require("Fau.core.inc_rename") end,
    lazy = true,
  },

  {
    -- DESC: single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
    event = "VeryLazy",
  },

  -- {
  --   -- DESC: Maybe in the future.
  --   -- mini.doc
  -- },


}
