-- NOTE: This module is for testing new plugins.

---@type LazySpec[]
local test = {
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    enabled = false,
    config = function() require("Fau.core.lsp.lsp_signature") end,
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


  -- {
  --   -- DESC: Maybe in the future.
  --   -- mini.doc
  -- },


  {
    "luukvbaal/statuscol.nvim",
    config = function() require("Fau.core.statuscol") end,
    lazy = true,  -- loaded by nvim-ufo
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "luukvbaal/statuscol.nvim",
    },
    config = function() require("Fau.core.ufo") end,
    event = { "BufReadPost", "BufNewFile" },
  }



}


return test
