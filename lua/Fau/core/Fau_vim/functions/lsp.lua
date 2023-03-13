return {
  initialization = function()
    vim.api.nvim_create_autocmd({ "BufReadPost", "VimEnter" }, {
      group = "Fau_vim",
      desc = "Auto Setting LSP Initialization.",
      pattern = "*",
      callback = Fau_vim.functions.lsp.set_client_by_ft,
    })
  end,


  set_client_by_ft = function() Fau_vim.notify("Called an uninitialized function.") end,  -- Implement in lspconfig.lua file.
}
