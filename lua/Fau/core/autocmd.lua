-- =============================================
-- ========== Baisc
-- =============================================
-- let `-` be a keyword
vim.cmd [[set iskeyword+=-]]
-- highlight the yank area
vim.cmd [[au TextYankPost * silent! lua vim.highlight.on_yank{}]]
-- keep cursor on last closed position when enter an opened file
vim.cmd [[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]



-- =============================================
-- ========== FileType
-- =============================================
vim.cmd [[
  augroup Fau_vim
    " autocmd FileType * lua Fau_vim.functions.indent.set_indent()

    autocmd FileType qf nnoremap <buffer><CR> <CR>

    autocmd FileType gitcommit highlight Comment gui=none
    autocmd FileType gitcommit highlight Title gui=none
    autocmd FileType gitcommit highlight @keyword gui=italic
    autocmd FileType gitcommit highlight @punctuation.delimiter gui=bold
    autocmd FileType gitcommit highlight @parameter gui=bold
  augroup END
]]



-- =============================================
-- ========== Auto LSP
-- =============================================
vim.cmd [[
  augroup Fau_vim
    autocmd VimEnter * lua Fau_vim.functions.lsp.initialize_lsp()
  augroup END
]]



-- =============================================
-- ========== Auto Trim Blank Lines and Spaces
-- =============================================
vim.cmd [[
  augroup Fau_vim
    autocmd BufWritePre * lua Fau_vim.functions.format.remove_blank_lines_and_spaces()
  augroup END
]]



-- =============================================
-- ========== TEST
-- =============================================
Fau_vim.functions.keep_file_indent = function()
  if vim.bo.shiftwidth == 8 then
    vim.bo.tabstop    = 2
    vim.bo.shiftwidth = 0
  end
end

vim.cmd [[
  augroup Fau_vim
    autocmd BufReadPost * lua Fau_vim.functions.keep_file_indent()
  augroup END
]]
