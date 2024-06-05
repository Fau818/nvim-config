local autotag = require("nvim-ts-autotag")

autotag.setup({
  opts = {
    enable_close          = true,  -- Auto close tags
    enable_rename         = true,  -- Auto rename pairs of tags
    enable_close_on_slash = true,  -- Auto close on trailing </
  },

  per_filetype = nil,
})
