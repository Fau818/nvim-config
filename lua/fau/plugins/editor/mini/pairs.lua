---@type LazySpec
return {
  ---@module "mini.pairs"
  "nvim-mini/mini.pairs",
  lazy = true,  -- Loaded by blink.cmp

  opts = {
    -- In which modes mappings from this `config` should be created
    modes = { insert = true, command = false, terminal = false },

    -- Global mappings. Each right hand side should be a pair information, a
    -- table with at least these fields (see more in |MiniPairs.map|):
    -- - <action> - one of 'open', 'close', 'closeopen'.
    -- - <pair> - two character string for pair to be used.
    -- By default pair is not inserted after `\`, quotes are not recognized by
    -- <CR>, `'` does not insert the pair after a letter.
    -- Only parts of tables can be tweaked (others will use these defaults).
    mappings = {
      -- NOTE: The commented mappings are defaults.

      ["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
      ["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
      ["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },

      [")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },
      ["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },
      ["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },

      -- "^[^%w%-%_\\]"
      ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "^[%s]", register = { cr = false } },
      ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[%s]", register = { cr = false } },
      ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[%s]", register = { cr = false } },

      [" "] = { action = "closeopen", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]" }
    },
  },

}
