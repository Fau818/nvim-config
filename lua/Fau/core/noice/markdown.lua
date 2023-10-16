return {
  hover = {
    ["|(%S-)|"] = vim.cmd.help, -- vim help links
    ["%[.-%]%((%S-)%)"] = require("noice.util").open, -- markdown links
  },
  highlights = {
    ["|%S-|"]               = "@text.reference",
    ["@%S+"]                = "@parameter",
    ["^%s*([%w\\_]+[ ]+:)"] = "@parameter",
    ["^%s*(Parameters)"]    = "@text.title",
    ["^%s*(Returns)"]       = "@text.title",
    ["^%s*(See also)"]      = "@text.title",
    ["{%S-}"]               = "@parameter",
  },
}
