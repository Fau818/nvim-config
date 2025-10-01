---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,

  ---@type snacks.Config
  opts = {
    bigfile      = require("Fau.plugins.editor.snacks.bigfile"),
    dashboard    = { enabled = false },    -- TODO: QwQ
    explorer     = { enabled = false },
    indent       = require("Fau.plugins.editor.snacks.indent"),
    input        = { enabled = true },
    picker       = { enabled = false },
    notifier     = { enabled = false },
    quickfile    = { enabled = false },
    scope        = { enabled = false },
    scroll       = { enabled = false },
    statuscolumn = { enabled = false },
    words        = { enabled = false },

    -- Snacks.git.blame_line()
    -- Snacks.gitbrowse.open()
  },

  config = function(_, opts)
    require("snacks").setup(opts)
    -- TEST: Test in May 10, 2025
    Fau_vim.notify = Snacks.debug.inspect
  end,
}
