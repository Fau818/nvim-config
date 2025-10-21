return {
  sign_priority = {
    default = 10,

    diagnostics = 11,  -- FIXME: It seems diagnostic is 13
    gitsigns = 14,
    todo_comments = 10,
  },


  debounce = {
    general = 250,  -- Fau: It should be the same as `vim.opt.updatetime`.

    copilot = 50,

    highlight = 200,
    indentscope = 100,

    diagnostics = 250,
    lsp_symbols = 300,

    gitsigns = 100,
    git_blame = 500,

    explore = 50,
  }
}
