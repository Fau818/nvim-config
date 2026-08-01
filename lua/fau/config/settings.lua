return {
  copilot = { enable = vim.uv.fs_stat(vim.fs.joinpath(fvim.xdg_config_home, "github-copilot")) and true or false },

  openai  = {
    api_path  = vim.fs.joinpath(os.getenv("OPENAI_API_PATH") or vim.fn.expand("$HOME"), "apikey"),
    host_path = vim.fs.joinpath(os.getenv("OPENAI_API_PATH") or vim.fn.expand("$HOME"), "host"),
  },

  sign_priority = {
    default = 10,

    diagnostics   = 10,  -- NOTE: This is a base priority for diagnostics signs. RANGE: [base, base+3]
    gitsigns      = 11,  -- NOTE: Set to 11 means it will be covered by warn&error signs.
    todo_comments = 10,
    markdown   = 9,

    git_blame = 100,
  },


  debounce = {
    general = 250,  -- Fau: It should be the same as `vim.opt.updatetime`.

    copilot = 100,
    nes = 1000,

    colorizer = 75,
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
