-- Initializaiton
Fau_vim = { plugin = {}, file = {}, lsp = {} }



-- =============================================
-- ========== Fields
-- =============================================
-- TODO: unify fileds like Fau_vim.functions
-- -----------------------------------
-- -------- General
-- -----------------------------------
Fau_vim.colorscheme = "tokyonight"
Fau_vim.config_path = vim.fn.stdpath("config")
Fau_vim.os_name = vim.fn.system("uname"):gsub("\n", "")


-- -----------------------------------
-- -------- Plugin
-- -----------------------------------
Fau_vim.plugin.copilot = { enable = os.getenv("COPILOT_ENABLE") == "1" }
Fau_vim.plugin.dap = { enable = false }


-- -----------------------------------
-- -------- LSP
-- -----------------------------------
Fau_vim.lsp.configured_ft = {}
Fau_vim.lsp.packages = {
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


-- -----------------------------------
-- -------- File
-- -----------------------------------
Fau_vim.file.large_file_size = 1024 * 128  -- 128KiB
Fau_vim.file.disabled_filetypes = {
  "", "checkhealth", "help", "netrw", "tutor", "man",
  "alpha",
  "aerial", "aerial-nav",
  "crunner",
  "DiffviewFiles",
  "DressingInput",
  "gitcommit",
  "glowpreview",
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
Fau_vim.file.special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", ".gitignore", ".gitmodules" }
Fau_vim.file.ignored_files = { "^.DS_Store$", "^.git$", "^__pycache__$", "^.vscode$", "^.idea$", "^.mypy_cache$" }


-- -----------------------------------
-- -------- Deprecated
-- -----------------------------------
Fau_vim.plugin.inc_rename = { enable = false, dressing = false }



-- =============================================
-- ========== Functions
-- =============================================
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
