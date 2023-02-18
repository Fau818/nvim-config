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
  --   pin, submodules, module, priority
  --   event, cmd, ft, keys,
  -- }
  -- -----------------------------------
  -- -------- Utility
  -- -----------------------------------
  {
    -- DESC: a utility tool repo written by lua.
    "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    -- DESC: an implementation of the popup API from vim in Neovim.
    "nvim-lua/popup.nvim",
    lazy = true,
  },
  {
    -- DESC: an icon provider.
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },
  {
    -- DESC: a UI component library for Neovim.
    "MunifTanjim/nui.nvim",
    lazy = true,
  },


  -- -----------------------------------
  -- -------- Colorscheme
  -- -----------------------------------
  {
    -- DESC: a snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function() require("Fau.core.colorscheme") end,
  },
  {
    -- DESC: the darkplus colorscheme just like VSCode.
    "lunarvim/darkplus.nvim",
    lazy = true,
  },


  -- -----------------------------------
  -- -------- Surround and Comment
  -- -----------------------------------
  {
    -- DESC: quickly add, modify, and remove surround.
    "kylechui/nvim-surround",
    config = function() require("Fau.core.surround") end,
  },
  {
    -- DESC: quick comment.
    "numToStr/Comment.nvim",
    config = function() require("Fau.core.comment") end,
  },
  {
    -- DESC: set the commentstring based on the context.
    "JoosepAlviste/nvim-ts-context-commentstring",
    dependencies = { "nvim-treesitter/nvim-treesitter", "numToStr/Comment.nvim" },
    lazy = true,
  },


  -- -----------------------------------
  -- -------- Completion
  -- -----------------------------------
  {
    -- DESC: neovim code completion core plugin.
    "hrsh7th/nvim-cmp",
    config = function() require("Fau.core.cmp") end,
  },
  {
    -- DESC: buffer completion source for nvim-cmp.
    "hrsh7th/cmp-buffer",
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    -- DESC: language server protocol completion source for nvim-cmp.
    "hrsh7th/cmp-nvim-lsp",
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    -- DESC: path completion source for nvim-cmp.
    "hrsh7th/cmp-path",
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    -- DESC: command line completion source for nvim-cmp.
    "hrsh7th/cmp-cmdline",
    dependencies = { "hrsh7th/nvim-cmp" },
  },
  {
    -- DESC: L3MON4D3/LuaSnip plugin completion source for nvim-cmp.
    "saadparwaiz1/cmp_luasnip",
    dependencies = { "hrsh7th/nvim-cmp", "L3MON4D3/LuaSnip" },
  },
  {
    -- DESC: gitcommit completion source for nvim-cmp.
    "davidsierradz/cmp-conventionalcommits",
    dependencies = { "hrsh7th/nvim-cmp" },
    ft = "gitcommit",
  },
  {
    -- DESC: zsh completion source for nvim-cmp.
    "tamago324/cmp-zsh",
    dependencies = { "hrsh7th/nvim-cmp" },
    ft = "zsh",
  },
  {
    -- DESC: signature help completion source for nvim-cmp.
    -- WARNING: This plugin is disabled.
    "hrsh7th/cmp-nvim-lsp-signature-help",
    dependencies = { "hrsh7th/nvim-cmp" },
    enabled = false,
  },

  {
    -- DESC: a powerful lua completion tool for Neovim.
    "folke/neodev.nvim",
    config = function() require("Fau.core.neodev") end,
    ft = "lua",
  },

  {
    -- DESC: a powerful code snippets engine.
    "L3MON4D3/LuaSnip",
    lazy = true,  -- needed by nvim-cmp
  },
  {
    -- DESC: an abundant code snippet repository (can be loaded into LuaSnip).
    -- WARNING: This plugin is disabled.
    "rafamadriz/friendly-snippets",
    enabled = false,
    lazy = true,
  },


  -- -----------------------------------
  -- -------- LSP
  -- -----------------------------------
  {
    -- DESC: quickstart config LSP in Neovim.
    "neovim/nvim-lspconfig",
    config = function() require("Fau.core.lsp") end,
  },

  {
    -- DESC: a powerful manager for LSP, DAP, Linter and Formatter.
    "williamboman/mason.nvim",
    lazy = true,
  },
  {
    -- DESC: a bridge between lspconfig and mason.nvim for making things easier.
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    lazy = true,
  },

  {
    -- DESC: LSP inlay hints supporter.
    "lvimuser/lsp-inlayhints.nvim",
    lazy = true,  -- needed by nvim-lspconfig [lsp module]
    -- NOTE: QAQ above.
  },

  {
    -- DESC: a powerful language server manager.
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require "Fau.core.null-ls" end,
  },


  {
    -- DESC: a super powerful autopair plugin for Neovim.
    "windwp/nvim-autopairs",
    config = function() require "Fau.core.autopairs" end,
  },


  -- -----------------------------------
  -- -------- Fuzzy Filter (Telescope)
  -- -----------------------------------
  {
    -- DESC: a powerful fuzzy filter.
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.telescope") end,
  },
  {
    -- DESC: a fzf sorter for telescope.
    "nvim-telescope/telescope-fzf-native.nvim",  -- for speeding up the fuzzy find
    dependencies = { "nvim-telescope/telescope.nvim" },
    build = "make",
    -- build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    lazy = true,
  },
  {
    -- DESC: an emoji searcher for telescope
    "xiyaowong/telescope-emoji.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    lazy = true,
  },
  {
    -- DESC: a telescope extension for searching LuaSnip.
    "benfowler/telescope-luasnip.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "L3MON4D3/LuaSnip" },
    lazy = true,
  },


  -- -----------------------------------
  -- -------- Parser
  -- -----------------------------------
  {
    -- DESC: a parser generator tool and an incremental parsing library.
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function() require("Fau.core.treesitter") end,
  },
  {
    -- DESC: a viewer for treesitter, which can show treesitter information directly in Neovim.
    "nvim-treesitter/playground",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = { "TSCaptureUnderCursor", "TSNodeUnderCursor" },
  },
  {
    -- DESC: a plugin for automatically highlighting code.
    "RRethy/vim-illuminate",
    config = function() require("Fau.core.illuminate") end
  },


  -- -----------------------------------
  -- -------- Pretty UI
  -- -----------------------------------
  {
    -- DESC: a fancy notification manager for Neovim.
    "rcarriga/nvim-notify",
    config = function() require("Fau.core.notify") end,
  },

  {
    -- DESC: a fancy key binding helper.
    "folke/which-key.nvim",
    config = function() require("Fau.core.whichkey") end,
  },

  {
    -- DESC: a ui selector and receiver.
    "stevearc/dressing.nvim",
    config = function() require("Fau.core.dressing") end,
  },

  {
    -- DESC: a file explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    config = function() require("Fau.core.nvim-tree") end,
  },

  {
    -- DESC: a fancy and configurable statusline.
    "nvim-lualine/lualine.nvim",
    config = function() require("Fau.core.lualine") end,
  },
  {
    -- DESC: a fancy winbar to show breadcrumb combining with lualine.
    "SmiteshP/nvim-navic",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.navic") end,
    lazy = true,  -- will be called by lsp
  },
  {
    -- DESC: a snazzy tabline to show opened buffers.
    "akinsho/bufferline.nvim",
    config = function() require("Fau.core.bufferline") end,
  },
  {
    -- DESC: close the buffer but don't affect the layout (like vim-bbye).
    "famiu/bufdelete.nvim",
  },
  {
    -- DESC: a plugin to show symbol outline.
    "stevearc/aerial.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function() require("Fau.core.aerial")end,
    cmd = "AerialToggle",
  },

  {
    -- DESC: indent guides for Neovim.
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("Fau.core.indentline") end,
  },

  {
    -- DESC: git integration for buffer.
    "lewis6991/gitsigns.nvim",
    config = function() require("Fau.core.gitsigns") end,
  },
  {
    -- DESC: a pretty list to show diagnostics, references and etc (powerful quickfix list).
    "folke/trouble.nvim",
    config = function() require("Fau.core.trouble") end,
  },

  {
    -- DESC: a powerful terminal provider in Neovim.
    "akinsho/toggleterm.nvim",
    config = function() require("Fau.core.terminal") end,
  },

  {
    -- DESC: a greeter dashboard for Neovim.
    "goolord/alpha-nvim",
    config = function() require("Fau.core.alpha") end,
  },

  {
    -- DESC: make background transparent.
    "xiyaowong/nvim-transparent",
    config = function() require("Fau.core.transparent") end,
    -- BUG: needed fix colorscheme
    cmd = { "TransparentToggle", "TransparentEnable", "TransparentDisable" },
  },

  {
    -- DESC: a colorizer for showing color.
    "NvChad/nvim-colorizer.lua",
    config = function() require("Fau.core.colorizer") end,
  },

  {
    -- DESC: a highlighter for todo comments.
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.todo-comments") end,
  },
  {
    -- DESC: highlight parameters in comments.
    "folke/paint.nvim",
    config = function() require("Fau.core.paint") end,
    ft = { "lua", "python" },
  },
  {
    -- DESC: a fancy UI provider.
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function() require("Fau.core.noice") end,
  },

  -- -----------------------------------
  -- -------- Workspace Suppoert
  -- -----------------------------------
  {
    -- DESC: a superior project manager.
    "ahmedkhalf/project.nvim",
    config = function() require("Fau.core.project") end,
  },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function() require("persistence").setup() end,
  },


  -- -----------------------------------
  -- -------- Coding
  -- -----------------------------------
  {
    -- DESC: move lines smartly.
    "fedepujol/move.nvim",
  },
  {
    -- DESC: type <TAB> could jump out of brakets.
    "abecodes/tabout.nvim",
    config = function() require("Fau.core.tabout") end,
  },

  {
    -- DESC: align text interactively.
    "echasnovski/mini.align",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.align") end,
  },

  {
    -- DESC: auto close html tag.
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
  {
    -- DESC: smartly add `end` in lua, ruby, and etc.
    "RRethy/nvim-treesitter-endwise",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "lua", "ruby", "vim", "sh", "zsh", "elixir" }
  },

  {
    -- DESC: auto switch input method.
    "keaising/im-select.nvim",
    config = function() require("Fau.core.im-select") end,
  },

  {
    -- DESC: auto generate python docstring.
    "pixelneo/vim-python-docstring",
    config = function() require("Fau.core.python-docstring") end,
    ft = "python",
  },
  {
    -- DESC: dim inactive portions of the code to focus on coding.
    "folke/twilight.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() require("Fau.core.twilight") end,
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
  },
  {
    -- DESC: distraction-free coding for Neovim (zen-mode).
    "folke/zen-mode.nvim",
    config = function() require("Fau.core.zen-mode") end,
    cmd = "ZenMode",
  },

  {
    -- DESC: support highlighting in kitty config file.
    "fladson/vim-kitty",
    ft = "kitty",
  },


  -- -----------------------------------
  -- -------- MISC
  -- -----------------------------------
  {
    -- DESC: easily run code in Neovim.
    "CRAG666/code_runner.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("Fau.core.code_runner") end,
  },
  {
    -- DESC: coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
  },


  -- -----------------------------------
  -- -------- DAP
  -- -----------------------------------
  {
    -- DESC: debug adapter protocol client implementation for Neovim.
    "mfussenegger/nvim-dap",
    enabled = Fau_vim.dap.enable,
    config = function() require("Fau.core.dap") end,
    lazy = true,
  },
  {
    -- DESC: a UI supporter for nvim-dap.
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    enabled = Fau_vim.dap.enable,
    lazy = true,
  },
  {
    -- DESC: virtual text support when debugging.
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    enabled = Fau_vim.dap.enable,
    lazy = true,
  },


  -- -----------------------------------
  -- -------- New Plugins [TEST]
  -- -----------------------------------
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    enabled = false,
    config = function() require("Fau.core.lsp_signature") end,
  },
  {
    -- DESC: an incremental LSP rename supporter, which has a preview feature.
    -- WARNING: This plugin is disabled.
    "smjonas/inc-rename.nvim",
    enabled = false,
    config = function() require("Fau.core.inc_rename") end,
  },

  {
    -- DESC: detect file indentation automatically.
    "tpope/vim-sleuth",
    config = function() require("Fau.core.sleuth") end,
  },

  {
    -- DESC: single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
  },
}


-- require("lazy").setup(plugins, opts)
require("lazy").setup(plugins, config)
