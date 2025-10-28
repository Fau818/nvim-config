-- TODO: refactor it [NEXT]
-- TODO: Add `@module`
-- DESC: This module is the basis of editor UI.

---@type LazySpec[]
return {
  -- ==================== Dashboard ====================
  {
    -- DESC: Welcome dashboard for Neovim.
    "goolord/alpha-nvim",
    config = function() require("Fau.ui.alpha") end,
    event = "VimEnter",
    keys = { { ";", "<CMD>Alpha<CR>", desc = "Dashboard: Toggle" } },
  },


  -- ==================== File Tree ====================
  {
    -- DESC: File explorer tree for Neovim.
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function() require("Fau.ui.nvim-tree.before_loaded") end,
    config = function() require("Fau.ui.nvim-tree") end,
    cmd = { "NvimTreeFindFileToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle", "NvimTreeFocus" },
    keys = { { "<LEADER>e", "<CMD>NvimTreeFindFileToggle<CR>", desc = "nvim-tree: Toggle" } },
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
    -- DESC: A fancy and configurable statusline.
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function() require("Fau.ui.lualine") end,
    event = "UIEnter",
  },

  {
    -- DESC: Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    init = function()
      -- Use diagonal lines in place of deleted lines in diff mode.
      vim.opt.fillchars:append{ diff = "╱" }
    end,
    config = function() require("Fau.ui.diffview") end,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" }
  },
}
