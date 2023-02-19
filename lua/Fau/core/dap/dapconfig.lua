-- =============================================
-- ========== Plugin Loading
-- =============================================
local dap_ok, dap = pcall(require, "dap")
if not dap_ok then Fau_vim.load_plugin_error("dap") return end



-- =============================================
-- ========== Initialization
-- =============================================
local register = function(name)
  local status, dap_setting = pcall(require, "Fau.core.dap.settings." .. name)

  -- if not status then Fau_vim.notify("Fau dap load: not fount [" .. name .. "] dapter.") end
  if not status then return end

  dap.adapters[name] = dap_setting.adapters[name]
  dap.configurations[name] = dap_setting.configurations[name]
end



-- =============================================
-- ========== Settings
-- =============================================
register("python")
