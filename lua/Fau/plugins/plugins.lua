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
  -- -------- Pretty UI
  -- -----------------------------------






  {
    -- DESC: a fancy UI provider.
    "folke/noice.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function() require("Fau.core.noice") end,
    event = { "BufReadPre", "VeryLazy" },
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


return plugins
