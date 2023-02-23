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
-- ========== Fau_vim
-- =============================================
-- Group Initialization
vim.api.nvim_create_augroup("Fau_vim", { clear = true })


-- -----------------------------------
-- -------- FileType
-- -----------------------------------
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Fix keymap in qf filetype.",
  pattern = "qf",
  callback = function() vim.keymap.set("n", "<CR>", "<CR>", { silent=true, buffer=true }) end
})

vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Adjust highlight for gitcommit filetype.",
  pattern = "gitcommit",
  callback = function()
    -- TODO: With Lua code, and only affect on gitcommit filetype.
    vim.cmd [[
      autocmd FileType gitcommit highlight Comment gui=none
      autocmd FileType gitcommit highlight Title gui=none
      autocmd FileType gitcommit highlight @keyword gui=italic
      autocmd FileType gitcommit highlight @punctuation.delimiter gui=bold
      autocmd FileType gitcommit highlight @parameter gui=bold
    ]]
  end
})


-- -----------------------------------
-- -------- Auto LSP
-- -----------------------------------
vim.api.nvim_create_autocmd("User", {
  group = "Fau_vim",
  desc = "Automatically set LSP by filetype initialization.",
  pattern = "AutoLsp",
  callback = Fau_vim.functions.lsp.initialization,
})


-- -------------------------------------------
-- -------- Auto Trim Blank Lines and Spaces
-- -------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "Fau_vim",
  desc = "Trim blank lines and spaces before buffer written.",
  pattern = "*",
  callback = function() Fau_vim.functions.format.remove_blank_lines_and_spaces() end,
})


-- -----------------------------------
-- -------- Keep Indentation
-- -----------------------------------
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Tabstop will be reset to 2 if tabstop >= 8.",
  pattern = "tabstop",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = 2 end end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Lock shiftwidth to 0",
  pattern = "shiftwidth",
  callback = function() vim.bo.shiftwidth = 0 end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Lock softtabstop to -1",
  pattern = "softtabstop",
  callback = function() vim.bo.softtabstop = -1 end,
})


-- -----------------------------------
-- -------- Open Dir by nvim-tree
-- -----------------------------------
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
  pattern = "*",
  callback = open_nvim_tree
})


-- -----------------------------------
-- -------- indentscope for python [TEST]
-- -----------------------------------
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Config indentscope plugin for python.",
  pattern = "python",
  callback = function()
    vim.b.miniindentscope_config = { options = { border = "top" } }
  end
})
