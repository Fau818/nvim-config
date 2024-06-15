-- =============================================
-- ========== Plugin Loading
-- =============================================
local todo_comments_ok, todo_comments = pcall(require, "todo-comments")
if not todo_comments_ok then Fau_vim.load_plugin_error("todo-comments") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type TodoConfig
local config = {
  signs = true, -- show icons in the signs column
  sign_priority = 8, -- sign priority
  -- keywords recognized as todo comments

  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "error", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO      = { icon = Fau_vim.icons.todo.TODO,      color = "todo", alt = { "TASK", "QUES", "QUESTION" } },
    HACK      = { icon = Fau_vim.icons.todo.HACK,      color = "warning" },
    WARN      = { icon = Fau_vim.icons.todo.WARN,      color = "warning", alt = { "WARNING" } },
    PERF      = { icon = Fau_vim.icons.todo.PERF,      color = "default", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE      = { icon = Fau_vim.icons.todo.NOTE,      color = "info", alt = { "INFO", "HINT" } },
    TEST      = { icon = Fau_vim.icons.todo.TEST,      color = "test", alt = { "TESTING", "PASSED", "FAILED", "TEMP" } },
    Fau       = { icon = Fau_vim.icons.todo.Fau,       color = Fau_vim.colors.cobalt },
    DESC      = { icon = Fau_vim.icons.todo.DESC,      color = "desc" },
    SEE       = { icon = Fau_vim.icons.todo.BOOK,      color = "see" },
    EXIT      = { icon = Fau_vim.icons.todo.EXIT,      color = "exit", alt = { "RETURN", "CASE" } },
    ASSERT    = { icon = Fau_vim.icons.todo.ASSERT,    color = "assert" },
    IMPORTANT = { icon = Fau_vim.icons.todo.IMPORTANT, color = "important", alt = { "IMPO" } },
    SPEC      = { icon = Fau_vim.icons.todo.SPEC,      color = "special", alt = { "SP" } },
  },


  gui_style = {
    fg = "NONE", -- The gui style to use for the fg highlight group.
    bg = "BOLD", -- The gui style to use for the bg highlight group.
  },

  merge_keywords = false, -- if false, only use defined in `keywords` option

  highlight = {
    multiline = true, -- enable multine todo comments
    multiline_pattern = "^\\", -- lua pattern to match the next multiline from the start of the matched keyword
    multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
    before  = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
    after   = "fg", -- "fg" or "bg" or empty
    -- pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
    pattern = [[\ (KEYWORDS)\s*\d*(\.\d*)*\s*:]],
    comments_only = true, -- uses treesitter to match keywords in comments only
    max_line_len = 400, -- ignore lines longer than this
    exclude = {}, -- list of file types to exclude highlighting
  },

  colors = {
    todo      = { "#39CC8F" },
    info      = { "DiagnosticInfo" },
    warning   = { "DiagnosticWarn", "WarningMsg" },
    error     = { "DiagnosticError", "ErrorMsg", "#DC2626" },
    hint      = { "DiagnosticHint", "#10B981" },
    default   = { "Identifier" },
    test      = { "#FFC8E1" },
    desc      = { "#A9B1D6" },
    see       = { "#87CEEB" },
    exit      = { "#4169E1" },
    -- case      = { "#2563EB" },
    assert    = { "#FBBF24" },
    important = { "#DC2626" },
    special   = { "#5C8DBC" },
  },

  search = {
    command = "rg",
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
    -- regex that will be used to match keywords.
    -- don't replace the (KEYWORDS) placeholder
    pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
  },
}


todo_comments.setup(config)
