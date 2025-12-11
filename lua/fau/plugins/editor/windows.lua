-- TASK: Clean?
---@type LazySpec
return {
  -- DESC: Add animation for Neovim window actions.
  ---@module "windows"
  "anuvyklack/windows.nvim",
  dependencies = { "anuvyklack/middleclass", "anuvyklack/animation.nvim" },
  enabled = false,

  event = "WinNew",
  keys = {
    { "<C-w>z", "<CMD>WindowsMaximize<CR>",             desc = "Window: Maximize" },
    { "<C-w>_", "<CMD>WindowsMaximizeVertically<CR>",   desc = "Window: Maximize Vertically" },
    { "<C-w>|", "<CMD>WindowsMaximizeHorizontally<CR>", desc = "Window: Maximize Horizontally" },
    { "<C-w>=", "<CMD>WindowsEqualize<CR>",             desc = "Window: Equalize" },
  },

  opts = {
    autowidth = {
      enable = true,
      winwidth = 0.65,
      filetype = nil,
    },
    ignore = {
      buftype  = fvim.file.excluded_buftypes,
      filetype = fvim.file.excluded_filetypes,
    },
    animation = {
      enable = true,
      duration = 250,
      fps = 60,
      easing = "in_out_sine",
    },
  },
}
