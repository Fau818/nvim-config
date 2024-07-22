return {
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
