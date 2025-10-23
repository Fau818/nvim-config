---@type LazySpec
return {
  ---@module "snacks"
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
    picker       = require("Fau.plugins.editor.snacks.picker"),
    -- profiler     = { enabled = false, autocmds = false },
    notifier     = require("Fau.plugins.editor.snacks.notifier"),
    quickfile    = { enabled = false },
    styles       = require("Fau.plugins.editor.snacks.styles"),
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

    -- ==================== Notification ====================
    ---@type fun(msg: string, level?: snacks.notifier.level|number, opts?: snacks.notifier.Notif.opts): number|string
    function Fau_vim.notify(msg, level, opts_)
      if type(msg) ~= "string" then msg = vim.inspect(msg) end
      level = level or vim.log.levels.INFO
      opts_ = opts_ or {}
      vim.tbl_extend("force", opts_, { title = "Fau_vim" })
      Snacks.notifier.notify(msg, level, opts_)
      return 555
    end
    function Fau_vim.inspect (...) return vim.inspect(...) end
    function Fau_vim.show(...) Fau_vim.notify(vim.inspect(...)) end


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
        else Fau_vim.notify("Snacks.words is disabled", vim.log.levels.WARN)
        end
      end,
      desc = "Snacks.words: Next"
    },
    {
      mode = { "n", "i" }, "<A-N>",
      function()
        if Snacks.words.is_enabled() then Snacks.words.jump(-1,  true)
        else Fau_vim.notify("Snacks.words is disabled", vim.log.levels.WARN)
        end
      end,
      desc = "Snacks.words: Prev",
    },
  },
}
