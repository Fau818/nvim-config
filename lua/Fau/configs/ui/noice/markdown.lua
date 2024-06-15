---@type NoiceConfig
local markdown = {
  hover = {
    ["|(%S-)|"] = vim.cmd.help, -- vim help links
    ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
  },
  highlights = {
    ["|%S-|"]             = "@text.reference",
    ["@%S+"]              = "@parameter",
    ["^%s*(Parameters:)"] = "@text.title",
    ["^%s*(Return:)"]     = "@text.title",
    ["^%s*(See also:)"]   = "@text.title",
    ["{%S-}"]             = "@parameter",
  },
}

return markdown
