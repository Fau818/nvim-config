return {
  large_file_size = 1024 * 1024,  -- 1MiB
  large_file_line = 2000,

  large_folder_size = 100,

  -- HINT: Please consider to update `lualine.ignore_focus` when you add new filetypes.
  excluded_filetypes = {
    -- NOTE: Keep `""` as the first element.
    "", "help", "netrw", "tutor", "man", "qf", "log",
    "alpha",
    "aerial", "aerial-nav",
    "bigfile",
    "cmp_menu", "blink-cmp-menu", "blink-cmp-documentation", "blink-cmp-signature", "blink-cmp-dot-repeat",
    "crunner",
    "chatgpt-input",
    "diff", "DiffviewFiles", "DiffviewFileHistory",
    "flash_prompt",
    "glowpreview",
    "hydra_hint",
    "image",
    "lazy", "lazy_backdrop",
    "lspinfo", "mason",
    "notify", "noice",
    "NvimTree", "NvimTreeFilter",
    "snacks_input", "snacks_picker_input", "snacks_picker_list", "snacks_picker_preview",
    "snacks_notif", "snacks_notif_history", "snacks_layout_box",
    "snacks_win", "snacks_win_help", "snacks_win_backdrop",
    "snacks_dashboard", "snacks_terminal", "sidekick_terminal",
    "TelescopePrompt", "TelescopeResults",
    "terminal", "toggleterm",
    "trouble",
    "yazi",
  },
  excluded_buftypes = { "nofile", "help", "terminal", "prompt", "quickfix", "nowrite" },      -- NOTE: Keep `nofile` as the first element.

  special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "pyproject.toml", ".gitignore", ".gitmodules" },

  -- NOTE: List of vim regex for file/directory names.
  ignored_files = { "^\\.git$", "^\\.vscode$", "^\\.idea$", "^__pycache__$", "^\\.mypy_cache$", "^\\.DS_Store$", "^\\..*\\.iosinterface$" },
}
