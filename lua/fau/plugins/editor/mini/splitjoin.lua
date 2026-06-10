---@type LazyPluginSpec
return {
  ---@module "mini.splitjoin"
  "nvim-mini/mini.splitjoin",
  vscode = true,
  keys = { "sj" },
  enabled = false,  -- `treesj` is better.

  opts = function()
    local gen_hook = require("mini.splitjoin").gen_hook

    local curly = { brackets = { "%b{}" } }
    local add_comma_curly = gen_hook.add_trailing_separator(curly)
    local del_comma_curly = gen_hook.del_trailing_separator(curly)
    local pad_curly = gen_hook.pad_brackets(curly)

    return {
      -- Module mappings. Use `''` (empty string) to disable one.
      -- Created for both Normal and Visual modes.
      mappings = {
        toggle = "sj",
        split = "",
        join = "",
      },

      -- Detection options: where split/join should be done
      detect = {
        -- Array of Lua patterns to detect region with arguments.
        -- Default: { '%b()', '%b[]', '%b{}' }
        brackets = nil,

        -- String Lua pattern defining argument separator
        separator = ",",

        -- Array of Lua patterns for sub-regions to exclude separators from.
        -- Enables correct detection in presence of nested brackets and quotes.
        -- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
        exclude_regions = nil,
      },

      -- Split options
      split = {
        hooks_pre = {},
        hooks_post = { add_comma_curly }
      },

      -- Join options
      join = {
        hooks_pre = {},
        hooks_post = { del_comma_curly, pad_curly }
      },
    }
  end,
}
