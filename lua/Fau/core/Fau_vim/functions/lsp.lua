-- =============================================
-- ========== Functions: LSP
-- =============================================
local M = {}

-- function M.initialization()
--   vim.api.nvim_create_autocmd("FileType", {
--     group = "Fau_vim",
--     pattern = "*",
--     callback = function() vim.schedule(function() Fau_vim.functions.lsp.setup_by_ft() end) end,
--   })
-- end


-- TODO: After refactor LSP, need to update `SEE`
---@type vim.lsp.client.on_attach_cb
function M.on_attach(client, bufnr)
  -- Disable LSP formatting.
  -- if client.name == "clangd" then client.server_capabilities.documentFormattingProvider = false end
end


---Setup LSP server
---@param server string
---@param opts? table
function M.setup_server(server, opts)
  opts = opts or {}
  opts = vim.tbl_deep_extend("force", { on_attach = M.on_attach }, opts)

  if server == "pylance" then opts.before_init = function(_, config) config.settings.python.pythonPath = vim.fn.exepath("python3") end end

  -- load custom settings
  local settings_ok, setting_opts = pcall(require, "Fau.core.lsp.settings." .. server)
  if settings_ok then opts = vim.tbl_deep_extend("force", opts, setting_opts) end

  -- setup LSP
  vim.lsp.config(server, opts)
  vim.lsp.enable(server, true)
end


---Implement set clients according to filetype (In Fau_vim)
---@param filetype string? filetype
function M.setup_by_ft(filetype)
  if vim.bo.buftype ~= "" then return end  -- Not a regular buffer.

  filetype = filetype or vim.bo.filetype
  if Fau_vim.lsp.configured_ft[filetype] then return end  -- Configured
  Fau_vim.lsp.configured_ft[filetype] = true

  -- Ensure servers installed.
  if Fau_vim.functions.lsp.ensure_installed(filetype) then
    -- Set configured_ft to false for restarting LSP.
    Fau_vim.lsp.configured_ft[filetype] = false
  end

  -- Get servers for specific filetype.
  local servers = require("mason-lspconfig").get_available_servers({ filetype = filetype })

  -- Setup
  local available_servers = require("mason-lspconfig").get_installed_servers()
  -- Config LS for current filetype.
  for _, server in pairs(servers) do if vim.tbl_contains(available_servers, server) then M.setup_server(server) end end
end


function M.restart_lsp()
  -- TODO: Restart LSP servers for current buffer.
  -- -- LSP is not configured.
  -- local filetype = vim.bo.filetype
  -- if Fau_vim.lsp.configured_ft[filetype] ~= true then  -- NOTE: Not configured might false|nil.
  --   Fau_vim.notify("Starting LSP server for " .. filetype .. "...")
  --   Fau_vim.functions.lsp.setup_by_ft(filetype)
  --   return
  -- end
  --
  -- local client_list = vim.lsp.get_clients({ bufnr=0 })
  -- for _, client in ipairs(client_list) do
  --   if client.name ~= "copilot" then vim.api.nvim_command("LspRestart " .. client.id) end
  -- end
end


---Auto install packages for specific filetype.
---@param filetype string?
---@return boolean flag whether installed packages
function M.ensure_installed(filetype)
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


return M
