-- DESC: This module is for enhancing editor UI, will be loaded in `UIEnter` event.

---@type LazySpec[]
local editor_ui = {
  -- ==================== Dashboard ====================
  {
    -- DESC: Welcome dashboard for Neovim.
    "goolord/alpha-nvim",
    config = function() require("Fau.configs.editor.alpha") end,
    event = "VimEnter",
    keys = { { ";", "<CMD>Alpha<CR>", desc = "Toggle Dashboard" } },
  },


  -- ==================== File Tree ====================
  {
    -- DESC: File explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("Fau.configs.editor.nvim-tree") end,
    cmd = { "NvimTreeFindFileToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle", "NvimTreeFocus" },
    keys = { { "<LEADER>e", "<CMD>NvimTreeFindFileToggle<CR>", desc = "Toggle NvimTree" } },
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


  -- ==================== Scroll Bar ====================
    {
    -- DESC: A nice scrollbar.
    "lewis6991/satellite.nvim",
    config = function() require("Fau.configs.editor.satellite") end,
    event = "UIEnter",
    enabled = vim.fn.has("nvim-0.10") == 1,
  },

}
return editor_ui
