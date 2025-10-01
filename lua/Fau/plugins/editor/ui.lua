-- DESC: This module is the basis of editor UI.

---@type LazySpec[]
return {
  -- ==================== Dashboard ====================
  {
    -- DESC: Welcome dashboard for Neovim.
    "goolord/alpha-nvim",
    config = function() require("Fau.configs.editor.ui.alpha") end,
    event = "VimEnter",
    keys = { { ";", "<CMD>Alpha<CR>", desc = "Dashboard: Toggle" } },
  },


  -- ==================== File Tree ====================
  {
    -- DESC: File explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function() require("Fau.configs.editor.ui.nvim-tree.before_loaded") end,
    config = function() require("Fau.configs.editor.ui.nvim-tree") end,
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
      -- TEST: Use `Snacks.bufdelete.delete()` in May 10, 2025.
      { "echasnovski/mini.bufremove", config = true, enabled = false },
    },
    config = function() require("Fau.configs.editor.ui.bufferline") end,
    event = "UIEnter",
  },

  {
    -- DESC: A fancy and configurable statusline.
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("Fau.configs.editor.ui.lualine") end,
    event = "UIEnter",
  },


  -- ==================== Scroll Bar ====================
    {
    -- DESC: A nice scrollbar.
    -- BUG: Delay in large file.
    -- HACK: Current solution is to disable scrollbar in large file.
    "lewis6991/satellite.nvim",
    config = function() require("Fau.configs.editor.ui.satellite") end,
    event = "UIEnter",
    enabled = vim.fn.has("nvim-0.10") == 1,
  },


  -- ==================== Status Column and Folding ====================
  {
    -- DESC: Statusline enhancer.
    "luukvbaal/statuscol.nvim",
    config = function() require("Fau.configs.editor.ui.statuscol") end,
    event = "UIEnter",
    enabled = vim.fn.has("nvim-0.10") == 1,
  },


  -- ==================== Git ====================
  {
    -- DESC: Git integration for Neovim.
    "lewis6991/gitsigns.nvim",
    config = function() require("Fau.configs.editor.ui.gitsigns") end,
    event = { "BufReadPost", "BufNewFile" },
  },

  {
    -- DESC: Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    init = function()
      -- Use diagonal lines in place of deleted lines in diff mode.
      vim.opt.fillchars:append{ diff = "╱" }
    end,
    config = function() require("Fau.configs.editor.ui.diffview") end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" }
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
        enabled = false,
      },
      {
        -- DESC: Switch conda environments by telescope.
        "IllustratedMan-code/telescope-conda.nvim",
        enabled = vim.fn.executable("conda") == 1,
      },
    },
    config = function() require("Fau.configs.editor.ui.telescope") end,
    event = "UIEnter",
    cmd = "Telescope",
    keys = { { "<LEADER>f", desc = "+Telescope" }, { "<LEADER><LEADER>f", desc = "+Telescope" }, { "<LEADER>F", "<CMD>Telescope<CR>", desc = "Telescope: Open Builtin" } },
  },

}
