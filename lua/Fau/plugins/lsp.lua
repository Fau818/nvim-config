-- NOTE: This module is for language server protocol, will be loaded in `BufReadPre` and `BufNewFile` events.

return {
  -- =============================================
  -- ========== LSP Manager
  -- =============================================
  {
    -- DESC: quickstart config LSP in Neovim.
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "lvimuser/lsp-inlayhints.nvim" },
    config = function()
      require("Fau.core.lsp.diagnostic_config")
      require("Fau.core.lsp.lspconfig")
    end,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    -- DESC: a powerful manager for LSP, DAP, Linter and Formatter.
    "williamboman/mason.nvim",
    config = function() require("Fau.core.lsp.mason") end,
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    lazy = true, -- loaded by nvim-lspconfig
  },
  {
    -- DESC: a bridge between lspconfig and mason.nvim for making things easier.
    "williamboman/mason-lspconfig.nvim",
    config = function() require("Fau.core.lsp.mason-lspconfig") end,
    lazy = true, -- loaded by mason.nvim
  },

  {
    -- DESC: a powerful language server manager.
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.null-ls") end,
    event = { "BufReadPre", "BufNewFile" },
  },


  -- =============================================
  -- ========== LSP Enhancement
  -- =============================================
  {
    -- DESC: LSP inlay hints supporter.
    "lvimuser/lsp-inlayhints.nvim",
    config = function() require("Fau.core.lsp.inlayhints") end,
    lazy = true, -- loaded by nvim-lspconfig
  },

  {
    -- DESC: a fancy winbar to show breadcrumb combining with lualine.
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.navic") end,
    lazy = true,  -- will be called by lualine
  },

  {
    -- DESC: a plugin to show symbol outline.
    "stevearc/aerial.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.aerial")end,
    cmd = "AerialToggle",
  },


}
