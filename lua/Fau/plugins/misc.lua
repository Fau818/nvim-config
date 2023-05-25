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
    commit = "03c65909aa1023b9aa6ed7b6c4f2eff26f5bc9b8",
    cond = false
  }
}


return misc
