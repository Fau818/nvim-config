-- TODO: ...
-- DESC: This module is for enhancing editor.

---@type LazySpec[]
return {
  -- -----------------------------------
  -- -------- Powerful Window
  -- -----------------------------------
  {
    -- DESC: single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    init = function()
      -- Use diagonal lines in place of deleted lines in diff mode.
      vim.opt.fillchars:append{ diff = "╱" }
    end,
    config = function() require("Fau.core.diffview") end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" }
  },

}
