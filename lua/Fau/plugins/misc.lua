-- NOTE: misc plugins.

---@type LazySpec[]
local misc = {
  {
    -- DESC: coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    priority = 0,
    enabled = vim.fn.executable("wakatime-cli") == 1,
  },


  {
    -- DESC: a python stub library.
    "microsoft/python-type-stubs",
    lazy = true,
  },

  {
    -- DESC: Just for fun.
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
}


return misc
