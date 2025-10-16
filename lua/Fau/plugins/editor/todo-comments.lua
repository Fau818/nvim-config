---@type LazySpec
return {
  -- DESC: Highlight the TODO comment-liked things.
  ---@module "todo-comments"
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",

  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TodoTrouble", "TodoTelescope", "TodoFzfLua", "TodoLocList", "TodoQuickFix" },

  ---@type TodoConfig
  opts = {
    signs         = true,  -- show icons in the signs column
    sign_priority = Fau_vim.settings.sign_priority.todo_comments,    -- sign priority

    keywords = {
      TODO = { icon = Fau_vim.icons.todo.TODO, color = Fau_vim.colors.dark_green, alt = { "TASK", "QUES", "QUESTION" } },

      FIX  = { icon = Fau_vim.icons.todo.BUG,  color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      HACK = { icon = Fau_vim.icons.todo.HACK, color = "warn",  alt = { "PATCH", "TRICK" } },
      WARN = { icon = Fau_vim.icons.todo.WARN, color = "warn",  alt = { "WARNING" } },
      IMPO = { icon = Fau_vim.icons.todo.IMPORTANT, color = Fau_vim.colors.red, alt = { "IMPORTANT" } },

      PERF = { icon = Fau_vim.icons.todo.PERF, color = Fau_vim.colors.purple,     alt = { "OPTIM",   "OPTIMIZE", "PERFORMANCE" } },
      TEST = { icon = Fau_vim.icons.todo.TEST, color = Fau_vim.colors.light_pink, alt = { "TESTING", "PASSED",   "FAILED", "TEMP" }},

      NOTE = { icon = Fau_vim.icons.todo.NOTE, color = "note", alt = { "INFO", "HINT", "TIPS" } },
      DESC = { icon = Fau_vim.icons.todo.DESC, color = Fau_vim.colors.light_gray },
      SEE  = { icon = Fau_vim.icons.todo.BOOK, color = Fau_vim.colors.wathet, signs = true },
      Fau  = { icon = Fau_vim.icons.todo.Fau,  color = Fau_vim.colors.cobalt },

      EXIT   = { icon = Fau_vim.icons.todo.EXIT,   color = Fau_vim.colors.dark_blue, alt = { "RETURN", "CASE" } },
      ASSERT = { icon = Fau_vim.icons.todo.ASSERT, color = Fau_vim.colors.orange_yellow },
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
      note = "DiagnosticInfo",
      error = "DiagnosticError",
      warn  = "DiagnosticWarn",
    },

    search = {
      command = "rg",
      args    = nil,  -- Use default.
      pattern = nil,  -- Use default.
    },
  },
}
