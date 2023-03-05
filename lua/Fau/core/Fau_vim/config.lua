-- =============================================
-- ========== Initialization
-- =============================================
Fau_vim = {}



-- =============================================
-- ========== Fields
-- =============================================
Fau_vim.on_server = os.getenv("FAU_ON_SERVER") == 1
-- TODO: unify fileds like Fau_vim.functions
Fau_vim.dap = { enable = false }
-- Fau_vim.inc_rename = { enable = pcall(require, "inc_rename") and pcall(require, "noice"), dressing = false }
Fau_vim.inc_rename = { enable = false, dressing = false }


Fau_vim.config_path = vim.fn.stdpath("config")

Fau_vim.configured_ft = {}  -- for recording filetypes which have been configured LSP

Fau_vim.disabled_filetypes = {
  "", "checkhealth", "help", "netrw", "tutor",
  "alpha",
  "aerial",
  "crunner",
  "DiffviewFiles",
  "gitcommit",
  "lspinfo", "mason",
  "notify", "noice",
  "NvimTree",
  "toggleterm",
  "Trouble",
  "TelescopePrompt",
  "packer", "lazy",

  "dap-repl", "dapui_watches", "dapui_stacks", "dapui_breakpoints", "dapui_scopes", "dapui_console",
}

---@param msg string
---@param level string|number|nil
---@param opts table<string, any>|nil
Fau_vim.notify = function(msg, level, opts)
  level = level or vim.log.levels.INFO
  if not opts then opts = { title = "Fau_vim" }
  elseif not opts.title or opts.title == "" then opts.title = "Fau_vim"
  end
  vim.notify(msg, level, opts)
end
