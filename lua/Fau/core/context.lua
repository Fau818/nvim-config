-- =============================================
-- ========== Plugin Loading
-- =============================================
local context_ok, context = pcall(require, "treesitter-context")
if not context_ok then Fau_vim.load_plugin_error("treesitter-context") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  enable = true,                  -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0,                  -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,          -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20,       -- Maximum number of lines to collapse for a single context line
  trim_scope = "outer",           -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = "topline",               -- Line used to calculate context. Choices: 'cursor', 'topline'
  separator = nil,
  zindex = 20,                    -- The Z-index of the context window
}


context.setup(config)
