-- DESC: This module is for python filetype.

---@type LazySpec[]
return {
  {
    -- DESC: A set of type stubs for popular Python packages.
    "microsoft/python-type-stubs",
    lazy = true,
  },

  {
    -- DESC: Auto generate python docstring.
    "pixelneo/vim-python-docstring",
    cond = true,
    cmd = { "Docstring", "DocstringTypes", "DocstringLine" },
    ft = "python",
    keys = {
      { "<LEADER><LEADER>d", "<CMD>Docstring<CR>",      buffer = true, ft = "python", desc = "Python Docstring: Generate" },
      { "<LEADER><LEADER>D", "<CMD>DocstringTypes<CR>", buffer = true, ft = "python", desc = "Python Docstring: Generate with Type Hints" },
    },

    init = function()
      vim.g.python_style = "numpy"  ---@type "google" | "numpy" | "rest" | "epytext"
      vim.g.vpd_indent = (" "):rep(vim.bo.tabstop)
    end,
  },

}
