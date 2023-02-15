-- disable the default file tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



local options = {
	undofile = true,     -- enable persistent undo
	swapfile = false,    -- create a swapfile
	backup = false,      -- create a backup file
	writebackup = false, -- create a backup file when written

	termguicolors = true,      -- set term gui colors
	cursorline = true,         -- highlight the current line
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard

	number = true,         -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 2,       -- set number column width to 2 (default: 4)
	signcolumn = "yes",    -- always show the sign column

	showtabline = 1,  -- tab line config
	cmdheight = 1,    -- commandline height
	pumheight = 8,    -- popup menu height
	showmode = false, -- do not show current mode in bottom-left

	scrolloff = 10,     -- minimal number of lines to keep above and below the cursor
	sidescrolloff = 15, -- minimal number of columns to keep left and right the cursor

	hlsearch = true,   -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	smartcase = true,  -- smart case

	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window

	timeoutlen = 225, -- time to wait for a mapped sequence to complete (in milliseconds)
	updatetime = 250,

	fileencoding = "utf-8", -- the encoding written to a file
	smartindent = true,     -- smart autoindenting when starting a new line.
	tabstop = 2,            -- the width of a tab
	softtabstop = -1,       -- how many spaces will be inserted when enter <tab> (if negative number, the shiftwidth value is used)
	shiftwidth = 0,         -- the number of spaces inserted for each indentation (if zero, the tabstop value is used)
	expandtab = true,       -- convert tab to spaces (indent_type: space if true else tab)

	wrap = false,
	linebreak = true, -- line break after an entire word

	mousemoveevent = true, -- for bufferline hover events
}


for k, v in pairs(options) do vim.opt[k] = v end
