-- =============================================
-- ========== Configuration
-- =============================================
local mlspconfig = require("mason-lspconfig")
require("lspconfig.ui.windows").default_options.border = "double"


-- -----------------------------------
-- -------- Config Servers
-- -----------------------------------
---@type vim.lsp.client.on_attach_cb
local function _on_attach(client, bufnr)
  -- Disable LSP formatting.
  -- if client.name == "clangd" then client.server_capabilities.documentFormattingProvider = false end

  -- For highlight support.
  local illuminate = require("illuminate")
  if illuminate then illuminate.on_attach(client) end

  -- For inlayhint support.
  if vim.fn.has("nvim-0.10") == 1 then vim.lsp.inlay_hint.enable(true) end
end


local function setup_servers(servers)
  servers = type(servers) == "string" and { servers } or servers

  local available_servers = mlspconfig.get_installed_servers()
  -- Config LS for current filetype.
  for _, server in pairs(servers) do
    if vim.fn.executable(server) == 1 or vim.tbl_contains(available_servers, server) then
      Fau_vim.functions.lsp.setup_server(server, { on_attach = _on_attach })
    end
  end
end


---Implement set clients according to filetype (In Fau_vim)
---@param filetype string? filetype
Fau_vim.functions.lsp.setup_by_ft = function(filetype)
  if Fau_vim.functions.utils.is_large_file() then return end

  filetype = filetype or vim.bo.filetype
  if Fau_vim.lsp.configured_ft[filetype] then return end  -- Configured
  Fau_vim.lsp.configured_ft[filetype] = true

  -- TODO: Auto start if LSP is installed.
  -- Ensure servers installed.
  if Fau_vim.functions.lsp.ensure_installed(filetype) then
    -- Set configured_ft to false for restarting LSP.
    Fau_vim.lsp.configured_ft[filetype] = false
  end

  -- Get servers for specific filetype.
  local clients = mlspconfig.get_available_servers({ filetype=filetype })
  -- HACK: Special for pylance
  if filetype == "python" and vim.fn.executable("pylance") == 1 then table.insert(clients, "pylance") end

  -- Setup
  setup_servers(clients)
end



-- =============================================
-- ========== Auto LSP
-- =============================================
Fau_vim.functions.lsp.initialization()
