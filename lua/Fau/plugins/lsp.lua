-- TODO: Refactor
-- DESC: This module is for language server protocol.

---@type LazySpec[]
return {
  -- =============================================
  -- ========== LSP Manager
  -- =============================================
  {
    -- DESC: quickstart config LSP in Neovim.
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "folke/neoconf.nvim",
    },
    init = function()
      if vim.fn.has("nvim-0.10") == 1 then vim.lsp.inlay_hint.enable(true) end
      require("Fau.core.lsp.diagnostics_config")
      require("Fau.core.lsp.lspconfig")
    end,
    event = "BufReadPre",
    cmd = "LspInfo",
    keys = { { "<LEADER>li", "<CMD>LspInfo<CR>", desc = "LSP: Show Info" } },
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
        keys = { { "<LEADER>lI", "<CMD>Mason<CR>", desc = "LSP: Show Mason" } },
      },
    },
    config = function() require("Fau.core.lsp.mason-lspconfig") end,
    lazy = true,  -- loaded by nvim-lspconfig
  },

  {
    -- DESC: Faster LuaLS setup for Neovim.
    "folke/lazydev.nvim",
    config = function()
      local plugins = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        "lazy.nvim",
        "snacks.nvim",
        { "which-key.nvim", words = { "wk%." } },
        { "copilot.lua", words = { "copilot" } }
      }
      require("lazydev").setup({ library = plugins })
    end,
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
    -- DESC: a powerful breadcrumb plugin based on navic.
    "utilyre/barbecue.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
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
    -- DESC: Show symbol outline.
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function() require("Fau.core.aerial")end,
    cmd = { "AerialToggle", "AerialNavToggle" },
    keys = {
      { "<LEADER>lo", "<CMD>AerialToggle<CR>",    desc = "Symbol Outline: Toggle" },
      { "<LEADER>lO", "<CMD>AerialNavToggle<CR>", desc = "Symbol Outline: Toggle Navigation" },
    },
  },

  {
    -- DESC: Show references, definitions and implementations of symbols.
    "Wansmer/symbol-usage.nvim",
    config = function() require("Fau.core.symbol-usage") end,
    event = vim.fn.has("nvim-0.10") == 1 and "LspAttach" or "BufReadPre",
  },
}
