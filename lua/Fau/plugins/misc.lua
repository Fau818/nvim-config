-- NOTE: misc plugins.

---@type LazySpec[]
local misc = {
  {
    -- DESC: coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    enabled = vim.fn.executable("wakatime-cli") == 1,
  },


  {
    -- DESC: a python stub library.
    "microsoft/python-type-stubs",
    event = "User OnlyManaged"
  },

  {
    -- DESC: a plugin just for fun.
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
}


return misc
