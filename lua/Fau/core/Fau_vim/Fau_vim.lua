-- =============================================
-- ========== Initialization
-- =============================================
Fau_vim = {}



-- =============================================
-- ========== Fields
-- =============================================
Fau_vim.dap = { enable = false }
Fau_vim.notify = vim.notify
Fau_vim.config_path = vim.fn.stdpath("config")
Fau_vim.configured_ft = {}  -- for recording filetypes which have been configured LSP
