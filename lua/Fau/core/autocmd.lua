-- =============================================
-- ========== Baisc
-- =============================================
-- let `-` be a keyword
vim.cmd [[set iskeyword+=-]]

-- highlight the yank area
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{}]]

-- keep cursor on last closed position when enter a opened file
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]



-- =============================================
-- ========== FileType
-- =============================================
vim.cmd [[ augroup Fau_vim
	autocmd FileType lua    setlocal smartindent tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
	autocmd FileType python setlocal smartindent tabstop=4 shiftwidth=4 softtabstop=4 expandtab
	autocmd FileType c      setlocal smartindent tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
	autocmd FileType cpp    setlocal smartindent tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
	autocmd FileType json   setlocal smartindent tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
augroup END ]]



-- =============================================
-- ========== Auto LSP
-- =============================================
Fau_vim.start = function()
	vim.cmd [[ augroup Fau_vim
		autocmd BufReadPost * lua Fau_vim.set_client_by_ft()
	augroup END ]]
	Fau_vim.set_client_by_ft()
end


vim.cmd [[ augroup Fau_vim
	autocmd VimEnter * lua Fau_vim.start()
augroup END ]]
