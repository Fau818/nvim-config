-- NOTE: This module is for testing new plugins.

---@type LazySpec[]
local test = {
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    config = function() require("Fau.core.lsp.lsp_signature") end,
    enabled = false,
  },

  {
    -- DESC: an incremental LSP rename supporter, which has a preview feature.
    -- WARNING: This plugin is disabled.
    -- Doesn't support input mode switch.
    "smjonas/inc-rename.nvim",
    config = function() require("Fau.core.inc_rename") end,
    enabled = Fau_vim.plugin.inc_rename.enable,
  },


  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("Fau.core.dropbar") end,
    lazy = true,  -- disabled
    enabled = false,
  },


  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function() require("competitest").setup() end,
    enabled = false,
  },

}


return test
