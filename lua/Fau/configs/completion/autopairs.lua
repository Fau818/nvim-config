-- =============================================
-- ========== Plugin Configurations
-- =============================================
local npairs = require("nvim-autopairs")

local config = {
  disable_filetype = Fau_vim.file.disabled_filetypes,
  disable_in_macro        = false,  -- disable when recording or executing a macro
  disable_in_visualblock  = false,  -- disable when insert after visual block mode
  disable_in_replace_mode = true,

  ignored_next_char = nil,  -- Use default.

  enable_moveright          = true,  -- if true: (|) -> ()|  else: (|) -> ()|)
  enable_afterquote         = true,  -- add bracket pairs after quote
  enable_check_bracket_line = true,  -- check bracket in same line
  enable_bracket_in_quote   = true,
  enable_abbr               = false,  -- trigger abbreviation

  break_undo = true,  -- Switch for basic rule break undo sequence
  -- TEST: Enabled in June 5, 2024
  check_ts = true,  -- Use treesitter to check the pair.

  map_cr  = true,   -- map the <CR> key
  map_bs  = true,   -- map the <BS> key
  map_c_h = false,  -- map the <C-h> key to delete a pair
  map_c_w = false,  -- map <c-w> to delete a pair if possible
}

npairs.setup(config)



-- =============================================
-- ========== Rules
-- =============================================
local npairs_rule = require("nvim-autopairs.rule")
local npairs_cond = require("nvim-autopairs.conds")

-- -----------------------------------
-- -------- Add Space Between Brackets
-- -----------------------------------
local brackets_basic = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
npairs.add_rules {
  npairs_rule(" ", " ")
    :with_pair(
      function(opts)
        -- -- NOTE: Disable auto pairs in markdown ft.
        -- if vim.bo.filetype == "markdown" then return false end
        local pair = opts.line:sub(opts.col - 1, opts.col)
        local valid_pairs = {}
        for _, bracket in ipairs(brackets_basic) do table.insert(valid_pairs, table.concat(bracket)) end

        return vim.tbl_contains(valid_pairs, pair)
      end
    )
    :with_move(npairs_cond.none())
    :with_cr(npairs_cond.none())
    :with_del(function(opts)
      local context = opts.line:sub(opts.col - 1, opts.col + 2)
      local valid_contexts = {}
      for _, bracket in ipairs(brackets_basic) do table.insert(valid_contexts, table.concat(bracket, "  ")) end

      return vim.tbl_contains(valid_contexts, context)
    end)
}


-- -----------------------------------
-- -------- Skip Comma and Semicolon
-- -----------------------------------
for _,punct in pairs { ",", ";" } do
  npairs.add_rules {
    npairs_rule("", punct)
      :with_move(function(opts) return opts.char == punct end)
      :with_pair(function() return false end)
      :with_del(function() return false end)
      :with_cr(function() return false end)
      :use_key(punct)
  }
end


-- -------------------------------------------
-- -------- Arrow Key on Javascript [TEST]
-- -------------------------------------------
npairs.add_rules({
  npairs_rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
    :use_regex(true)
    :set_end_pair_length(2)
})


-- -----------------------------------
-- -------- For Jinja
-- -----------------------------------
-- npairs.add_rules({
--   npairs_rule("{%", "%}", "html")
--     :replace_endpair(
--       function(opts)
--         if opts.next_char == '}' then return "%" end
--         return "%}"
--       end
--     )
-- })


-- npairs.add_rules({
--   npairs_rule("{#", "#}", "html")
--     :replace_endpair(
--       function(opts)
--         if opts.next_char == '}' then return "#" end
--         return "#}"
--       end
--     )
-- })


-- local brackets_jinja = { { "{%", "%}" }, { "{#", "#}" } }
-- npairs.add_rules {
--   npairs_rule(" ", " "):with_pair(
--     function(opts)
--       local pair = opts.line:sub(opts.col - 2, opts.col + 1)
--       return vim.tbl_contains({
--         brackets_jinja[1][1] .. brackets_jinja[1][2],
--         brackets_jinja[2][1] .. brackets_jinja[2][2],
--       }, pair)
--     end
--   )
-- }
