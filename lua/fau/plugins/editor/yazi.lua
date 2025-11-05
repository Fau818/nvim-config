---@type LazySpec
return {
  -- DESC: Support Yazi file browser in Neovim.
  ---@module "yazi"
  "mikavilpas/yazi.nvim",
  dependencies = "nvim-lua/plenary.nvim",

  keys = {
    { "<leader>gy", function() require("yazi").yazi() end, desc = "Yazi: Open" },
    { "\\",         function() require("yazi").yazi() end, desc = "Yazi: Open" },
  },

  opts = { floating_window_scaling_factor = 1, yazi_floating_window_border = "none" },
  enabled = vim.fn.executable("yazi") == 1,
}
