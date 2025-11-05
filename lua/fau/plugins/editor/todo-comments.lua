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
    sign_priority = fvim.settings.sign_priority.todo_comments,    -- sign priority

    keywords = {
      TODO = { icon = fvim.icons.todo.TODO, color = fvim.colors.dark_green, alt = { "TASK", "QUES", "QUESTION" } },

      FIX  = { icon = fvim.icons.todo.BUG,  color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      HACK = { icon = fvim.icons.todo.HACK, color = "warn",  alt = { "PATCH", "TRICK" } },
      WARN = { icon = fvim.icons.todo.WARN, color = "warn",  alt = { "WARNING" } },
      IMPO = { icon = fvim.icons.todo.IMPORTANT, color = fvim.colors.red, alt = { "IMPORTANT" } },

      PERF = { icon = fvim.icons.todo.PERF, color = fvim.colors.purple,     alt = { "OPTIM",   "OPTIMIZE", "PERFORMANCE" } },
      TEST = { icon = fvim.icons.todo.TEST, color = fvim.colors.light_pink, alt = { "TESTING", "PASSED",   "FAILED", "TEMP" }},

      NOTE = { icon = fvim.icons.todo.NOTE, color = "note", alt = { "INFO", "HINT", "TIPS" } },
      DESC = { icon = fvim.icons.todo.DESC, color = fvim.colors.light_gray },
      SEE  = { icon = fvim.icons.todo.BOOK, color = fvim.colors.wathet, signs = true, alt = { "REF", "LINK" } },
      Fau  = { icon = fvim.icons.todo.Fau,  color = fvim.colors.cobalt },

      EXIT   = { icon = fvim.icons.todo.EXIT,   color = fvim.colors.dark_blue, alt = { "RETURN", "CASE" } },
      ASSERT = { icon = fvim.icons.todo.ASSERT, color = fvim.colors.orange_yellow },
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

      exclude = fvim.file.excluded_filetypes,
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
