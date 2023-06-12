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


  restart_lsp = function()
    local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
    if not lspconfig_ok then Fau_vim.notify("Restart LSP error! Not found nvim-lspconfig plugin.", vim.log.levels.ERROR) return end

    local client_list = vim.lsp.get_active_clients({ bufnr=0 })
    for _, client in ipairs(client_list) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then
        vim.api.nvim_command("LspRestart " .. client.id)
      end
    end
  end
}
