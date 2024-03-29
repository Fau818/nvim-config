-- NOTE: This module is for language server protocol, will be loaded in `BufReadPost` and `BufNewFile` events.

---@type LazySpec[]
local lsp = {
  -- =============================================
  -- ========== LSP Manager
  -- =============================================
  {
    -- DESC: quickstart config LSP in Neovim.
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "lvimuser/lsp-inlayhints.nvim",
      "folke/neoconf.nvim",
    },
    config = function()
      require("Fau.core.lsp.diagnostics_config")
      require("Fau.core.lsp.lspconfig")
    end,
    cmd = "LspInfo",
    event = "BufReadPre",
  },

  {
    -- DESC: a bridge between lspconfig and mason.nvim for making things easier.
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        -- DESC: a powerful manager for LSP, DAP, Linter and Formatter.
        "williamboman/mason.nvim",
        config = function() require("Fau.core.lsp.mason") end,
        cmd = "Mason",
      },
    },
    config = function() require("Fau.core.lsp.mason-lspconfig") end,
    lazy = true, -- loaded by nvim-lspconfig
  },

  {
    -- DESC: a powerful language server manager.
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.null-ls") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: a powerful lua completion tool for Neovim.
    "folke/neodev.nvim",
    config = function() require("Fau.core.neodev") end,
    ft = "lua",
  },

  {
    -- DESC: config LSP in json file.
    "folke/neoconf.nvim",
    config = function() require("Fau.core.lsp.neoconf") end,
    cmd = "Neoconf",
    lazy = true,  -- loaded by nvim-lspconfig
  },

  -- =============================================
  -- ========== LSP Enhancement
  -- =============================================
  {
    -- DESC: LSP inlay hints supporter.
    "lvimuser/lsp-inlayhints.nvim",
    branch = vim.fn.has("nvim-0.10") == 1 and "anticonceal" or "main",
    config = function() require("Fau.core.lsp.inlayhints") end,
    lazy = true, -- loaded by nvim-lspconfig
    enabled = vim.fn.has("nvim-0.10") == 0,
  },

  {
    -- DESC: a powerful breadcrumb plugin based on navic.
    "utilyre/barbecue.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons",
      {
        -- DESC: a fancy winbar plugin combining with LSP.
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function() require("Fau.core.navic") end,
      },
    },
    config = function() require("Fau.core.barbecue") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Barbecue",
  },

  {
    -- DESC: a plugin to show symbol outline.
    "stevearc/aerial.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.aerial")end,
    cmd = { "AerialToggle", "AerialNavToggle" },
  },

}


return lsp
