vim.filetype.add({
  extension = { dconf = "surge", sgmodule = "surge" },
  -- NOTE: Other programs use `.conf` too, so only the folders that hold Surge profiles count.
  pattern = {
    [".*/surge/.*%.conf"] = "surge",
    [".*/iCloud~com~nssurge~inc/Documents/.*%.conf"] = "surge",
  },
})
