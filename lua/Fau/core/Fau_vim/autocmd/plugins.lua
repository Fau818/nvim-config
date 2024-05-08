-- TODO: Move to plugins.
-- -----------------------------------
-- -------- NvimTree
-- -----------------------------------
--- Open nvim-tree when open a directory.
vim.api.nvim_create_autocmd("VimEnter", {
  group = "Fau_vim",
  desc = "Open nvim-tree when open a directory.",
  pattern = "*",
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if not directory then return end

    vim.cmd.enew()
    -- NOTE: Use `buffer delete` instead of `buffer wipe`. (SEE: https://github.com/folke/lazy.nvim/issues/1192)
    vim.cmd.bd(data.buf)
    vim.cmd.cd(data.file)
    require("nvim-tree.api").tree.open()
  end,
})


-- -----------------------------------
-- -------- Noice
-- -----------------------------------
--- Disable `K` to show hover document keymaps in `noice`.
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Disable `K` to show hover document keymaps in `noice`.",
  pattern = "noice",
  callback = function() vim.b.markdown_keys = true end,
})
