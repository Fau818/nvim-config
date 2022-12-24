-- =============================================
-- ========== Plugin Loading
-- =============================================
local treesitter = Fau_vim.load_plugin("nvim-treesitter.configs")
if treesitter == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	-- A list of parser names, or "all"
	ensure_installed = { "c", "lua", "python" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = {},

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = {}, -- or a function

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	indent = { enable = true },

	-- nvim-ts-context-commentstring plugin
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	}
}


treesitter.setup(config)
