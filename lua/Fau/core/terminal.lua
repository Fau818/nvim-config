-- =============================================
-- ========== Plugin Loading
-- =============================================
local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then Fau_vim.load_plugin_error("toggleterm") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	size = function(term)
		if term.direction == "horizontal" then return 10
		elseif term.direction == "vertical" then return vim.o.columns * 0.3
		end
	end,
	open_mapping = [[<C-t>]],

	hide_numbers = true, -- hide the number column in toggleterm buffers

	shade_terminals = false,
	shading_factor = 5, -- the degree by which to darken to terminal color

	start_in_insert = true,

	insert_mappings = true,   -- whether or not the open mapping applies in insert mode
	terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals

	direction = "float", -- string, values: vertical | horizontal | tab | float

	persist_mode = true,  -- if set to true (default) the previous terminal mode will be remembered
	persist_size = false, -- if set tot true, the previous terminal window size will be remembered (for horizontal and vertical)

	close_on_exit = true, -- close the terminal window when the process exits

	shell = vim.o.shell, -- change the default shell

	auto_scroll = true, -- automatically scroll to the bottom on terminal output

	float_opts = {
		border = "curved", -- values: single | double | shadow | curved | none
		winblend = 0,  -- keep this equal 0 if use transparent theme
	},

	on_open = function() vim.cmd("startinsert!") end,

	winbar = {
		enabled = false,
	},

	highlights = {
		Normal      = { link = "Normal", },
		NormalFloat = { link = "NormalFloat", },
		FloatBorder = { link = "FloatBorder" },
	},
}


toggleterm.setup(config)



-- =============================================
-- ========== Custom Terminal
-- =============================================
local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	count = 101,
	direction = "float",
	float_opts = {
		border = "none",
		height = 888888,
		width = 888888
	},
	on_open = function() vim.cmd("startinsert!") end,
})

local btop = Terminal:new({
	cmd = "btop",
	count = 102,
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "none",
		height = 888888,
		width = 888888
	},
	on_open = function() vim.cmd("startinsert!") end,
})

local float = Terminal:new({
	count = 1,
	dir = "git_dir",
	direction = "float",
	float_opts = {
		border = "none",
		winblend = 0,
		height = 888888,
		width = 888888
	},
	on_open = function() vim.cmd("startinsert!") end,
})

local horizontal = Terminal:new({
	count = 2,
	dir = "git_dir",
	direction = "horizontal",
	on_open = function() vim.cmd("startinsert!") end,
})

local vertical = Terminal:new({
	count = 3,
	dir = "git_dir",
	direction = "vertical",
	on_open = function() vim.cmd("startinsert!") end,
})

Fau_vim.functions.terminal = {
	lazygit    = function() lazygit:toggle()    end,
	btop       = function() btop:toggle()       end,
	float      = function() float:toggle()      end,
	horizontal = function() horizontal:toggle() end,
	vertical   = function() vertical:toggle()   end,
}
