-- =============================================
-- ========== Plugin Loading
-- =============================================
local null_ls = Fau_vim.load_plugin("null-ls")
if null_ls == nil then return end



-- =============================================
-- ========== Initialization
-- =============================================
-- local h = require("null-ls.helpers")
-- local methods = require("null-ls.methods")
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover
local completion = null_ls.builtins.completion



-- =============================================
-- ========== Configuration
-- =============================================
null_ls.setup({
	sources = {
		-- formatting.stylua.with({
		-- 	extra_args = { "--config-path", vim.fn.expand(Fau_vim.config_path .. "/configuration/stylua.toml") },
		-- }),

		-- formatting.lua_format.with({
		-- 	extra_args = { "--config", vim.fn.expand("~/.config/nvim/configuration/.lua-format") }
		-- }),

		-- -----------------------------------
		-- -------- Python
		-- -----------------------------------
		null_ls.builtins.diagnostics.flake8.with({
			extra_args = { "--config", Fau_vim.config_path .. "/configuration/tox.ini" }
		}),
		null_ls.builtins.diagnostics.pydocstyle.with({
			extra_args = { "--config", Fau_vim.config_path .. "/configuration/tox.ini" }
		}),

		-- null_ls.builtins.diagnostics.djlint.with({
		-- 	filetypes = { "django", "jinja.html", "htmldjango", "html" }
		-- })
		null_ls.builtins.diagnostics.curlylint.with({
			filetypes = { "jinja.html", "htmldjango", "html" }
		}),
		-- null_ls.builtins.diagnostics.mypy,
		-- null_ls.builtins.diagnostics.vulture,

		null_ls.builtins.formatting.black,
	},
})
