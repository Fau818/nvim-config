-- IMPORTANT: The plugins in this file are already deprecated!!! They shouldn't be loaded in any case.

---@type LazySpec[]
return {
  {
    -- DESC: highlight parameters in comments.
    "folke/paint.nvim",
    config = function() require("Fau.core.paint") end,
    -- event = { "BufReadPost", "BufNewFile" },
    ft = { "lua", "python" },
    cond = false,
  },
}
