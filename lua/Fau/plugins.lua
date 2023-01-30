local fn = vim.fn


-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end



-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
]])



-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then vim.notify("packer does not work!", vim.log.error) return end



-- Have packer use a popup window
packer.init({ display = { open_fn = require("packer.util").float }, git = { clone_timeout = 180 } })


-- plugin install
return require("packer").startup(function(use)
	use "wbthomason/packer.nvim"  -- manange packer itself

	-- =============================================
	-- ======== utility
	-- =============================================
	use "nvim-lua/plenary.nvim"        -- a utility tools repo for lua
	use "nvim-lua/popup.nvim"          -- an implementation of the Popup API from vim in Neovim.
	use "kyazdani42/nvim-web-devicons" -- icons provider
	use "lewis6991/impatient.nvim"     -- speed up the start time of neovim
	use "MunifTanjim/nui.nvim"


	-- =============================================
	-- ======== colorscheme
	-- =============================================
	use "folke/tokyonight.nvim"
	use "lunarvim/darkplus.nvim"


	-- =============================================
	-- ======== surround and comment
	-- =============================================
	use "kylechui/nvim-surround"  -- surround plugin
	use "numToStr/Comment.nvim"   -- comment plugin
	use 'JoosepAlviste/nvim-ts-context-commentstring'  -- for setting the commentstring based on the cursor location in a file


	-- =============================================
	-- ======== completion and LSP
	-- =============================================
	use "hrsh7th/nvim-cmp"                    -- nvim completion core plugin
	use "hrsh7th/cmp-buffer"                  -- buffer cmp for nvim-cmp
	use "hrsh7th/cmp-path"                    -- path cmp for nvim-cmp
	use "hrsh7th/cmp-cmdline"                 -- command line cmp for nvim-cmp
	-- use "hrsh7th/cmp-nvim-lsp-signature-help" -- signature help cmp for nvim-cmp
	use "folke/neodev.nvim"                   -- lua cmp, including neovim builtin documents

	use "L3MON4D3/LuaSnip"             -- code snippets engine
	use "saadparwaiz1/cmp_luasnip"     -- support L3MON4D3/LuaSnip plugin cmp in nvim-cmp
	-- use "rafamadriz/friendly-snippets" -- snippets repository

	use "neovim/nvim-lspconfig" -- LSP support
	use "hrsh7th/cmp-nvim-lsp"  -- LSP for nvim-cmp

	use "williamboman/mason.nvim"           -- a powerful mananger for LSP, DAP, Linter and Formatter
	use "williamboman/mason-lspconfig.nvim" -- a bridge between lspconfig and mason.nvim for making things easier.

	use "jose-elias-alvarez/null-ls.nvim"  -- a powerful plugin for formatting etc

	use "lvimuser/lsp-inlayhints.nvim"  -- inlay hints support

	use "windwp/nvim-autopairs"  -- autopairs


	-- =============================================
	-- ======== fuzzy filter (Telescope)
	-- =============================================
	use "nvim-telescope/telescope.nvim"    -- a powerful fuzzy filter
	use {
		"nvim-telescope/telescope-fzf-native.nvim",  -- for speeding up the fuzzy find
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
	}
	use "xiyaowong/telescope-emoji.nvim"   -- emoji support for telescope
	use "benfowler/telescope-luasnip.nvim" -- luasnip support for telescope


	-- =============================================
	-- ======== parser
	-- =============================================
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }  -- a parser generator tool and an incremental parsing library
	use "nvim-treesitter/playground"
	-- use "nvim-treesitter/tree-sitter-query"
	use "RRethy/vim-illuminate"  -- highlight code


	-- =============================================
	-- ======== pretty UI
	-- =============================================
	use "rcarriga/nvim-notify"  -- a popup notice

	use "folke/which-key.nvim"  -- show keymap help

	use "stevearc/dressing.nvim"  -- a ui selector

	use "nvim-tree/nvim-tree.lua"   -- a file explorer tree
	use "nvim-lualine/lualine.nvim" -- bottom status line
	use "SmiteshP/nvim-navic"       -- breadcrumb
	use "akinsho/bufferline.nvim"   -- show the buffer tab
	use "famiu/bufdelete.nvim"      -- close the buffer but don't affect the layout (like vim-bbye)
	use "stevearc/aerial.nvim"      -- Symbol Outline

	use "lukas-reineke/indent-blankline.nvim" -- indent line

	use "lewis6991/gitsigns.nvim" -- show git status
	use "folke/trouble.nvim"      -- show gitsigns quicklist and LSP operations

	use "akinsho/toggleterm.nvim"  -- toggle terminal

	use "goolord/alpha-nvim"  -- start page

	use "xiyaowong/nvim-transparent"  -- transparent background

	use "folke/todo-comments.nvim" -- highlight TODO tags in comment
	use "folke/paint.nvim"         -- for highlighting params in comment
	use "NvChad/nvim-colorizer.lua"  -- show color of code


	-- =============================================
	-- ======== workspace support
	-- =============================================
	use "ahmedkhalf/project.nvim"  -- project support [better than 'telescope-project'] [support telescope]

	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup()
		end,
	})


	-- =============================================
	-- ======== better writing
	-- =============================================
	use "fedepujol/move.nvim"						 -- move lines
	use "abecodes/tabout.nvim"           -- type <TAB> could jump out of brakets
	use "echasnovski/mini.align"         -- align text

	use "windwp/nvim-ts-autotag"         -- autotag
	use "RRethy/nvim-treesitter-endwise" -- auto end

	use 'keaising/im-select.nvim'        -- auto switch input method

	use "pixelneo/vim-python-docstring"  -- auto python docstring

	use "folke/twilight.nvim"  -- focus coding
	use "folke/zen-mode.nvim"  -- zen-mode

	use "fladson/vim-kitty"  -- support highlight kitty config file


	-- =============================================
	-- ========== MISC
	-- =============================================
	use "CRAG666/code_runner.nvim" -- run code
	use "wakatime/vim-wakatime"    -- wakatime statistic


	-- =============================================
	-- ========== DAP
	-- =============================================
	if Fau_vim.dap.enable then
		use "mfussenegger/nvim-dap"
		use "rcarriga/nvim-dap-ui"
		use "theHamsta/nvim-dap-virtual-text"
	end


	-- =============================================
	-- ======== new plugins [test]
	-- =============================================
	use "folke/noice.nvim"
	use "ray-x/lsp_signature.nvim"
	-- use "ray-x/cmp-treesitter"



	-- use "Tastyep/structlog.nvim"  -- enhance nvim log

	-- quick jump
	-- phaazon/hop.nvim
	-- ggandor/lightspeed.nvim

	-- Automatically set up your configuration after cloning packer.
	-- Put this at the end after all plugins
	if packer_bootstrap then require("packer").sync() end
end)
