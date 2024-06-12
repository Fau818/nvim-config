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
  "", "help", "netrw", "tutor", "man",
  "alpha",
  "aerial", "aerial-nav",
  "crunner",
  "DiffviewFiles",
  "DressingInput",
  "glowpreview",
  "lspinfo", "mason",
  "notify", "noice", "netrw",
  "NvimTree",
  "toggleterm",
  "tsplayground",
  "trouble",
  "TelescopePrompt",
  "packer", "lazy", "yazi",
}
Fau_vim.file.special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", ".gitignore", ".gitmodules" }
Fau_vim.file.ignored_files = { "^.DS_Store$", "^.git$", "^__pycache__$", "^.vscode$", "^.idea$", "^.mypy_cache$" }


-- -----------------------------------
-- -------- Deprecated
-- -----------------------------------
Fau_vim.plugin.inc_rename = { enable = false, dressing = false }
