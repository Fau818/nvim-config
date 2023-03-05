-- NOTE: misc plugins.

return {
  {
    -- DESC: coding time tracker (for wakatime statistics).
    "wakatime/vim-wakatime",
    event = "VeryLazy",
    enabled = not Fau_vim.on_server,
  },
}
