-- =============================================
-- ========== Lazy Install
-- =============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)



-- =============================================
-- ========== Configuration
-- =============================================
local config = require("Fau.core.lazy")



-- =============================================
-- ========== Plugins
-- =============================================
local plugins = {
  -- {
  --   dir, url, name, dev, lazy, enabled, cond, dependencies,
  --   init, opts, config, build, branch, tag, commit, version,
  --   pin, submodules, event, cmd, ft, keys, module, priority
  -- }
  -- =============================================
  -- ======== utility
  -- =============================================
  {
    "nvim-lua/plenary.nvim",
    desc = "a utility tool repo for lua"
  },
  {
    "nvim-lua/popup.nvim",
    config = function() require("Fau.core.colorscheme") end,
    desc = "an implementation of the popup API from vim in Neovim"
  },
  {
    "kyazdani42/nvim-web-devicons",
    desc = "icons provider"
  },
  {
    "MunifTanjim/nui.nvim",
    desc = "a UI component library for Neovim"
  },


  -- =============================================
  -- ======== colorscheme
  -- =============================================
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    desc = "a snazzy colorscheme that can be customized"
  },
  {
    "lunarvim/darkplus.nvim",
    desc = "darkplus colorscheme in VSCode"
  },


  -- =============================================
  -- ======== surround and comment
  -- =============================================
  "kylechui/nvim-surround",  -- surround plugin
  "numToStr/Comment.nvim",  -- comment plugin
  "JoosepAlviste/nvim-ts-context-commentstring",  -- for setting the commentstring based on the cursor location in a file


  -- =============================================
  -- ======== completion and LSP
  -- =============================================
  "hrsh7th/nvim-cmp",                    -- nvim completion core plugin
  "hrsh7th/cmp-buffer",                  -- buffer cmp for nvim-cmp
  "hrsh7th/cmp-path",                    -- path cmp for nvim-cmp
  "hrsh7th/cmp-cmdline",                 -- command line cmp for nvim-cmp
  "davidsierradz/cmp-conventionalcommits",  -- gitcommit source
  "tamago324/cmp-zsh",  -- zsh source

  -- use "hrsh7th/cmp-nvim-lsp-signature-help" -- signature help cmp for nvim-cmp
  "folke/neodev.nvim",                   -- lua cmp, including neovim builtin documents

  "L3MON4D3/LuaSnip",             -- code snippets engine
  "saadparwaiz1/cmp_luasnip",     -- support L3MON4D3/LuaSnip plugin cmp in nvim-cmp
  -- use "rafamadriz/friendly-snippets" -- snippets repository

  "neovim/nvim-lspconfig", -- LSP support
  "hrsh7th/cmp-nvim-lsp",  -- LSP for nvim-cmp

  "williamboman/mason.nvim",           -- a powerful mananger for LSP, DAP, Linter and Formatter
  "williamboman/mason-lspconfig.nvim", -- a bridge between lspconfig and mason.nvim for making things easier.

  "jose-elias-alvarez/null-ls.nvim",  -- a powerful plugin for formatting etc

  "lvimuser/lsp-inlayhints.nvim",  -- inlay hints support

  "windwp/nvim-autopairs",  -- autopairs


  -- -- =============================================
  -- -- ======== fuzzy filter (Telescope)
  -- -- =============================================
  "nvim-telescope/telescope.nvim",    -- a powerful fuzzy filter
  {
    "nvim-telescope/telescope-fzf-native.nvim",  -- for speeding up the fuzzy find
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },
  "xiyaowong/telescope-emoji.nvim",   -- emoji support for telescope
  "benfowler/telescope-luasnip.nvim", -- luasnip support for telescope


  -- =============================================
  -- ======== parser
  -- =============================================
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },  -- a parser generator tool and an incremental parsing library
  "nvim-treesitter/playground",
  "RRethy/vim-illuminate",  -- highlight code
  -- use "nvim-treesitter/tree-sitter-query"


  -- =============================================
  -- ======== pretty UI
  -- =============================================
  "rcarriga/nvim-notify",  -- a popup notice

  "folke/which-key.nvim",  -- show keymap help

  "stevearc/dressing.nvim",  -- a ui selector

  "nvim-tree/nvim-tree.lua",   -- a file explorer tree
  "nvim-lualine/lualine.nvim", -- bottom status line
  "SmiteshP/nvim-navic",       -- breadcrumb
  "akinsho/bufferline.nvim",   -- show the buffer tab
  "famiu/bufdelete.nvim",      -- close the buffer but don't affect the layout (like vim-bbye)
  "stevearc/aerial.nvim",      -- Symbol Outline

  "lukas-reineke/indent-blankline.nvim", -- indent line

  "lewis6991/gitsigns.nvim", -- show git status
  "folke/trouble.nvim",      -- show gitsigns quicklist and LSP operations

  {
    "akinsho/toggleterm.nvim",
  },  -- toggle terminal

  "goolord/alpha-nvim",  -- start page

  "xiyaowong/nvim-transparent",  -- transparent background

  "NvChad/nvim-colorizer.lua",  -- show color of code
  "folke/todo-comments.nvim", -- highlight TODO tags in comment
  "folke/paint.nvim",         -- for highlighting params in comment
  "folke/noice.nvim",


  -- =============================================
  -- ======== workspace support
  -- =============================================
  "ahmedkhalf/project.nvim",  -- project support [better than 'telescope-project'] [support telescope]

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },


  -- =============================================
  -- ======== better writing
  -- =============================================
  "fedepujol/move.nvim",						 -- move lines
  "abecodes/tabout.nvim",           -- type <TAB> could jump out of brakets
  "echasnovski/mini.align",         -- align text

  "windwp/nvim-ts-autotag",         -- autotag
  "RRethy/nvim-treesitter-endwise", -- auto end

  "keaising/im-select.nvim",        -- auto switch input method

  "pixelneo/vim-python-docstring",  -- auto python docstring

  "folke/twilight.nvim",  -- focus coding
  "folke/zen-mode.nvim",  -- zen-mode

  "fladson/vim-kitty",  -- support highlight kitty config file


  -- =============================================
  -- ========== MISC
  -- =============================================
  "CRAG666/code_runner.nvim", -- run code
  "wakatime/vim-wakatime",    -- wakatime statistic


  -- =============================================
  -- ========== DAP
  -- =============================================
  {
    "mfussenegger/nvim-dap",
    enabled = Fau_vim.dap.enable
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = Fau_vim.dap.enable
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    enabled = Fau_vim.dap.enable
  },



  -- =============================================
  -- ======== new plugins [test]
  -- =============================================
  -- use "ray-x/lsp_signature.nvim"
  -- use "smjonas/inc-rename.nvim"
  -- use "nmac427/guess-indent.nvim"
  "tpope/vim-sleuth",  -- detect indentation automatically
  "sindrets/diffview.nvim",
}


-- require("lazy").setup(plugins, opts)
require("lazy").setup(plugins, config)
