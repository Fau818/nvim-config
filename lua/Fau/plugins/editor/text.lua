-- DESC: This module is for enhancing editor text, will be loaded in `BufReadPost` and `BufNewFile` event.

---@type LazySpec[]
return {
  -- ==================== Highlight ====================
  {
    -- DESC: Highlight other uses of the word under the cursor.
    "RRethy/vim-illuminate",
    config = function() require("Fau.configs.editor.illuminate") end,
    event = { "BufReadPost", "BufNewFile" },
    keys = {
      -- BUG: the `goto_next_reference` and `goto_prev_reference` functions don't work.
      { mode = { "n", "i" }, "<A-N>", function() require("illuminate").next_reference({ reverse=true,  wrap=true }) end, desc = "Prev Reference" },
      { mode = { "n", "i" }, "<A-n>", function() require("illuminate").next_reference({ reverse=false, wrap=true }) end, desc = "Next Reference" },
    }
  },
}
