-- DESC: This module is for enhancing editor UI. Unlike `ui` module, this module is more fundamental for the editor.

---@type LazySpec[]
return {
  -- ==================== Dashboard ====================
  {
    -- DESC: Welcome dashboard for Neovim.
    "goolord/alpha-nvim",
    config = function() require("Fau.configs.editor.alpha") end,
    event = "VimEnter",
    keys = { { ";", "<CMD>Alpha<CR>", desc = "Dashboard: Toggle" } },
  },


  -- ==================== File Tree ====================
  {
    -- DESC: File explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function() require("Fau.configs.editor.nvim-tree.before_loaded") end,
    config = function() require("Fau.configs.editor.nvim-tree") end,
    cmd = { "NvimTreeFindFileToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle", "NvimTreeFocus" },
    keys = { { "<LEADER>e", "<CMD>NvimTreeFindFileToggle<CR>", desc = "nvim-tree: Toggle" } },
    -- BUG: Show file tree in iCloud folder leads delay. (Or say, in path with many files)
  },

  {
    -- DESC: Add LSP support for file operations in NvimTree.
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = true,
    ft = "NvimTree",
  },


  -- ==================== Bufferline and Statusline ====================
  {
    -- DESC: A snazzy bufferline for Neovim.
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      { "echasnovski/mini.bufremove", config = true },
    },
    config = function() require("Fau.configs.editor.bufferline") end,
    event = "UIEnter",
  },

  {
    -- DESC: A fancy and configurable statusline.
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("Fau.configs.editor.lualine") end,
    event = "UIEnter",
  },


  -- ==================== Indentation ====================
  {
    -- DESC: Indent guides for Neovim.
    "lukas-reineke/indent-blankline.nvim",
    config = function() require("Fau.configs.editor.indentline") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Indent guide line with animation.
    "echasnovski/mini.indentscope",
    config = function() require("Fau.configs.editor.indentscope") end,
    event = { "BufReadPost", "BufNewFile" },
  },


  -- ==================== Status Column and Folding ====================
  {
    -- DESC: Statusline enhancer.
    "luukvbaal/statuscol.nvim",
    config = function() require("Fau.configs.editor.statuscol") end,
    event = "UIEnter",
    enabled = vim.fn.has("nvim-0.10") == 1,
  },

  {
    -- DESC: Folding enhancer.
    "kevinhwang91/nvim-ufo",
    init = function() require("Fau.configs.editor.ufo.before_loaded") end,
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter", "luukvbaal/statuscol.nvim" },
    config = function() require("Fau.configs.editor.ufo") end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "UfoEnable", "UfoDisable", "UfoInspect", "UfoAttach", "UfoDetach", "UfoEnableFold", "UfoDisableFold" },
  },


  -- ==================== Scroll Bar ====================
    {
    -- DESC: A nice scrollbar.
    -- BUG: Delay in large file.
    -- HACK: Current solution is to disable scrollbar in large file.
    "lewis6991/satellite.nvim",
    config = function() require("Fau.configs.editor.satellite") end,
    event = "UIEnter",
    enabled = vim.fn.has("nvim-0.10") == 1,
  },


  -- ==================== Git Signs ====================
  {
    -- DESC: Git integration for Neovim.
    "lewis6991/gitsigns.nvim",
    config = function() require("Fau.configs.editor.gitsigns") end,
    event = { "BufReadPost", "BufNewFile" },
  },


  -- ==================== Fuzzy Finder ====================
  {
    -- DESC: Find, Filter, Preview, Pick.
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",

      -- ---------- Extensions
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

      -- TODO: The telescope is necessary for the following extensions. (The current situation is the opposite)
      {
        -- DESC: Explore projects with telescope.
        -- TEMP: Use a fork version to avoid deprecated warning.
        "LennyPhoenix/project.nvim",
        config = function() require("Fau.core.project") end,
      },
      {
        -- DESC: LuaSnip searcher for telescope.
        "benfowler/telescope-luasnip.nvim",
        dependencies = { "L3MON4D3/LuaSnip" },
      },
      {
        -- DESC: Switch conda environments by telescope.
        "IllustratedMan-code/telescope-conda.nvim",
        enabled = vim.fn.executable("conda") == 1,
      },
    },
    config = function() require("Fau.configs.editor.telescope") end,
    event = "UIEnter",
    cmd = "Telescope",
    keys = { { "<LEADER>f", desc = "+Telescope" }, { "<LEADER><LEADER>f", desc = "+Telescope" }, { "<LEADER>F", "<CMD>Telescope<CR>", desc = "Telescope: Open Builtin" } },
  },


  -- ==================== Quickfix ====================
  {
    -- DESC: Quickfix list enhancer.
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope.nvim"  -- Not necessary, but for loading telescope keybinds first!
    },
    config = function() require("Fau.configs.editor.trouble") end,
    event = "LspAttach",
    cmd = "Trouble",
    tag = Fau_vim.plugin.trouble.tag,
  },


  -- ==================== Key Binding ====================
  {
    -- DESC: Key binding helper.
    "folke/which-key.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("Fau.configs.editor.whichkey") end,
    event = "UIEnter",
  },


  -- ==================== Terminal ====================
  {
    -- DESC: Terminal enhancer.
    "akinsho/toggleterm.nvim",
    config = function() require("Fau.configs.editor.terminal") end,
    keys = { "<C-t>", "<LEADER>gg", "<LEADER>gb" },
    cmd = { "ToggleTerm", "TermExec" },
  },


}
