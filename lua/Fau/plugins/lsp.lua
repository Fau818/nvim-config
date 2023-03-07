-- NOTE: This module is for language server protocol, will be loaded in `BufReadPost` and `BufNewFile` events.

---@type LazySpec[]
local lsp = {
  -- =============================================
  -- ========== LSP Manager
  -- =============================================
  {
    -- DESC: quickstart config LSP in Neovim.
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim", "lvimuser/lsp-inlayhints.nvim" },
    config = function()
      require("Fau.core.lsp.diagnostic_config")
      require("Fau.core.lsp.lspconfig")
    end,
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    -- DESC: a bridge between lspconfig and mason.nvim for making things easier.
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function() require("Fau.core.lsp.mason-lspconfig") end,
    lazy = true, -- loaded by nvim-lspconfig
  },
  {
    -- DESC: a powerful manager for LSP, DAP, Linter and Formatter.
    "williamboman/mason.nvim",
    config = function() require("Fau.core.lsp.mason") end,
    cmd = "Mason",
    lazy = true, -- loaded by mason-lspconfig.nvim
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
    -- WARN: This plugin needs to load before lua_ls.
    -- if use `ft = "lua"` for lazy loading, the function called
    -- Fau_vim.functions.lsp.set_client_by_ft() will respect its order.
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
    -- DESC: a fancy winbar plugin combining with LSP.
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.navic") end,
    lazy = true, -- loaded by barbecue
  },

  {
    -- DESC: a powerful breadcrumb plugin based on navic.
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic", "kyazdani42/nvim-web-devicons" },
    config = function() require("Fau.core.barbecue") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Barbecue",
  },

  {
    -- DESC: a plugin to show symbol outline.
    "stevearc/aerial.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.aerial")end,
    cmd = "AerialToggle",
  },

}


return lsp
