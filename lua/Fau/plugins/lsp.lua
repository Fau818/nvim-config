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
    -- DESC: Faster LuaLS setup for Neovim.
    "folke/lazydev.nvim",
    config = function()
      local plugins = { "lazy.nvim", "lazydev.nvim", "luvit-meta/library", "nvim-lspconfig", "nvim-notify", "telescope.nvim" }
      local lib_path = {}
      for _, plugin in ipairs(plugins) do
        local path = ("%s/%s"):format(vim.env.LAZY, plugin)
        table.insert(lib_path, path)
      end
      Fau_vim.show(lib_path)
      require("lazydev").setup({ library = lib_path })
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
    -- DESC: Show symbol outline.
    "stevearc/aerial.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.aerial")end,
    cmd = { "AerialToggle", "AerialNavToggle" },
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
        desc = "Toggle LSP Lines",
      }
    },
    event = "LspAttach",
  }

}


return lsp
