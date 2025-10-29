--- TODO: Refactor me!
---@type LazySpec[]
return {
  {
    -- DESC: File explorer tree for Neovim.
    ---@module "nvim-tree"
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function() require("Fau.ui.nvim-tree.before_loaded") end,
    config = function() require("Fau.ui.nvim-tree") end,
    cmd = { "NvimTreeFindFileToggle", "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle", "NvimTreeFocus" },
    keys = { { "<LEADER>e", "<CMD>NvimTreeFindFileToggle<CR>", desc = "nvim-tree: Toggle" } },
  },

  {
    -- DESC: Add LSP support for file operations in NvimTree.
    ---@module "lsp-file-operations"
    "antosha417/nvim-lsp-file-operations",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-tree.lua" },
    config = true,
    ft = "NvimTree",
  },
}
