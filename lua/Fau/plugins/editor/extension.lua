-- DESC: This module is for neovim extensions.

---@type LazySpec[]
return {
  -- ==================== File Browser ====================
  {
    -- DESC: Support Yazi file browser in Neovim.
    "mikavilpas/yazi.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = { floating_window_scaling_factor = 1, yazi_floating_window_border = "none" },
    keys = {
      { "<leader>gy", function() require("yazi").yazi() end, desc = "Yazi: Open" },
      { "\\",         function() require("yazi").yazi() end, desc = "Yazi: Open" },
    },
    enabled = vim.fn.executable("yazi") == 1,
  },


  -- ==================== AI ====================
  {
    -- DESC: ChatGPT in Neovim!
    "jackMort/ChatGPT.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function() require("Fau.configs.editor.extension.chatgpt") end,
    -- event = "VeryLazy",
    cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
    keys = require("Fau.configs.editor.extension.chatgpt.lazy_keys"),
  },

}
