-- =============================================
-- ========== Baisc
-- =============================================
-- -----------------------------------
-- -------- General
-- -----------------------------------
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  group = "Fau_vim",
  desc = "Highlight the yank section.",
  callback = function() vim.highlight.on_yank() end
})

-- Keep cursor on the last closed position when enter a buffer.
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]


-- -----------------------------------
-- -------- Auto Trim
-- -----------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = "Fau_vim",
  desc = "Trim blank lines and spaces before writing buffer to file.",
  callback = function() Fau_vim.functions.format.remove_blank_lines_and_spaces() end,
})


-- -----------------------------------
-- -------- Indentation
-- -----------------------------------
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "tabstop",
  group = "Fau_vim",
  desc = "`tabstop` will be reset to 2 if tabstop >= 8.",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = 2 end end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "shiftwidth",
  group = "Fau_vim",
  desc = "Lock `shiftwidth` to 0",
  callback = function() vim.bo.shiftwidth = 0 end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "softtabstop",
  group = "Fau_vim",
  desc = "Lock `softtabstop` to -1",
  callback = function() vim.bo.softtabstop = -1 end,
})
