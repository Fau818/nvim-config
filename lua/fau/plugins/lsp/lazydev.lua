---@type LazySpec
return {
  -- DESC: Faster LuaLS setup for Neovim.
  ---@module "lazydev"
  "folke/lazydev.nvim",
  ft = "lua",

  ---@type lazydev.Config
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      "lazy.nvim",
      "snacks.nvim",
      { "which-key.nvim", words = { "wk%." } },
    },
  },
}
