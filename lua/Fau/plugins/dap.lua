-- NOTE: This module is for debug adapter protocol, will be lazy-loaded.

---@type LazySpec[]
local dap = {
  {
    -- DESC: debug adapter protocol client implementation for Neovim.
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        -- DESC: UI supporter for nvim-dap.
        "rcarriga/nvim-dap-ui",
        config = function() require("Fau.core.dap.dapui") end,
        enabled = Fau_vim.plugin.dap.enable,
      },
      {
        -- DESC: virtual text support when debugging.
        "theHamsta/nvim-dap-virtual-text",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function() require("Fau.core.dap.virtual-text") end,
        enabled = Fau_vim.plugin.dap.enable,
      },
    },
    config = function() require("Fau.core.dap.dapconfig") end,
    enabled = Fau_vim.plugin.dap.enable,
    lazy = true,
  }
}


return dap
