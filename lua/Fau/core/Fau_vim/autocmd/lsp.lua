--- Automatically set LSP by filetype initialization.
-- TODO: Integrate to `lspconfig.lua` file or remove it.
vim.api.nvim_create_autocmd("User", {
  group = "Fau_vim",
  desc = "Automatically set LSP by filetype initialization.",
  pattern = "AutoLsp",
  callback = Fau_vim.functions.lsp.initialization,
})
