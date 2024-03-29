-- NOTE: This is a utility tool module, will be lazy-loaded.

---@type LazySpec[]
local utility = {
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

  {
    -- DESC: detect file indentation automatically.
    "tpope/vim-sleuth",
    config = function() require("Fau.core.sleuth") end,
    event = { "BufReadPost", "BufNewFile" },
    enabled = false,
  },

  {
    -- DESC: detect file indentation automatically.
    "nmac427/guess-indent.nvim",
    config = function() require("Fau.core.guess-indent") end,
    event = "BufReadPre",
  },

}


return utility
