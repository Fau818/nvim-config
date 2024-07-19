require("Fau.configs.ui.noice.config")
require("Fau.configs.ui.noice.keymaps")



-- ==================== Autocmd ====================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "noice",
  group = "Fau_vim",
  desc = "Disable `K` to show hover document keymaps in `noice`.",
  callback = function() vim.b.markdown_keys = true end,
})
