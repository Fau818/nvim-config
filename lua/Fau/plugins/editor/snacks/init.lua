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
    dashboard    = require("Fau.plugins.editor.snacks.dashboard"),
    explorer     = { enabled = false, replace_netrw = true },
    indent       = require("Fau.plugins.editor.snacks.indent"),
    input        = require("Fau.plugins.editor.snacks.input"),
    picker       = require("Fau.plugins.editor.snacks.picker"),
    -- profiler     = { enabled = false, autocmds = false },
    notifier     = require("Fau.plugins.editor.snacks.notifier"),
    quickfile    = { enabled = false },
    styles       = require("Fau.plugins.editor.snacks.styles"),
    scope        = require("Fau.plugins.editor.snacks.scope"),
    scroll       = require("Fau.plugins.editor.snacks.scroll"),
    statuscolumn = require("Fau.plugins.editor.snacks.statuscolumn"),
    words        = require("Fau.plugins.editor.snacks.words"),
    zen          = require("Fau.plugins.editor.snacks.zen"),

    -- Snacks.git.blame_line()
    -- Snacks.gitbrowse.open()
  },

  config = function(_, opts)
    require("snacks").setup(opts)

    -- HACK: Remove std_data path from default config.
    Snacks.picker.sources.recent.filter.paths = { [vim.fn.stdpath("cache")] = false, [vim.fn.stdpath("state")] = false }


    -- ==================== Notification ====================
    ---@type fun(msg: any, level?: snacks.notifier.level|number, opts?: snacks.notifier.Notif.opts): number|string
    function Fau_vim.notify(msg, level, opts_)
      if type(msg) ~= "string" then msg = vim.inspect(msg) end
      level = level or vim.log.levels.INFO
      opts_ = opts_ or {}
      opts_ = vim.tbl_extend("force", opts_, { title = "Fau_vim" })
      Snacks.notifier.notify(msg, level, opts_)
      return 555
    end
    function Fau_vim.inspect(...) return vim.inspect(...) end
    function Fau_vim.show(...) Fau_vim.notify(vim.inspect(...)) end


    Fau_vim.functions.utils._buf_remove = Snacks.bufdelete.delete

    -- NOTE: Global debug functions
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    ---@diagnostic disable-next-line: duplicate-set-field
    if vim.fn.has("nvim-0.11") == 1 then vim._print = function(_, ...) dd(...) end else vim.print = dd end

    -- ==================== Toggle ====================
    Snacks.toggle.dim():map("<LEADER><LEADER>t")
    Snacks.toggle.zen():map("<LEADER><LEADER>z")
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



    -- ==================== Picker ====================
    -- Top Pickers
    { "<LEADER><LEADER>f", function() Snacks.picker() end, desc = "Find Files" },
    -- TEST: use smart picker as the files picker.  Oct 24, 2025
    { "<LEADER>ff", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    -- { "<LEADER>F",  function() Snacks.picker.files() end, desc = "Find Files" },
    { "<LEADER>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<LEADER>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<LEADER>fp", function() Snacks.picker.projects() end, desc = "Projects" },

    { "<leader>F",  function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<LEADER>fs", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<LEADER>fS", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },

    { "<LEADER>fn", function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<LEADER>fT",
      ---@diagnostic disable-next-line: undefined-field
      function() Snacks.picker.todo_comments({
          keywords = {
            "TODO", "TASK", "QUES", "QUESTION",
            "FIX", "FIXME", "BUG", "FIXIT", "ISSUE",
            "TEST", "TESTING", "PASSED", "FAILED", "TEMP",
          }
        })
      end,
      desc = "TODO Comments"
    },
    { "<LEADER>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<LEADER>gh", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },  -- TODO: set a new keymap

    { "<LEADER>fa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<LEADER>fc", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<LEADER>fC", function() Snacks.picker.command_history() end, desc = "Command History" },

    { "<LEADER>fh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<LEADER>fH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<LEADER>fi", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<LEADER>fj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<LEADER>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    -- TODO: conda picker

    { "<LEADER>fP", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<LEADER>fR", function() Snacks.picker.resume() end, desc = "Resume" },

    { "<LEADER>flc", function() Snacks.picker.lsp_config() end, desc = "LSP Config" },
    { "<LEADER>fld", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "<LEADER>flD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "<LEADER>flI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "<LEADER>flr", function() Snacks.picker.lsp_references() end, desc = "References" },
    { "<LEADER>flt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<LEADER>fli", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    { "<LEADER>flo", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },

    -- { "<LEADER>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<LEADER>ls", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

    { "z=", function() Snacks.picker.spelling() end, desc = "Spelling Suggestions" },
  },
}
