vim.opt.foldcolumn     = "auto"
vim.opt.foldlevel      = 999
vim.opt.foldlevelstart = 999
vim.opt.foldenable     = true
vim.opt.fillchars:append([[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]])

-- TEST: Disabled on July 19, 2024
-- -- For saving the fold status
-- vim.cmd [[
--   augroup remember_folds
--     autocmd BufWinLeave *.* mkview
--     autocmd BufWinEnter *.* silent! loadview
--   augroup END
-- ]]
