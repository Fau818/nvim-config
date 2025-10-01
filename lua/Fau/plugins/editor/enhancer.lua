-- DESC: This module is for enhancing neovim features.

---@type LazySpec[]
return {


  -- ==================== Code Runner ====================
  {
    -- DESC: Easily run code in Neovim.
    "CRAG666/code_runner.nvim",
    config = function() require("Fau.configs.editor.enhancer.code_runner") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects", "CrStopHr" },
    keys = { "<C-r>", "<LEADER>r" },
  },


  -- ==================== Snacks ====================
  {
    "folke/snacks.nvim",
    priority = 1000,
    config = function() require("Fau.configs.editor.enhancer.snacks") end
  },


}
