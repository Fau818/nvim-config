-- =============================================
-- ========== Functions: LSP
-- =============================================
return {
  initialization = function()
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
      group = "Fau_vim",
      desc = "Auto Setting LSP Initialization.",
      pattern = "*",
      callback = function() Fau_vim.functions.lsp.set_client_by_ft() end,
    })
  end,


  set_client_by_ft = function() Fau_vim.notify("Called an uninitialized function `set_client_by_ft`.") end,  -- Implement in lspconfig.lua file.


  restart_lsp = function()
    -- LSP is not configured.
    local filetype = vim.bo.filetype
    if Fau_vim.lsp.configured_ft[filetype] ~= true then  -- NOTE: Not configured might false|nil.
      Fau_vim.notify("Starting LSP server for " .. filetype .. "...")
      Fau_vim.functions.lsp.set_client_by_ft(filetype)
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

    local package_list = Fau_vim.lsp.packages[filetype]
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
