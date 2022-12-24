-- =============================================
-- ========== Plugin Loading
-- =============================================
local neodev = Fau_vim.load_plugin("neodev")
if neodev == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	library = {
		enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
		runtime = true, -- runtime path
		types = true,   -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others [nice!]
		plugins = true, -- installed opt or start plugins in packpath
		-- plugins = { "cmp-nvim-lsp", "LuaSnip", "nvim-cmp", "nvim-lspconfig", "nvim-treesitter", "vim-illuminate", "which-key.nvim", "null-ls.nvim" },
	},
	setup_jsonls = false, -- configures jsonls to provide completion for project specific .luarc.json files
	-- override = function(root_dir, library)
	-- 	library.enabled = true
	-- 	library.plugins = true
	-- end,
	lspconfig = true, -- if true, Neodev will automatically setup your lua-language-server
}


neodev.setup(config)

-- [TODO: A bug here, it can't access neovim config path. (which say it can't prompt the file name)]
