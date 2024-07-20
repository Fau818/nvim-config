-- Initializaiton
Fau_vim = { plugin = {}, file = {}, lsp = {} }



-- =============================================
-- ========== Fields
-- =============================================
-- TODO: unify fileds like Fau_vim.functions
-- -----------------------------------
-- -------- General
-- -----------------------------------
Fau_vim.colorscheme = "habamax"  -- Default colorscheme
Fau_vim.config_path = vim.fn.stdpath("config")
Fau_vim.xdg_config_home = os.getenv("XDG_CONFIG_HOME") or vim.fn.expand("~/.config")
Fau_vim.os_name = vim.fn.system("uname"):gsub("\n", "")


-- -----------------------------------
-- -------- Plugin
-- -----------------------------------
Fau_vim.plugin.copilot = { enable = vim.loop.fs_stat(string.format("%s/github-copilot/hosts.json", Fau_vim.xdg_config_home)) and true or false }
Fau_vim.plugin.trouble = { tag = "v2.10.0" }
Fau_vim.plugin.openai  = {
  api_path  = ("%s/apikey"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
  host_path = ("%s/host"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
}


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
  go     = { "gopls" },
  html   = { "html-lsp" },
  docker = { "dockerfile-language-server" },
  dockerfile = { "dockerfile-language-server" },
}


-- -----------------------------------
-- -------- File
-- -----------------------------------
Fau_vim.file.large_file_size = 1024 * 512  -- 512KiB
Fau_vim.file.large_file_line = 5000
Fau_vim.file.excluded_filetypes = {
  "", "help", "netrw", "tutor", "man", "qf",
  "alpha",
  "aerial", "aerial-nav",
  "crunner",
  "chatgpt-input",
  "diff", "DiffviewFiles",
  "DressingInput", "DressingSelect",
  "glowpreview",
  "lspinfo", "mason",
  "notify", "noice", "netrw",
  "NvimTree",
  "terminal", "toggleterm",
  "trouble",
  "TelescopePrompt",
  "packer", "lazy", "yazi",
}
Fau_vim.file.excluded_buftypes = { "help", "nofile", "terminal", "prompt", "quickfix" }
Fau_vim.file.special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", ".gitignore", ".gitmodules" }
Fau_vim.file.ignored_files = { "^.git$", "^.vscode$", "^.idea$", "^__pycache__$", "^.mypy_cache$", "^.DS_Store$" }
Fau_vim.file.ignored_pattern = { ".git/", ".vscode/", ".idea/", "__pycache__/", ".DS_Store" }
