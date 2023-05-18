-- Group Initialization
vim.api.nvim_create_augroup("Fau_vim", { clear = true })



-- =============================================
-- ========== Baisc
-- =============================================
-- let `-` be a keyword
vim.opt.iskeyword:append("-")
-- highlight the yank area
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "Fau_vim",
  desc = "Highlight the yank section.",
  pattern = { "*" },
  callback = function() vim.highlight.on_yank() end
})
-- keep cursor on last closed position when enter an opened file
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- use diagonal lines in place of deleted lines
vim.opt.fillchars:append { diff = "╱" }
-- Turn off the ftplugin
vim.api.nvim_command("filetype plugin off")



-- =============================================
-- ========== Fau_vim
-- =============================================
-- -----------------------------------
-- -------- FileType
-- -----------------------------------
--- Fix keymap in qf filetype.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Fix keymap in qf filetype.",
  pattern = "qf",
  callback = function() vim.keymap.set("n", "<CR>", "<CR>", { silent=true, buffer=true }) end
})

--- Type q to close float window.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Type q to close float window.",
  pattern = { "notify", "git" },
  callback = function() vim.keymap.set("n", "q", "<CMD>q<CR>", { silent=true, buffer=true }) end
})

--- Adjust highlight for gitcommit filetype.
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
--- Automatically set LSP by filetype initialization.
vim.api.nvim_create_autocmd("User", {
  group = "Fau_vim",
  desc = "Automatically set LSP by filetype initialization.",
  pattern = "AutoLsp",
  callback = Fau_vim.functions.lsp.initialization,
})


-- -------------------------------------------
-- -------- Auto Trim Blank Lines and Spaces
-- -------------------------------------------
--- Trim blank lines and spaces before buffer written.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "Fau_vim",
  desc = "Trim blank lines and spaces before buffer written.",
  pattern = "*",
  callback = function() Fau_vim.functions.format.remove_blank_lines_and_spaces() end,
})


-- -----------------------------------
-- -------- Keep Indentation
-- -----------------------------------
--- Tabstop will be reset to 2 if tabstop >= 8.
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Tabstop will be reset to 2 if tabstop >= 8.",
  pattern = "tabstop",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = 2 end end,
})

--- Lock shiftwidth to 0
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Lock shiftwidth to 0",
  pattern = "shiftwidth",
  callback = function() vim.bo.shiftwidth = 0 end,
})

--- Lock softtabstop to -1
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
-- -------- Disable Noice Hover Document Keymaps
-- -----------------------------------
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Config indentscope plugin for python.",
  pattern = "noice",
  callback = function() vim.b.markdown_keys = true end,
})


-- -----------------------------------
-- -------- test
-- -----------------------------------
-- Disable in the large file.
vim.api.nvim_create_autocmd("BufReadPre", {
  group = "Fau_vim",
  desc = "Disable some features in large file.",
  pattern = "*.*",
  callback = function()
    local buffer = vim.api.nvim_get_current_buf()
    if not Fau_vim.functions.utils.is_large_file(buffer) then return end

    ---Large file!!
    local illuminate_ok, illuminate = pcall(require, "illuminate.engine")
    if not illuminate_ok then illuminate = nil end
    if illuminate then illuminate.stop_buf(buffer) end

    -- Disable fold
    local ufo_ok, ufo = pcall(require, "ufo")
    if not ufo_ok then Fau_vim.notify("UFO error") end
    if ufo then ufo.detach(buffer) end
    vim.wo.foldenable = false
    vim.wo.foldcolumn = "0"

    -- Disable mini
    vim.b.minitrailspace_disable = true
    vim.b.miniindentscope_disable = true

    -- Disable edit
    vim.bo.undofile   = false
    vim.bo.modifiable = false
  end,
})
