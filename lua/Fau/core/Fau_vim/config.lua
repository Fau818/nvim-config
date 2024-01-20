-- =============================================
-- ========== Initialization
-- =============================================
Fau_vim = {}



-- =============================================
-- ========== Fields
-- =============================================
-- TODO: unify fileds like Fau_vim.functions
Fau_vim.dap = { enable = false }
-- Fau_vim.inc_rename = { enable = pcall(require, "inc_rename") and pcall(require, "noice"), dressing = false }
Fau_vim.inc_rename = { enable = false, dressing = false }
Fau_vim.copilot = { enable = os.getenv("COPILOT_ENABLE") == "1" }
Fau_vim.os_name = vim.fn.system("uname"):gsub("\n", "")

Fau_vim.config_path = vim.fn.stdpath("config")

Fau_vim.large_file_size = 1024 * 1024

Fau_vim.configured_ft = {}  -- for recording filetypes which have been configured LSP

Fau_vim.disabled_filetypes = {
  "", "checkhealth", "help", "netrw", "tutor", "man",
  "alpha",
  "aerial", "aerial-nav",
  "crunner",
  "DiffviewFiles",
  "DressingInput",
  "gitcommit",
  "lspinfo", "mason",
  "notify", "noice", "netrw",
  "NvimTree",
  "toggleterm",
  "tsplayground",
  "Trouble",
  "TelescopePrompt",
  "packer", "lazy",

  "dap-repl", "dapui_watches", "dapui_stacks", "dapui_breakpoints", "dapui_scopes", "dapui_console",
}

Fau_vim.special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", ".gitignore", ".gitmodules" }

Fau_vim.ignored_files = { "^.git$", ".DS_Store", "^__pycache__$", "^.idea$", "^.mypy_cache$" }

Fau_vim.packages = {
  lua    = { "lua-language-server" },
  python = { "pylance", "flake8", "pydocstyle" },
  json   = { "json-lsp" },
  sh     = { "bash-language-server" },
  yaml   = { "yaml-language-server" },
  docker = { "dockerfile-language-server" },
  go     = { "gopls" },
  html   = { "html-lsp" },
  dockerfile = { "dockerfile-language-server" },
}

---@param msg string
---@param level string|number|nil
---@param opts table|notify.Options|nil
Fau_vim.notify = function(msg, level, opts)
  level = level or vim.log.levels.INFO
  if not opts then opts = { title = "Fau_vim" }
  elseif not opts.title or opts.title == "" then opts.title = "Fau_vim"
  end
  vim.notify(msg, level, opts)
end
