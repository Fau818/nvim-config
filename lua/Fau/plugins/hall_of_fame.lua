-- IMPORTANT: The plugins in this file are already deprecated!!! They shouldn't be used in any case.

---@type LazySpec[]
return {
  {
    -- DESC: Easily add additional highlights to buffers.
    "folke/paint.nvim",
    config = function() require("Fau.configs.hall_of_fame.paint") end,
    -- event = { "BufReadPost", "BufNewFile" },
    ft = { "lua", "python" },
    enabled = false,
  },

  {
    -- DESC: Add animation for Neovim actions.
    "echasnovski/mini.animate",
    config = function() require("Fau.configs.hall_of_fame.mini-animate") end,
    event = "UIEnter",
    enabled = false,
  },
}
