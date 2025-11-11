return {
  copilot = { enable = vim.uv.fs_stat(string.format("%s/github-copilot", fvim.xdg_config_home)) and true or false },

  openai  = {
    api_path  = ("%s/apikey"):format(os.getenv("OPENAI_API_PATH") or vim.fn.expand("$HOME")),
    host_path = ("%s/host"):format(os.getenv("OPENAI_API_PATH") or vim.fn.expand("$HOME")),
  },

  sign_priority = {
    default = 10,

    diagnostics   = 10,  -- NOTE: This is a base priority for diagnostics signs. RANGE: [base, base+3]
    gitsigns      = 11,  -- NOTE: Set to 11 means it will be covered by warn&error signs.
    todo_comments = 10,

    git_blame = 100,
  },


  debounce = {
    general = 250,  -- Fau: It should be the same as `vim.opt.updatetime`.

    copilot = 50,
    nes     = 250,

    highlight = 200,
    indentscope = 100,

    diagnostics = 500,
    lsp_symbols = 300,

    statuscolumn = 100,
    gitsigns = 100,
    git_blame = 500,

    explore = 50,

    statusline = 500,
  },


  timeout = { git = 500 },
}
