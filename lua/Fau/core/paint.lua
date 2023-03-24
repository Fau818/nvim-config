-- =============================================
-- ========== Plugin Loading
-- =============================================
local paint_ok, paint = pcall(require, "paint")
if not paint_ok then Fau_vim.load_plugin_error("paint") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type PaintOptions
local config = {
  ---@type PaintHighlight[]
  highlights = {
    {
      -- filter can be a table of buffer options that should match,
      -- or a function called with buf as param that should return true.
      -- The example below will paint @something in comments with Constant
      filter = { filetype = "lua" },
      pattern = "%s*%-%-%-%s*(@%w+)",
      hl = "Constant"
    },

    -- {
    --  filter = { filetype = "lua" },
    --  pattern = "%s*%-%-%-%s*@%w+ ([%w_]+%[*%]*)",
    --  hl = "@parameter",
    -- },

    {
      filter = { filetype = "python" },
      pattern = "% %[%w+%]",
      hl = "CommentReview",
    },

    {
      filter = { filetype = "python" },
      pattern = "%s*([%w_]+[ ]+:)",
      hl = "@parameter",
    },

    {
      filter = { filetype = "python" },
      pattern = "Parameters",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "Attributes",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "References",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "Examples",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "Returns",
      hl = "Identifier",
    },

    -- {
    --  filter = { filetype = "python" },
    --  pattern = "%-%-%-%-%-%-%-%-%-%-",
    --  hl = "Identifier",
    -- },
    --
    -- {
    --  filter = { filetype = "python" },
    --  pattern = "%-%-%-%-%-%-%-",
    --  hl = "Identifier",
    -- },

  },
}


paint.setup(config)
