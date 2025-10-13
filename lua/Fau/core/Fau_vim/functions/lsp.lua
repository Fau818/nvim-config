-- =============================================
-- ========== Functions: LSP
-- =============================================
return {
  initialization = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = "Fau_vim",
      pattern = "*",
      callback = function() vim.schedule(function() Fau_vim.functions.lsp.setup_by_ft() end) end,
    })
  end,


  ---Setup LSP server
  ---@param server string
  ---@param opts? table
  setup_server = function(server, opts)
    opts = opts or {}

    if server == "pylance" then opts.before_init = function(_, config) config.settings.python.pythonPath = vim.fn.exepath("python3") end end

    -- load custom settings
    local settings_ok, setting_opts = pcall(require, "Fau.core.lsp.settings." .. server)
    if settings_ok then opts = vim.tbl_deep_extend("force", opts, setting_opts) end

    -- setup LSP
    vim.lsp.config(server, opts)
    vim.lsp.enable(server, true)
  end,


  setup_by_ft = function() Fau_vim.notify("Called an uninitialized function `setup_lsp_by_ft`.") end,  -- Implement in lspconfig.lua file.


  restart_lsp = function()
    -- LSP is not configured.
    local filetype = vim.bo.filetype
    if Fau_vim.lsp.configured_ft[filetype] ~= true then  -- NOTE: Not configured might false|nil.
      Fau_vim.notify("Starting LSP server for " .. filetype .. "...")
      Fau_vim.functions.lsp.setup_by_ft(filetype)
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
