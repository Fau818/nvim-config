-- =============================================
-- ========== Plugin Configurations
-- =============================================
local paint = require("paint")

---@type PaintOptions
local config = {
  ---@type PaintHighlight[]
  highlights = {
    {
      filter = { filetype = "python" },
      pattern = " %[([Tt][Oo][Dd][Oo])%]",
      hl = "TodoFgTODO",
    },
    {
      filter = { filetype = "python" },
      pattern = " %[([Tt][Ee][Ss][Tt])%]",
      hl = "TodoFgTODO",
    },

    {
      filter = { filetype = "python" },
      pattern = "  *([%w_]+[ ]+:)",
      hl = "@parameter",
    },

    {
      filter = { filetype = "python" },
      pattern = "  Parameters",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "  Attributes",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "  References",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "  Examples",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "  Returns",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "  Raises",
      hl = "Identifier",
    },

    {
      filter = { filetype = "python" },
      pattern = "  %-%-%-%-%-*%-",
      hl = "PaintSeparator",
    },

  },
}

paint.setup(config)
