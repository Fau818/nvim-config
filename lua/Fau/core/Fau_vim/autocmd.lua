-- =============================================
-- ========== Baisc
-- =============================================
-- let `-` be a keyword
vim.cmd [[ set iskeyword+=- ]]
-- highlight the yank area
vim.cmd [[ au TextYankPost * silent! lua vim.highlight.on_yank{} ]]
-- keep cursor on last closed position when enter an opened file
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]



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
-- ========== Keep Indentation
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



-- =============================================
-- ========== Lock Options
-- =============================================
vim.cmd [[
  autocmd OptionSet softtabstop setlocal sts=-1
  autocmd OptionSet shiftwidth setlocal sw=0
]]



-- =============================================
-- ========== nvim-tree [TEST]
-- =============================================
local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then return end

  vim.cmd.enew()
  vim.cmd.bw(data.buf)
  vim.cmd.cd(data.file)
  require("nvim-tree.api").tree.open()
end


vim.api.nvim_create_autocmd("VimEnter", {
  group = "Fau_vim",
  desc = "Open nvim-tree when open a directory.",
  callback = open_nvim_tree
})
