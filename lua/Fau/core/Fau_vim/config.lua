-- ==================== General ====================
Fau_vim.colorscheme = "habamax"  -- Default colorscheme
Fau_vim.config_path = vim.fn.stdpath("config")
Fau_vim.xdg_config_home = os.getenv("XDG_CONFIG_HOME") or vim.fn.expand("~/.config")
Fau_vim.os_name = vim.fn.system("uname"):gsub("\n", "")


-- ==================== File ====================
Fau_vim.file = {
  large_file_size = 1024 * 512,  -- 512KiB
  large_file_line = 5000,

  excluded_filetypes = {
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
  },
  excluded_buftypes = { "help", "nofile", "terminal", "prompt", "quickfix" },

  special_files     = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", ".gitignore", ".gitmodules" },
  ignored_files     = { "^.git$", "^.vscode$", "^.idea$", "^__pycache__$", "^.mypy_cache$", "^.DS_Store$" },
  ignored_pattern   = { ".git/", ".vscode/", ".idea/", "__pycache__/", ".DS_Store" },
}


-- ==================== LSP ====================
Fau_vim.lsp = {
  configured_ft = {},

  packages = {
    lua    = { "lua-language-server" },
    python = { "pylance", "flake8", "pydocstyle" },
    json   = { "json-lsp" },
    sh     = { "bash-language-server" },
    yaml   = { "yaml-language-server" },
    go     = { "gopls" },
    html   = { "html-lsp" },
    docker = { "dockerfile-language-server" },
    dockerfile = { "dockerfile-language-server" },
  },
}


-- ==================== Plugins ====================
Fau_vim.plugin = {
  copilot = { enable = vim.loop.fs_stat(string.format("%s/github-copilot/hosts.json", Fau_vim.xdg_config_home)) and true or false },
  trouble = { tag = "v2.10.0" },
  openai  = {
    api_path  = ("%s/apikey"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
    host_path = ("%s/host"):format(os.getenv("OPENAI_API_PATH") or Fau_vim.config_path),
  },
}


-- ==================== Extensions ====================
Fau_vim.icons     = require("Fau.core.Fau_vim.icons")
Fau_vim.colors    = require("Fau.core.Fau_vim.colors")
Fau_vim.functions = require("Fau.core.Fau_vim.functions")
-- Fau_vim.file_indent = require "Fau.core.Fau_vim.file_indent"
