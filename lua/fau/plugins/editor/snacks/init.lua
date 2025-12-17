---@type LazySpec
return {
  ---@module "snacks"
  "folke/snacks.nvim",
  priority = 999,
  lazy = false,

  ---@type snacks.Config
  opts = {
    bigfile      = require("fau.plugins.editor.snacks.bigfile"),
    dashboard    = require("fau.plugins.editor.snacks.dashboard"),
    dim          = require("fau.plugins.editor.snacks.dim"),
    explorer     = { enabled = false, replace_netrw = true },
    gitbrowse    = { enabled = true },
    gh           = { enabled = false },  -- TODO: QwQ
    image        = require("fau.plugins.editor.snacks.image"),
    indent       = require("fau.plugins.editor.snacks.indent"),
    input        = require("fau.plugins.editor.snacks.input"),
    lazygit      = require("fau.plugins.editor.snacks.lazygit"),
    notifier     = require("fau.plugins.editor.snacks.notifier"),
    picker       = require("fau.plugins.editor.snacks.picker"),
    profiler     = { enabled = false, autocmds = true },
    quickfile    = { enabled = false, exclude = { "latex", "gitcommit" } },  -- BUG: Conflicts with treesitter.
    scope        = require("fau.plugins.editor.snacks.scope"),
    scratch      = require("fau.plugins.editor.snacks.scratch"),
    scroll       = require("fau.plugins.editor.snacks.scroll"),
    statuscolumn = require("fau.plugins.editor.snacks.statuscolumn"),
    styles       = require("fau.plugins.editor.snacks.styles"),
    terminal     = {},  -- TODO: QwQ
    toggle       = { enabled = true },
    words        = require("fau.plugins.editor.snacks.words"),
    zen          = require("fau.plugins.editor.snacks.zen"),
  },

  -- =============================================
  -- ========== Configuration
  -- =============================================
  config = function(_, opts)
    require("snacks").setup(opts)

    -- ==================== Picker ====================
    -- HACK: Remove std_data path from default config.
    Snacks.picker.sources.recent.filter.paths = { [vim.fn.stdpath("cache")] = false, [vim.fn.stdpath("state")] = false }


    -- ==================== Buffer Remove ====================
    fvim.utils._buf_remove = Snacks.bufdelete.delete


    -- ==================== Rename (LSP) ====================
    -- REF: https://github.com/folke/snacks.nvim/blob/main/docs/rename.md#nvim-tree
    local prev = { new_name = "", old_name = "" }  -- Prevents duplicate events
    vim.api.nvim_create_autocmd("User", {
      pattern = "NvimTreeSetup",
      callback = function()
        local events = require("nvim-tree.api").events
        events.subscribe(events.Event.NodeRenamed, function(data)
          if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
            data = data
            Snacks.rename.on_rename_file(data.old_name, data.new_name)
          end
        end)
      end,
    })


    -- ==================== Notification ====================
    -- Global debug functions.
    _G.dd = function(...) Snacks.debug.inspect(...) end
    _G.bt = function() Snacks.debug.backtrace() end
    ---@diagnostic disable-next-line: duplicate-set-field
    if vim.fn.has("nvim-0.11") == 1 then vim._print = function(_, ...) dd(...) end else vim.print = dd end


    -- ==================== Toggle ====================
    Snacks.toggle.dim():map("<LEADER><LEADER>t")
    Snacks.toggle.zen():map("<LEADER><LEADER>z")
    Snacks.toggle.inlay_hints():map("<LEADER>lh")
    Snacks.toggle.diagnostics():map("<LEADER>lv")
  end,

  -- =============================================
  -- ========== Keymaps
  -- =============================================
  keys = {
    -- ==================== Words ====================
    {
      mode = { "n", "i" }, "<A-n>",
      function()
        if Snacks.words.is_enabled() then Snacks.words.jump(1,  true)
        else fvim.notify("Snacks.words is disabled", vim.log.levels.WARN)
        end
      end,
      desc = "Snacks.words: Next"
    },
    {
      mode = { "n", "i" }, "<A-N>",
      function()
        if Snacks.words.is_enabled() then Snacks.words.jump(-1,  true)
        else fvim.notify("Snacks.words is disabled", vim.log.levels.WARN)
        end
      end,
      desc = "Snacks.words: Prev",
    },

    -- ==================== Gitbrowse ====================
    { "<LEADER>gB", function() Snacks.gitbrowse.open() end, desc = "Git Browse", mode = { "n", "x" } },


    -- ==================== Lazygit ====================
    -- { "<LEADER>gg", function() Snacks.lazygit() end, desc = "Lazygit" },


    -- ==================== Scratch ====================
    { "<LEADER><LEADER>s", function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
    { "<LEADER><LEADER>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },


    -- ==================== Picker ====================
    -- Top Pickers
    { "<LEADER><LEADER>f", function() Snacks.picker() end, desc = "Pickers" },

    -- { "<LEADER>F",  function() Snacks.picker.files() end,    desc = "Find Files" },
    { "<LEADER>ff", function() Snacks.picker.smart() end,    desc = "Picker: Smart Find Files" },
    { "<LEADER>fb", function() Snacks.picker.buffers() end,  desc = "Picker: Buffers" },
    { "<LEADER>fr", function() Snacks.picker.recent() end,   desc = "Picker: Recent" },
    { "<LEADER>fp", function() Snacks.picker.projects() end, desc = "Picker: Projects" },

    { "<LEADER>F",  function() Snacks.picker.lines() end, desc = "Picker: Buffer Lines" },
    { "<LEADER>fs", function() Snacks.picker.grep() end, desc = "Picker: Grep" },
    { "<LEADER>fS", function() Snacks.picker.grep_word() end, mode = { "n", "x" }, desc = "Picker: Grep Word" },

    { "<LEADER>fn", function() Snacks.picker.notifications() end, desc = "Picker: Notifications" },
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
      desc = "Picker: TODO Comments"
    },

    { "<LEADER>fa", function() Snacks.picker.autocmds() end, desc = "Picker: Autocmds" },
    { "<LEADER>fc", function() Snacks.picker.command_history() end, desc = "Picker: Command History" },
    { "<LEADER>fC", function() Snacks.picker.commands() end, desc = "Picker: Commands" },

    { "<LEADER>fe", function()
      if vim.fn.executable("conda") == 1 then Snacks.picker("conda")
      else vim.notify("Conda is not installed.", vim.log.levels.WARN) end
    end, desc = "Picker: Conda Environments", ft = { "python" } },

    { "<LEADER>fh", function() Snacks.picker.help() end, desc = "Picker: Help Pages" },
    { "<LEADER>fH", function() Snacks.picker.highlights() end, desc = "Picker: Highlights" },
    { "<LEADER>fi", function() Snacks.picker.icons() end, desc = "Picker: Icons" },
    { "<LEADER>fj", function() Snacks.picker.jumps() end, desc = "Picker: Jumps" },
    { "<LEADER>fk", function() Snacks.picker.keymaps() end, desc = "Picker: Keymaps" },

    { "<LEADER>fP", function() Snacks.picker.lazy() end, desc = "Picker: Search Plugins" },
    { "<LEADER>fR", function() Snacks.picker.resume() end, desc = "Picker: Resume" },

    { "<LEADER>fll", function() Snacks.picker.git_log_line() end, desc = "Picker: Git Log Line" },
    { "<LEADER>flf", function() Snacks.picker.git_log_file() end, desc = "Picker: Git Log File" },

    { "<LEADER>flc", function() Snacks.picker.lsp_config() end, desc = "Picker: LSP Config" },
    { "<LEADER>fld", function() Snacks.picker.lsp_definitions() end, desc = "Picker: Definition" },
    { "<LEADER>flD", function() Snacks.picker.lsp_declarations() end, desc = "Picker: Declaration" },
    { "<LEADER>flI", function() Snacks.picker.lsp_implementations() end, desc = "Picker: Implementation" },
    { "<LEADER>flr", function() Snacks.picker.lsp_references() end, desc = "Picker: References" },
    { "<LEADER>flt", function() Snacks.picker.lsp_type_definitions() end, desc = "Picker: Type Definition" },
    { "<LEADER>fli", function() Snacks.picker.lsp_incoming_calls() end, desc = "Picker: Incoming Calls" },
    { "<LEADER>flo", function() Snacks.picker.lsp_outgoing_calls() end, desc = "Picker: Outgoing Calls" },

    { "<LEADER>ls", function() Snacks.picker.lsp_symbols() end, desc = "Picker: LSP Symbols" },
    { "<LEADER>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Picker: LSP Workspace Symbols" },

    { "z=", function() Snacks.picker.spelling() end, desc = "Picker: Spelling Suggestions" },
  },
}
