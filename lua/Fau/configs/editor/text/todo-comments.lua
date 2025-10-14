-- =============================================
-- ========== Plugin Configurations
-- =============================================
local todo_comments = require("todo-comments")

---@type TodoConfig
local config = {
  signs         = true,  -- show icons in the signs column
  sign_priority = Fau_vim.settings.sign_priority.todo_comments,    -- sign priority

  keywords = {
    FIX       = { icon = Fau_vim.icons.todo.BUG,       color = "error",     alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, signs = true },
    HACK      = { icon = Fau_vim.icons.todo.HACK,      color = "warn" },
    WARN      = { icon = Fau_vim.icons.todo.WARN,      color = "warn",      alt = { "WARNING" } },
    PERF      = { icon = Fau_vim.icons.todo.PERF,      color = "perf",      alt = { "OPTIM", "OPTIMIZE", "PERFORMANCE" } },
    TEST      = { icon = Fau_vim.icons.todo.TEST,      color = "test",      alt = { "TESTING", "PASSED", "FAILED", "TEMP" } },

    TODO      = { icon = Fau_vim.icons.todo.TODO,      color = "todo",      alt = { "TASK", "QUES", "QUESTION" } },
    NOTE      = { icon = Fau_vim.icons.todo.NOTE,      color = "note",      alt = { "INFO", "HINT", "TIPS" } },
    Fau       = { icon = Fau_vim.icons.todo.Fau,       color = "Fau" },

    DESC      = { icon = Fau_vim.icons.todo.DESC,      color = "desc" },
    SEE       = { icon = Fau_vim.icons.todo.BOOK,      color = "see" },

    EXIT      = { icon = Fau_vim.icons.todo.EXIT,      color = "exit",      alt = { "RETURN", "CASE" } },
    ASSERT    = { icon = Fau_vim.icons.todo.ASSERT,    color = "assert" },
    IMPORTANT = { icon = Fau_vim.icons.todo.IMPORTANT, color = "important", alt = { "IMPO" } },
  },

  gui_style = { fg = "NONE", bg = "BOLD" },

  merge_keywords = false,  -- The default keywords are defined manually.
  highlight = {
    multiline         = true,
    multiline_pattern = "^\\",
    multiline_context = 10,

    before  = "",      ---@type "fg" | "bg" | ""
    keyword = "wide",  ---@type "fg" | "bg" | "wide" | "wide_bg" | "wide_fg" | ""
    after   = "fg",    ---@type "fg" | "bg" | ""

    pattern       = [[\ ((KEYWORDS)\s?(\d+\.?)*)\s*:]],  -- Default: [[.*<(KEYWORDS)\s*:]]
    comments_only = true,
    max_line_len  = 400,

    exclude = Fau_vim.file.excluded_filetypes,
  },

  colors = {
    -- #9370DB  #FF69B4  #FFD700  #6A5ACD  #4682B4  #20B2AA  #BDB76B  #556B2F  #2F4F4F  #8B4513  #B8860B  #4FD6BE
    error = "DiagnosticError",
    warn  = "DiagnosticWarn",
    test  = Fau_vim.colors.light_pink,
    perf  = Fau_vim.colors.purple,


    todo = Fau_vim.colors.dark_green,
    note = "DiagnosticInfo",
    Fau  = Fau_vim.colors.cobalt,

    desc = Fau_vim.colors.light_gray,
    see  = Fau_vim.colors.wathet,

    exit      = Fau_vim.colors.dark_blue,
    assert    = Fau_vim.colors.orange_yellow,
    important = Fau_vim.colors.red,
  },

  search = {
    command = "rg",
    args = nil,  -- Use default.
    pattern = nil,  -- Use default.
  },
}

todo_comments.setup(config)
