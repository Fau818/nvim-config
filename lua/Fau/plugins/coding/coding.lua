-- DESC: This module is for better coding, including some editing utilities.

---@type LazySpec[]
return {
  -- ==================== Code Enhancement ====================
  {
    -- DESC: Multi-cursor support in Neovim.
    "smoka7/multicursors.nvim",
    dependencies = "smoka7/hydra.nvim",
    config = function() require("Fau.configs.coding.multicursors") end,
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "n", "x" },
        "<LEADER>m",
        "<CMD>MCstart<CR>",
        desc = "Multicursors: Create a selection for selected word under the cursor",
      },
      {
        mode = { "n", "x" },
        "<LEADER>M",
        "<CMD>MCunderCursor<CR>",
        desc = "Multicursors: Create a selection for selected text under the cursor",
      },
    },
    cond = true,
  },




}
