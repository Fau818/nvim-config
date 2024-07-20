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


-- -----------------------------------
-- -------- Large File
-- -----------------------------------
-- TODO: Finish this.
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*.*",
  group = "Fau_vim",
  desc = "Disable some features in large file.",
  callback = function()
    if not Fau_vim.functions.utils.is_large_file() then return end

    -- Large file!!
    -- vim.api.nvim_command("syntax off")
    -- vim.api.nvim_command("filetype off")
    -- vim.opt_local.syntax   = "off"
    -- vim.opt_local.filetype = "none"

    -- Disable fold
    vim.opt_local.foldenable = false

    -- Disable mini
    vim.b.minitrailspace_disable  = true
    vim.b.miniindentscope_disable = true
    vim.b.minianimate_disable     = true

    -- Disable undo
    vim.opt_local.undofile   = false
    -- vim.opt_local.undolevels = -1
    -- vim.opt_local.undoreload = 0
    -- vim.opt_local.modifiable = false

    -- HACK: Disable scrollbar (satellite)
    pcall(require, "satellite")
    vim.api.nvim_command("SatelliteDisable")

    -- Extra ...
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = false
    vim.opt_local.mousemoveevent = false
  end,
})
