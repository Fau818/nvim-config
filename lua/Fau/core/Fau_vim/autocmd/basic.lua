-- =============================================
-- ========== Baisc
-- =============================================
-- -----------------------------------
-- -------- General
-- -----------------------------------
--- Let `-` and `$` be keywords.
vim.opt.iskeyword:append({ "-", "$", "#" })

--- Highlight the yank section.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "Fau_vim",
  desc = "Highlight the yank section.",
  pattern = { "*" },
  callback = function() vim.highlight.on_yank() end
})

--- Keep cursor on the last closed position when enter a buffer.
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

--- Use diagonal lines in place of deleted lines in diff mode.
vim.opt.fillchars:append { diff = "╱" }


-- -----------------------------------
-- -------- Auto Trim
-- -----------------------------------
--- Trim blank lines and spaces before writting buffer to file.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "Fau_vim",
  desc = "Trim blank lines and spaces before writting buffer to file.",
  pattern = "*",
  callback = function() Fau_vim.functions.format.remove_blank_lines_and_spaces() end,
})


-- -----------------------------------
-- -------- Indentation
-- -----------------------------------
--- Fix incorrect indent width.
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Tabstop will be reset to 2 if tabstop >= 8.",
  pattern = "tabstop",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = 2 end end,
})

--- Lock `shiftwidth` to 0.
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Lock shiftwidth to 0",
  pattern = "shiftwidth",
  callback = function() vim.bo.shiftwidth = 0 end,
})

--- Lock `softtabstop` to -1.
vim.api.nvim_create_autocmd("OptionSet", {
  group = "Fau_vim",
  desc = "Lock softtabstop to -1",
  pattern = "softtabstop",
  callback = function() vim.bo.softtabstop = -1 end,
})


-- -----------------------------------
-- -------- Large File
-- -----------------------------------
-- TODO: Finish this.
vim.api.nvim_create_autocmd("BufReadPre", {
  group = "Fau_vim",
  desc = "Disable some features in large file.",
  pattern = "*.*",
  callback = function()
    if not Fau_vim.functions.utils.is_large_file() then return end

    ---Large file!!
    vim.api.nvim_command("syntax off")
    vim.opt_local.filetype = ""

    -- Disable fold
    local ufo_ok, ufo = pcall(require, "ufo")
    if ufo_ok then ufo.detach() end
    vim.opt_local.foldenable = false
    vim.opt_local.foldcolumn = "0"
    vim.opt_local.foldmethod = "manual"

    -- Disable IndentLine
    local indent_blankline_ok, indent_blankline = pcall(require, "ibl")
    if indent_blankline_ok then indent_blankline.setup_buffer(0, { enabled = false }) end

    -- Disable mini
    vim.b.minitrailspace_disable = true
    vim.b.miniindentscope_disable = true

    -- Disable edit
    vim.opt_local.undofile   = false
    vim.opt_local.undolevels = -1
    vim.opt_local.undoreload = 0
    vim.opt_local.modifiable = false

    -- extra ...
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = false
    vim.opt_local.mousemoveevent = false
  end,
})
