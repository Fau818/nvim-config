return {
  sign_priority = {
    default = 10,

    diagnostics   = 10,  -- NOTE: This is a base priority for diagnostics signs. RANGE: [base, base+3]
    gitsigns      = 12,  -- NOTE: Set to 12 means it will be covered by warn&error signs.
    todo_comments = 11,

    git_blame = 100,
  },


  debounce = {
    general = 250,  -- Fau: It should be the same as `vim.opt.updatetime`.

    copilot = 50,

    highlight = 200,
    indentscope = 100,

    diagnostics = 250,
    lsp_symbols = 300,

    statuscolumn = 100,
    gitsigns = 100,
    git_blame = 500,

    explore = 50,
  }
}
