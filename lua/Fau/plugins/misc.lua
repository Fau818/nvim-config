-- NOTE: misc plugins.

---@type LazySpec[]
local misc = {
  {
    -- DESC: Coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    priority = 0,
    enabled = vim.fn.executable("wakatime-cli") == 1,
  },

}


return misc
