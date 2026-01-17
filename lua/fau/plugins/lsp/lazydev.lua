---@type LazySpec
return {
  -- DESC: Faster LuaLS setup for Neovim.
  ---@module "lazydev"
  "folke/lazydev.nvim",
  ft = "lua",

  ---@type lazydev.Config
  opts = {
    enabled = function(root_dir)
      ---@cast root_dir string
      if root_dir:match(".*nvim.*") then return true end
      if root_dir == vim.env.DOTFILE_PATH then return true end
      -- TODO: Set a keymap to toggle this globally.
      return vim.g.lazydev_enabled
    end,
    library = {
      vim.fn.stdpath("config"),
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      "lazy.nvim",
      "snacks.nvim",
    },
  },
}
