-- DESC: This module is for python filetype.

---@type LazySpec[]
local python = {
  {
    -- DESC: A set of type stubs for popular Python packages.
    "microsoft/python-type-stubs",
    lazy = true,
  },

  {
    -- DESC: Auto generate python docstring.
    "pixelneo/vim-python-docstring",
    config = function()
      vim.g.python_style = "numpy"  ---@type "single"|"double"|"shadow"|"curved"|"rounded"|"none"
      vim.g.vpd_indent = (" "):rep(vim.bo.tabstop)
    end,
    ft = "python",
    cmd = { "Docstring", "DostringTypes", "DocstringLine" },
    keys = {
      { "<LEADER><LEADER>d", "<CMD>DocstringTypes<CR>", desc = "Python Docstring with type hints" },
      { "<LEADER><LEADER>D", "<CMD>Docstring<CR>",      desc = "Python Docstring" }
    },
    cond = true,  -- TESTING: Not TESTED in VSCode.
  },

}


return python
