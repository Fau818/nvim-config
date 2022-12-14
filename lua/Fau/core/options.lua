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

	showtabline = 1, -- tab line config
	cmdheight = 1,   -- commandline height
	pumheight = 8,   -- popup menu height

	scrolloff = 10,     -- minimal number of lines to keep above and below the cursor
	sidescrolloff = 15, -- minimal number of columns to keep left and right the cursor

	hlsearch = true,   -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	smartcase = true,  -- smart case

	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window

	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	updatetime = 250,

	fileencoding = "utf-8", -- the encoding written to a file
	smartindent = true,     -- make indent smart
	tabstop = 2,            -- insert x spaces for a tab
	shiftwidth = 2,         -- the number of spaces inserted for each indentation
	softtabstop = 2,        -- set how many spaces will convert to a tab [expandtab=true]
	expandtab = false,      -- convert tabs to spaces

	linebreak = true, -- line break after an entire word

	mousemoveevent = true, -- for bufferline hover events
}


for k, v in pairs(options) do vim.opt[k] = v end
