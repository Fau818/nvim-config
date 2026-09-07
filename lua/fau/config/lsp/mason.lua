---@module "mason"

local M = {}


---Convert Mason package name to LSP config name.
---@param pkg_name string Mason package name
---@return string lsp_config_name LSP config name
local function pkg_name_to_lsp_name(pkg_name)
  local mason_lspconfig = require("mason-lspconfig")
  return mason_lspconfig.get_mappings().package_to_lspconfig[pkg_name] or pkg_name
end


---Convert LSP config name to Mason package name.
---@param lsp_name string LSP config name
---@return string pkg_name Mason package name
local function lsp_name_to_pkg_name(lsp_name)
  local mason_lspconfig = require("mason-lspconfig")
  return mason_lspconfig.get_mappings().lspconfig_to_package[lsp_name] or lsp_name
end


---Hook to Mason's package installation success event.
local function _on_install_success(pkg)
  if not vim.tbl_contains(pkg.spec.categories or {}, "LSP") then return end  -- Not an LSP package.
  fvim.lsp.setup_server(pkg_name_to_lsp_name(pkg.spec.name))
end


---Hook to Mason's package installation success event.
function M.hook_on_install_success()
  -- NOTE: Mason caches the hooks, so make sure `_on_install_success` is defined at the module level.
  require("mason-registry"):on("package:install:success", _on_install_success)
end


---Install a specific package via Mason.
---@param pkg_name string Mason package name
---@param filetype string? filetype
---@param callback fun(success: boolean, err: string?)? Optional callback, always called once the package is available or gave up.
function M.mason_install(pkg_name, filetype, callback)
  local mason_registry = require("mason-registry")

  local done = type(callback) == "function" and vim.schedule_wrap(callback) or nil

  local function _mason_install()
    -- EXIT: `get_package` throws on an unknown name, which would swallow the callback.
    if not mason_registry.has_package(pkg_name) then
      fvim.notify(("Mason: %s is not in the registry."):format(pkg_name), vim.log.levels.ERROR)
      if done then done(false, "unknown package") end
      return
    end

    local pkg = mason_registry.get_package(pkg_name)

    -- EXIT: Nothing to install.
    if pkg:is_installed() then if done then done(true) end return end

    -- EXIT: Another caller owns the install; ride on the handle it created.
    if pkg:is_installing() then
      if done then pkg:get_install_handle():if_present(function(handle) handle:once("closed", function() done(pkg:is_installed()) end) end) end
      return
    end

    local notif_opts = { id = "mason_install_" .. pkg_name }
    fvim.notify(("Mason: installing %s ..."):format(pkg_name), vim.log.levels.INFO, notif_opts)
    pkg:install({}, function(success, err)
      if success then fvim.notify(("Mason: %s was successfully installed."):format(pkg_name), vim.log.levels.INFO, notif_opts)
      else
        fvim.notify(("Mason: failed to install %s. Installation logs are available in :Mason and :MasonLog"):format(pkg_name), vim.log.levels.ERROR, notif_opts)
        if filetype then fvim.lsp.configured_ft[filetype] = false end  -- Mark as not configured due to installation failure.
      end
      if done then done(success, err) end
    end)
  end

  mason_registry.refresh(_mason_install)
end


---Install missing packages for specific filetype.
---@param filetype string?
local function install_missing_packages(filetype)
  filetype = filetype or vim.bo.filetype

  -- EXIT: No packages to install.
  local package_list = fvim.lsp.packages[filetype]
  if package_list == nil then return end

  -- NOTE: Please make sure you have `mason.nvim` and `mason-lspconfig.nvim` installed.
  local mason_registry = require("mason-registry")

  mason_registry.refresh(function()
    for _, lsp_name in ipairs(package_list) do
      -- NOTE: lsp_name and package_name may be different and confusing, so handle both.
      local pkg_name = lsp_name_to_pkg_name(lsp_name)
      lsp_name = pkg_name_to_lsp_name(pkg_name)
      M.mason_install(pkg_name, filetype)
    end
  end)
end


---Setup LSP according to filetype.
---@param filetype string? filetype
function M.setup_by_ft(filetype)
  filetype = filetype or vim.bo.filetype

  -- EXIT: LSP is already configured.
  if not filetype or fvim.lsp.configured_ft[filetype] then return end

  local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_ok then fvim.notify("[mason-lspconfig] is not installed!", vim.log.levels.ERROR); return end

  -- Get servers for a specific filetype.
  local servers = mason_lspconfig.get_available_servers({ filetype = filetype })
  local extra_servers = vim.tbl_map(pkg_name_to_lsp_name, fvim.lsp.packages[filetype] or {})
  extra_servers = vim.tbl_filter(function(server) return not vim.tbl_contains(servers, server) end, extra_servers)
  servers = vim.list_extend(servers, extra_servers)

  local all_installed_servers = mason_lspconfig.get_installed_servers()
  for _, server in pairs(servers) do
    if vim.tbl_contains(all_installed_servers, server) then
      fvim.lsp.setup_server(server)
    end
  end

  fvim.lsp.configured_ft[filetype] = true

  -- NOTE: `M.configured_ft[filetype]` may change when gets errors during installation.
  install_missing_packages(filetype)
end


return M
