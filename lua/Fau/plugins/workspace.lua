-- NOTE: This module is for workspace(project) support.

return {
  -- =============================================
  -- ========== Workspace Support
  -- =============================================
  {
    -- DESC: a superior project manager.
    "ahmedkhalf/project.nvim",
    config = function() require("Fau.core.project") end,
    event = "VeryLazy",
  },

  {
    -- DESC: a simple session manager.
    "folke/persistence.nvim",
    config = function() require("persistence").setup() end,
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
  },
}
