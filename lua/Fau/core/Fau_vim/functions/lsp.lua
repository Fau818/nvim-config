return {
	initialize_lsp = function()
		vim.cmd [[
			augroup Fau_vim
				autocmd BufReadPost * lua Fau_vim.functions.lsp.set_client_by_ft()
			augroup END
		]]
		Fau_vim.functions.lsp.set_client_by_ft()
	end,


	set_client_by_ft = function() end,  -- Implement in lspconfig.lua file.
}
