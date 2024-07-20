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
      "lvimuser/lsp-inlayhints.nvim",
      "folke/neoconf.nvim",
    },
    config = function()
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
    -- DESC: a powerful language server manager.
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("Fau.core.null-ls") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Faster LuaLS setup for Neovim.
    "folke/lazydev.nvim",
    config = function()
      local plugins = { "lazy.nvim", "lazydev.nvim", "luvit-meta/library", "nvim-notify", "which-key.nvim" }
      require("lazydev").setup({ library = plugins })
    end,
    ft = "lua",
  },
  { "Bilal2453/luvit-meta", lazy = true },

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
    lazy = true,  -- loaded by nvim-lspconfig
    enabled = vim.fn.has("nvim-0.10") == 0,
  },

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

  {
    -- DESC: Render LSP diagnostics with virtual lines.
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
      vim.diagnostic.config({ virtual_lines = false })
      vim.diagnostic.config({ virtual_lines = { only_current_line = true } })

      -- TODO:  move to other place
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "lazy",
        callback = function()
          ---@diagnostic disable-next-line: undefined-field
          local virtual_lines = vim.diagnostic.config().virtual_lines
          local lines_on = virtual_lines ~= nil and virtual_lines ~= false
          if lines_on then vim.diagnostic.config({ virtual_lines = false }) end
        end
      })
    end,
    event = "LspAttach",
    keys = {
      {
        "<LEADER>lL",
        function()
          ---@diagnostic disable-next-line: undefined-field
          local virtual_lines = vim.diagnostic.config().virtual_lines
          local lines_on = virtual_lines ~= nil and virtual_lines ~= false
          if lines_on then vim.diagnostic.config({ virtual_lines = false })
          else vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
          end
        end,
        desc = "LSP: Toggle Lines",
      }
    },
  }

}
