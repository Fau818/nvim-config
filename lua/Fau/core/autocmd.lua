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
vim.cmd [[
augroup Fau_vim
	autocmd FileType lua    setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
	autocmd FileType python setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
	autocmd FileType c      setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
	autocmd FileType cpp    setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
	autocmd FileType json   setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab
augroup END
]]


vim.cmd [[
augroup Fau_vim
	autocmd FileType qf nnoremap <buffer><CR> <CR>
	autocmd FileType gitcommit highlight Comment gui=bold
augroup END
]]



-- =============================================
-- ========== Auto LSP
-- =============================================
Fau_vim.functions.initialize_vim = function()
	vim.cmd [[
		augroup Fau_vim
			autocmd BufReadPost * lua Fau_vim.functions.set_client_by_ft()
		augroup END
	]]
	Fau_vim.functions.set_client_by_ft()
end


vim.cmd [[
augroup Fau_vim
	autocmd VimEnter * lua Fau_vim.functions.initialize_vim()
augroup END
]]



-- =============================================
-- ========== Auto Trim Blank Lines and Spaces
-- =============================================
vim.cmd [[
augroup Fau_vim
	autocmd BufWritePre * lua Fau_vim.functions.remove_blank_lines_and_spaces()
augroup END
]]
