---@type LazySpec
return {
  -- DESC: Smartly move lines or selections.
  ---@module "mini.move"
  "echasnovski/mini.move",
  keys = {
    { "<A-h>", mode = "x",          desc = "Move: Selections Left" },
    { "<A-l>", mode = "x",          desc = "Move: Selections Right" },
    { "<A-j>", mode = { "n", "x" }, desc = "Move: lines Down" },
    { "<A-k>", mode = { "n", "x" }, desc = "Move: lines Up" },
  },
  cond = true,

  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Move visual selection in Visual mode.
      left  = "<A-h>",
      right = "<A-l>",
      down  = "<A-j>",
      up    = "<A-k>",

      -- Move current line in Normal mode
      line_left  = "",
      line_right = "",
      line_down  = "<A-j>",
      line_up    = "<A-k>",
    },

    -- Options which control moving behavior
    options = {
      -- Automatically reindent selection during linewise vertical move
      reindent_linewise = true,
    }
  }
}
