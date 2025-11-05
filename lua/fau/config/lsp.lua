local M = {}

-- =============================================
-- ========== Fields
-- =============================================
---@type table<string, boolean> Keep track of filetypes that have been configured
M.configured_ft = {}

---@type table<string, string[]> Auto installed LSP servers for specific filetypes
M.packages = {
  sh         = { "bash-language-server" },
  docker     = { "dockerfile-language-server" },
  dockerfile = { "dockerfile-language-server" },
  go         = { "gopls" },
  html       = { "html-lsp" },
  json       = { "json-lsp" },
  jsonc      = { "json-lsp" },
  lua        = { "lua-language-server" },
  python     = { "fylance", "ruff" },
  yaml       = { "yaml-language-server" },
}



-- =============================================
-- ========== Functions
-- =============================================
---Truncate inlay hints labels to a specific length.
---@param truncate_len integer
---@return function
local function truncate_inlay_hints(truncate_len)
  local function truncate_text(text) return text:sub(1, truncate_len) .. "  " end

  return function(err, result, ctx, config)
    if not result then return end

    for _, hint in ipairs(result) do
      if type(hint.label) == "string" then
        if #hint.label > truncate_len then
          hint.label = truncate_text(hint.label)
        end
      elseif type(hint.label) == "table" then
        for _, part in ipairs(hint.label) do
          if part.value and #part.value > truncate_len then
            part.value = truncate_text(part.value)
          end
        end
      end
    end

    vim.lsp.handlers["textDocument/inlayHint"](err, result, ctx, config)
  end
end


---@type vim.lsp.client.on_attach_cb
function M.on_attach(client, bufnr)
  -- Disable LSP formatting.
  -- if client.name == "clangd" then client.server_capabilities.documentFormattingProvider = false end
  client.handlers["textDocument/inlayHint"] = truncate_inlay_hints(15)
end


---Install missing packages for specific filetype.
---@param filetype string?
function M._install_missing_packages(filetype)
  filetype = filetype or vim.bo.filetype

  -- EXIT: No packages to install.
  local package_list = M.packages[filetype]
  if package_list == nil then return true end

  -- ==================== Install Missing Packages ====================
  -- NOTE: Please make sure you have `mason.nvim` and `mason-lspconfig.nvim` installed.
  local mason_lspconfig = require("mason-lspconfig")
  local mason_registry = require("mason-registry")

  mason_registry.refresh(function()
    for _, lsp_name in ipairs(package_list) do
      -- NOTE: lsp_name and package_name may be different and confusing, so handle both.
      local package_name = mason_lspconfig.get_mappings().lspconfig_to_package[lsp_name] or lsp_name
      lsp_name = mason_lspconfig.get_mappings().package_to_lspconfig[package_name] or package_name

      local pkg = mason_registry.get_package(package_name)
      if not pkg:is_installed() then
        if not pkg:is_installing() then
          fvim.notify(("Mason: installing %s ..."):format(package_name))
          pkg:install({}, function(success, err)
            if success then
              fvim.notify(("Mason: %s was successfully installed"):format(package_name))
              M.setup_server(lsp_name)
            else
              fvim.notify(("Mason: failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(package_name), vim.log.levels.ERROR)
              M.configured_ft[filetype] = false  -- Mark as not configured due to installation failure.
            end
          end)
        end
      end
    end
  end)
end


---Setup a LSP server
---@param server string server name
---@param opts vim.lsp.ClientConfig? configuration
function M.setup_server(server, opts)
  opts = opts or {}

  -- load custom settings
  local settings_ok, setting_opts = pcall(require, "fau.lsp.settings." .. server)
  if settings_ok then opts = vim.tbl_deep_extend("force", opts, setting_opts) end

  -- setup LSP
  vim.lsp.config(server, opts)

  if not vim.lsp.is_enabled(server) then vim.schedule(function() vim.lsp.enable(server, true) end) end
end


---Setup LSP according to filetype.
---@param filetype string? filetype
function M.setup_by_ft(filetype)
  filetype = filetype or vim.bo.filetype

  -- EXIT: LSP is already configured.
  if M.configured_ft[filetype] then return end

  -- ==================== Setup Servers ====================
  local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_ok then fvim.notify("[mason-lspconfig] is not installed!", vim.log.levels.ERROR); return end

  -- Get servers for specific filetype.
  local servers = mason_lspconfig.get_available_servers({ filetype = filetype })
  local all_installed_servers = mason_lspconfig.get_installed_servers()

  for _, server in pairs(servers) do
    if vim.tbl_contains(all_installed_servers, server) then
      M.setup_server(server)
    end
  end

  M.configured_ft[filetype] = true

  -- NOTE: `M.configured_ft[filetype]` may change when gets errors during installation.
  M._install_missing_packages(filetype)
end


---Restart LSP servers
---@param bufnr integer? buffer number
function M.restart_lsp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  -- LSP is not configured.
  local filetype = vim.bo[bufnr].filetype
  if not M.configured_ft[filetype] then
    fvim.notify("Starting LSP server for " .. filetype .. "...")
    M.setup_by_ft(filetype)
    return
  end

  -- REF: https://github.com/neovim/nvim-lspconfig/blob/master/plugin/lspconfig.lua `LspRestart` command.
  -- Get active clients for current buffer (excluding copilot).
  local clients = vim.iter(vim.lsp.get_clients({ bufnr = bufnr })):map(function(client) if client.name ~= "copilot" then return client.name end end):totable()

  -- Disable all clients first.
  for _, name in ipairs(clients) do
    if vim.lsp.config[name] == nil then fvim.notify(("Invalid server name '%s'"):format(name))
    else vim.lsp.enable(name, false)
    end
  end

  -- Restart clients after 500ms.
  local timer = assert(vim.uv.new_timer())
  timer:start(500, 0, function()
    for _, name in ipairs(clients) do
      vim.schedule_wrap(function(x) vim.lsp.enable(x, true) end)(name)
    end
  end)
end


return M
