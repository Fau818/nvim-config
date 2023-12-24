return {
  initialization = function()
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      group = "Fau_vim",
      desc = "Auto Setting LSP Initialization.",
      pattern = "*",
      callback = Fau_vim.functions.lsp.set_client_by_ft,
    })
  end,


  set_client_by_ft = function() Fau_vim.notify("Called an uninitialized function.") end,  -- Implement in lspconfig.lua file.


  restart_lsp = function()
    -- LSP is not configured.
    if Fau_vim.configured_ft[vim.bo.filetype] == false then
      Fau_vim.functions.lsp.set_client_by_ft()
      return
    end

    local client_list = vim.lsp.get_clients({ bufnr=0 })
    for _, client in ipairs(client_list) do
      if client.name ~= "null-ls" and client.name ~= "copilot" then vim.api.nvim_command("LspRestart " .. client.id) end
    end
  end,


  ---Auto install packages for specific filetype.
  ---@param filetype string?
  ---@return boolean flag whether installed packages
  ensure_installed = function(filetype)
    filetype = filetype or vim.bo.filetype

    local package_list = Fau_vim.packages[filetype]
    if package_list == nil then return false end

    local flag = false
    for _, package_name in ipairs(package_list) do
      if not require("mason-registry").is_installed(package_name) then
        flag = true
        require("mason.api.command").MasonInstall({ package_name })
      end
    end

    return flag
  end
}
