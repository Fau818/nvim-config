-- DESC: This module is for testing new plugins.

---@type LazySpec[]
return {
  {
    "xeluxee/competitest.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    config = function() require("competitest").setup() end,
    enabled = false,
  },

  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      -- "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python",  --optional
    },
    branch = "regexp",  -- This is the regexp branch, use this for the new version
    config = function() require("venv-selector").setup() end,
    -- keys = { { ",v", "<cmd>VenvSelect<cr>" } },
    lazy = true,
  },
}
