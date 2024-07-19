-- IMPORTANT: The plugins in this file are already deprecated!!! They shouldn't be loaded in any case.

---@type LazySpec[]
return {
  {
    -- DESC: Easily add additional highlights to buffers.
    "folke/paint.nvim",
    config = function() require("Fau.core.paint") end,
    -- event = { "BufReadPost", "BufNewFile" },
    ft = { "lua", "python" },
    enabled = false,
  },
}
