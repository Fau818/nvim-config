---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,

  ---@type snacks.Config
  opts = {
    bigfile      = require("Fau.plugins.editor.snacks.bigfile"),
    dim          = require("Fau.plugins.editor.snacks.dim"),
    dashboard    = { enabled = false },  -- TODO: QwQ
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

    -- NOTE: Global debug functions
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    ---@diagnostic disable-next-line: duplicate-set-field
    if vim.fn.has("nvim-0.11") == 1 then vim._print = function(_, ...) dd(...) end else vim.print = dd end

    -- ==================== Snacks ====================
    Snacks.toggle.dim():map("<leader><leader>t")
  end,
}
