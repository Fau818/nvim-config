---@type LazySpec
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile      = require("Fau.plugins.editor.snacks.bigfile"),
    dim          = require("Fau.plugins.editor.snacks.dim"),
    dashboard    = { enabled = false },
    explorer     = { enabled = false },
    indent       = require("Fau.plugins.editor.snacks.indent"),
    input        = { enabled = true },
    picker       = { enabled = false },
    -- profiler     = { enabled = false, autocmds = false },
    notifier     = { enabled = false },
    quickfile    = { enabled = false },
    scope        = require("Fau.plugins.editor.snacks.scope"),
    scroll       = { enabled = false },
    statuscolumn = { enabled = false },
    words        = require("Fau.plugins.editor.snacks.words"),
    zen          = require("Fau.plugins.editor.snacks.zen"),

    -- Snacks.git.blame_line()
    -- Snacks.gitbrowse.open()
  },

  config = function(_, opts)
    require("snacks").setup(opts)

    -- TEST: Test in May 10, 2025
    Fau_vim.notify = Snacks.debug.inspect
    Fau_vim.functions.utils._buf_remove = Snacks.bufdelete.delete

    -- NOTE: Global debug functions
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    ---@diagnostic disable-next-line: duplicate-set-field
    if vim.fn.has("nvim-0.11") == 1 then vim._print = function(_, ...) dd(...) end else vim.print = dd end

    -- ==================== Toggle ====================
    Snacks.toggle.dim():map("<leader><leader>t")
    Snacks.toggle.zen():map("<leader><leader>z")
  end,

  keys = {
    -- ==================== Words ====================
    {
      mode = { "n", "i" }, "<A-n>",
      function()
        if Snacks.words.is_enabled() then Snacks.words.jump(1,  true)
        else vim.notify("Snacks.words is disabled", vim.log.levels.WARN)
        end
      end,
      desc = "Snacks.words: Next"
    },
    {
      mode = { "n", "i" }, "<A-N>",
      function()
        if Snacks.words.is_enabled() then Snacks.words.jump(-1,  true)
        else vim.notify("Snacks.words is disabled", vim.log.levels.WARN)
        end
      end,
      desc = "Snacks.words: Prev",
    },
  },
}
