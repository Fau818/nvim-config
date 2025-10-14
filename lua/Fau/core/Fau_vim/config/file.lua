return {
  large_file_size = 1024 * 512,  -- 512KiB
  large_file_line = 2000,

  excluded_filetypes = {
    "", "help", "netrw", "tutor", "man", "qf", "query",
    "bigfile",
    "alpha",
    "aerial", "aerial-nav",
    "cmp_menu", "blink-cmp-menu", "blink-cmp-documentation",
    "crunner",
    "chatgpt-input",
    "diff", "DiffviewFiles",
    "DressingInput", "DressingSelect",
    "flash_prompt",
    "glowpreview",
    "lspinfo", "mason",
    "notify", "noice", "netrw",
    "NvimTree",
    "snacks_picker_input",
    "terminal", "toggleterm",
    "trouble",
    "TelescopePrompt",
    "packer", "lazy", "yazi",
  },
  excluded_buftypes = { "help", "nofile", "terminal", "prompt", "quickfix" },

  special_files     = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", ".gitignore", ".gitmodules" },
  ignored_files     = { "^.git$", "^.vscode$", "^.idea$", "^__pycache__$", "^.mypy_cache$", "^.DS_Store$", "^.*.iosinterface$" },
  ignored_patterns   = {
    "^.git/",
    "^.vscode/",
    "^.idea/",

    "^node_modules/",
    "^__pycache__/",

    "^.local/",
    "^.cache/",
    "^.Trash/",
    "^.terminfo/",

    "^Applications/",
    "^Desktop/",
    "^Documents/",
    "^Downloads/",
    "^Library/",
    "^Movies/",
    "^Music/",
    "^Pictures/",
  },
}
