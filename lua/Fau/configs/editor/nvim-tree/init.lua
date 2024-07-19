require("Fau.configs.editor.nvim-tree.config")



-- ==================== Autocmd ====================
vim.api.nvim_create_autocmd("VimEnter", {
  group = "Fau_vim",
  desc = "Show nvim-tree when opening a directory with Neovim.",
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
