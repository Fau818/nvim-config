-- =============================================
-- ========== Plugin Loading
-- =============================================
local npairs = Fau_vim.load_plugin("nvim-autopairs")
if npairs == nil then return end




-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	disable_filetype = { "TelescopePrompt" },
	disable_in_macro = false,         -- disable when recording or executing a macro
	disable_in_visualblock = false,   -- disable when insert after visual block mode
	disable_in_replace_mode = true,

	ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],

	enable_moveright = true,          -- if true: (*) -> ()*  else: (*) -> ()*)
	enable_afterquote = true,         -- add bracket pairs after quote
	enable_check_bracket_line = true, -- check bracket in same line
	enable_bracket_in_quote = true,
	enable_abbr = false,              -- trigger abbreviation
	break_undo = true,                -- switch for basic rule break undo sequence
	check_ts = false,
	map_cr = true,   -- map the <CR> key
	map_bs = true,   -- map the <BS> key
	map_c_h = false, -- map the <C-h> key to delete a pair
	map_c_w = false, -- map <c-w> to delete a pair if possible
}


npairs.setup(config)



-- =============================================
-- ========== Rules
-- =============================================
local npairs_rule = require("nvim-autopairs.rule")

-- -----------------------------------
-- -------- Add Space Between Brackets
-- -----------------------------------
local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
npairs.add_rules {
	npairs_rule(" ", " "):with_pair(
		function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({
				brackets[1][1] .. brackets[1][2],
				brackets[2][1] .. brackets[2][2],
				brackets[3][1] .. brackets[3][2],
				}, pair)
		end
	)
}

for _, bracket in pairs(brackets) do
	npairs.add_rules {
		npairs_rule(bracket[1] .. " ", " " .. bracket[2])
				:with_pair(function() return false end)
				:with_move(function(opts) return opts.prev_char:match(".%" .. bracket[2]) ~= nil end)
				:use_key(bracket[2])
	}
end


-- -------------------------------------------
-- -------- arrow key on javascript [test]
-- -------------------------------------------
npairs.add_rules({
  npairs_rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
  :use_regex(true)
  :set_end_pair_length(2)
})
