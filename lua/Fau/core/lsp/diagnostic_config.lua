-- =============================================
-- ========== Configuration
-- =============================================
-- setting icons
local signs = {
	{ name = "DiagnosticSignError", text = Fau_vim.icons.diagnostics.BoldError },
	{ name = "DiagnosticSignWarn",  text = Fau_vim.icons.diagnostics.BoldWarning },
	{ name = "DiagnosticSignHint",  text = Fau_vim.icons.diagnostics.BoldHint },
	{ name = "DiagnosticSignInfo",  text = Fau_vim.icons.diagnostics.BoldInformation },
}
for _, sign in ipairs(signs) do vim.fn.sign_define(sign.name, { texthl = sign.name, numhl = sign.name, text = sign.text }) end


-- setting diagnostic config
local config = {
	-- virtual_text = { prefix="●" },
	virtual_text = false,
	signs = true,

	underline = true,
	update_in_insert = true,

	severity_sort = true,
	float = {
		focusable = true,
		border = "rounded",

		scope = "line", -- values: cursor|line|buffer
		source = true,  -- values: boolean|if_many

		header = "",
		prefix = "",

		---@param diagnostic Diagnostic
		---@return string Diagnostic message
		format = function(diagnostic)  -- for show the error code
			---@diagnostic disable-next-line: undefined-field
			local code = diagnostic.code or (diagnostic.user_data and diagnostic.user_data.lsp.code)
			if code then return string.format("%s [%s]", diagnostic.message, code) end
			return diagnostic.message
		end,
	},

}
vim.diagnostic.config(config)


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
