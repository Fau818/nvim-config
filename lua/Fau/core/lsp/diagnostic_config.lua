-- =============================================
-- ========== Configuration
-- =============================================
-- setting icons
local signs = {
	{ name = "DiagnosticSignError", text = Fau_vim.diagnostics.BoldError },
	{ name = "DiagnosticSignWarn",  text = Fau_vim.diagnostics.BoldWarning },
	{ name = "DiagnosticSignHint",  text = Fau_vim.diagnostics.BoldHint },
	{ name = "DiagnosticSignInfo",  text = Fau_vim.diagnostics.BoldInformation },
}
for _, sign in ipairs(signs) do vim.fn.sign_define(sign.name, { texthl = sign.name, numhl = sign.name, text = sign.text }) end


-- setting diagnostic config
local config = {
	-- virtual_text = { prefix="■" },
	virtual_text = false,
	signs = true,
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		severity_sort = true,
		focusable = true,
		border = "single",
		source = true,  -- use "if_many" to set only multiple diagnostic sources to show the diagnostic source.
	},
}
vim.diagnostic.config(config)


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
