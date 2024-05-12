-- =============================================
-- ========== Plugin Loading
-- =============================================
-- -----------------------------------
-- -------- Necessary
-- -----------------------------------
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_ok then Fau_vim.load_plugin_error("lspconfig") return end

local mlspconfig_ok, mlspconfig = pcall(require, "mason-lspconfig")
if not mlspconfig_ok then Fau_vim.load_plugin_error("mason-lspconfig") return end


-- -----------------------------------
-- -------- Unnecessary
-- -----------------------------------
local illuminate_ok, illuminate = pcall(require, "illuminate")
if not illuminate_ok then illuminate = nil end

local inlayhints_ok, inlayhints = pcall(require, "lsp-inlayhints")
if not inlayhints_ok then inlayhints = nil end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then cmp_nvim_lsp = nil end


-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Change LspInfo Window Border
-- -----------------------------------
require('lspconfig.ui.windows').default_options.border = "double"


-- -----------------------------------
-- -------- Config Servers
-- -----------------------------------
local function is_available(client_name)
  local available_servers = mlspconfig.get_installed_servers()
  for _, server_name in pairs(available_servers) do
    if server_name == client_name then return true end
  end

  if vim.fn.executable(client_name) == 1 then return true end
  return false
end


-- Attachments
local function server_attach(client, bufnr)
  -- disable lsp formatting
  -- if client.name == "clangd" then client.server_capabilities.documentFormattingProvider = false end

  -- for highlight support
  if illuminate then illuminate.on_attach(client) end

  -- for inlayhints support
  if vim.fn.has("nvim-0.10") == 1 then vim.lsp.inlay_hint.enable(true)
  elseif inlayhints then inlayhints.on_attach(client, bufnr, false)
  end
end


-- Setup servers
local function setup_server(server)
  local opts = {
    capabilities = cmp_nvim_lsp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities(),
    on_attach = server_attach,
  }

  if server == "pylance" then opts.before_init = function(_, config) config.settings.python.pythonPath = vim.fn.exepath("python3") end end

  -- load custom settings
  local settings_ok, setting_opts = pcall(require, "Fau.core.lsp.settings." .. server)
  if settings_ok then opts = vim.tbl_deep_extend("force", opts, setting_opts) end

  -- setup LSP
  lspconfig[server].setup(opts)
end


--- Implement set clients according to filetype (In Fau_vim)
---@param filetype string? filetype
Fau_vim.functions.lsp.set_client_by_ft = function(filetype)
  if Fau_vim.functions.utils.is_large_file() then return end
  filetype = filetype or vim.bo.filetype

  if Fau_vim.lsp.configured_ft[filetype] then return end -- configured
  Fau_vim.lsp.configured_ft[filetype] = true

  -- Ensure servers installed.
  if Fau_vim.functions.lsp.ensure_installed(filetype) then
    -- Set configured_ft to false for restarting LSP.
    Fau_vim.lsp.configured_ft[filetype] = false
  end

  -- Get servers for specific filetype.
  local clients = mlspconfig.get_available_servers({ filetype=filetype })
  -- HACK: Special for pylance
  if filetype == "python" and vim.fn.executable("pylance") == 1 then table.insert(clients, "pylance") end

  -- Config LS for current filetype.
  for _, client in pairs(clients) do if is_available(client) then setup_server(client) end end

  vim.api.nvim_command("LspStart")
end



-- =============================================
-- ========== Auto LSP
-- =============================================
Fau_vim.functions.lsp.initialization()
