-- =============================================
-- ========== Initialization
-- =============================================
Fau_vim = {}



-- =============================================
-- ========== Fields
-- =============================================
Fau_vim.dap = { enable = false }

---@param msg string
---@param level string|number|nil
---@param opts table<string, any>|nil
Fau_vim.notify = function(msg, level, opts)
	level = level or vim.log.levels.INFO
	vim.notify(msg, level, opts)
end

Fau_vim.config_path = vim.fn.stdpath("config")
Fau_vim.configured_ft = {}  -- for recording filetypes which have been configured LSP
