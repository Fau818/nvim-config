-- =============================================
-- ========== Plugin Loading
-- =============================================
local tabout = Fau_vim.load_plugin("tabout")
if tabout == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	tabkey = "<TAB>",                -- key to trigger tabout, set to an empty string to disable
	backwards_tabkey = "<S-TAB>",    -- key to trigger backwards tabout, set to an empty string to disable
	act_as_tab = true,               -- shift content if tab out is not possible
	act_as_shift_tab = true,         -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
	default_tab = "<C-TAB>",         -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
	default_shift_tab = "<C-S-TAB>", -- reverse shift default action,
	enable_backwards = false,        -- Disable if you just want to move forward
	completion = true, -- If you use a completion pum that also uses the tab key for a smart scroll function. Setting this to true will disable tab out when the pum is open and execute the smart scroll function instead.
	tabouts = {
		{ open = "'", close = "'" },
		{ open = '"', close = '"' },
		{ open = "`", close = "`" },
		{ open = "(", close = ")" },
		{ open = "[", close = "]" },
		{ open = "{", close = "}" },
		{ open = "<", close = ">" },
	},
	ignore_beginning = true, -- if the cursor is at the beginning of a filled element it will rather tab out than shift the content
	exclude = {} -- tabout will ignore these filetypes
}


tabout.setup(config)
