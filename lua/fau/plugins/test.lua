-- DESC: This module is for testing new plugins.

---@type LazySpec[]
return {
  {
    ---@module "competitest"
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function() require("competitest").setup() end,
    enabled = false,
  },

}
