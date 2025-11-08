local M = {}


---Convert Mason package name to LSP config name.
---@param pkg_name string Mason package name
---@return string lsp_config_name LSP config name
function M.pkg_name_to_lsp_name(pkg_name)
  local mason_lspconfig = require("mason-lspconfig")
  return mason_lspconfig.get_mappings().package_to_lspconfig[pkg_name] or pkg_name
end


---Convert LSP config name to Mason package name.
---@param lsp_name string LSP config name
---@return string pkg_name Mason package name
function M.lsp_name_to_pkg_name(lsp_name)
  local mason_lspconfig = require("mason-lspconfig")
  return mason_lspconfig.get_mappings().lspconfig_to_package[lsp_name] or lsp_name
end


---Hook to Mason's package installation success event.
function M.hook_on_install_success()
  -- Auto setup LSP after installation.
  local registry = require("mason-registry")
  registry:on("package:install:success", function(pkg, receipt)
    local lsp_name = M.pkg_name_to_lsp_name(pkg.name)
    fvim.lsp.setup_server(lsp_name)
  end)
end


---Install missing packages for specific filetype.
---@param filetype string?
function M.install_missing_packages(filetype)
  filetype = filetype or vim.bo.filetype

  -- EXIT: No packages to install.
  local package_list = fvim.lsp.packages[filetype]
  if package_list == nil then return true end

  -- ==================== Install Missing Packages ====================
  -- NOTE: Please make sure you have `mason.nvim` and `mason-lspconfig.nvim` installed.
  local mason_lspconfig = require("mason-lspconfig")
  local mason_registry = require("mason-registry")

  mason_registry.refresh(function()
    for _, lsp_name in ipairs(package_list) do
      -- NOTE: lsp_name and package_name may be different and confusing, so handle both.
      local pkg_name = M.lsp_name_to_pkg_name(lsp_name)
      lsp_name = M.pkg_name_to_lsp_name(pkg_name)

      local pkg = mason_registry.get_package(pkg_name)
      if not pkg:is_installed() then
        if not pkg:is_installing() then
          fvim.notify(("Mason: installing %s ..."):format(pkg_name))
          pkg:install({}, function(success, err)
            if success then
              fvim.notify(("Mason: %s was successfully installed."):format(pkg_name))
              -- TIPS: LSP will be setup via the hook on `M.hook_on_install_success()`.
            else
              fvim.notify(("Mason: failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(pkg_name), vim.log.levels.ERROR)
              fvim.lsp.configured_ft[filetype] = false  -- Mark as not configured due to installation failure.
            end
          end)
        end
      end
    end
  end)
end


---Setup LSP according to filetype.
---@param filetype string? filetype
function M.setup_by_ft(filetype)
  filetype = filetype or vim.bo.filetype

  -- EXIT: LSP is already configured.
  if fvim.lsp.configured_ft[filetype] then return end

  -- ==================== Setup Servers ====================
  local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_ok then fvim.notify("[mason-lspconfig] is not installed!", vim.log.levels.ERROR); return end

  -- Get servers for specific filetype.
  local servers = mason_lspconfig.get_available_servers({ filetype = filetype })
  local all_installed_servers = mason_lspconfig.get_installed_servers()

  for _, server in pairs(servers) do
    if vim.tbl_contains(all_installed_servers, server) then
      fvim.lsp.setup_server(server)
    end
  end

  fvim.lsp.configured_ft[filetype] = true

  -- NOTE: `M.configured_ft[filetype]` may change when gets errors during installation.
  M.install_missing_packages(filetype)
end


return M
