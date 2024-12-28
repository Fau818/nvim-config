return {
  sorting_strategy   = "descending",  ---@type "descending"|"ascending"
  selection_strategy = "reset",  ---@type "reset"|"follow"|"row"|"closest"|"none"
  scroll_strategy    = "cycle",  ---@type "cycle"|"limit"
  layout_strategy    = "horizontal",

  create_layout = nil,
  layout_config = require("Fau.configs.editor.ui.telescope.config.defaults.layouts"),
  -- Determines the layouts to cycle through when using `actions.layout.cycle_layout_next` and `actions.layout.cycle_layout_prev`.
  cycle_layout_list = { "horizontal", "vertical" },

  winblend = 0,
  wrap_results = false,
  hl_result_eol = true,

  prompt_prefix   = Fau_vim.icons.ui.telescope .. " ",
  selection_caret = Fau_vim.icons.ui.selection_caret .. " ",
  entry_prefix    = "  ",
  multi_icon      = Fau_vim.icons.ui.multiple .. " ",

  initial_mode = "normal",  ---@type "insert"|"normal"
  path_display = { "smart" },

  get_status_text = nil,  -- Use default.

  border = true,
  borderchars = nil,  -- Use default.

  dynamic_preview_title = true,
  results_title = "Results",
  prompt_title  = "Prompt",

  default_mappings = nil,
  mappings = require("Fau.configs.editor.ui.telescope.config.defaults.mappings"),

  history = {
    path = nil,  -- Use default `stdpath("data")/telescope_history`.
    limit = 100,
    handler = nil,  -- Use default.
    cycle_wrap = false,
  },

  cache_picker = nil,  -- Use default.

  preview = {
    check_mime_type = true,
    filesize_limit  = 2,  -- in MiB
    highlight_limit = 1,  -- in MiB
    timeout = 250,
    treesitter = true,
    msg_bg_fillchar = nil,  -- Use default.
    hide_on_startup = false,
    ls_short = nil,  -- Use default.
  },

  vimgrep_arguments = nil,  -- Use default.

  -- Set an environment for term_previewer.
  set_env = nil,

  color_devicons = true,

  file_sorter      = nil,  -- Use default.
  generic_sorter   = nil,  -- Use default.
  prefilter_sorter = nil,  -- Use default.

  tiebreak = nil,  -- Use default.

  file_ignore_patterns = Fau_vim.file.ignored_pattern,

  get_selection_window = nil,  -- Use default.

  git_worktrees = nil,  -- Use default.

  file_previewer         = nil,  -- Use default.
  grep_previewer         = nil,  -- Use default.
  qflist_previewer       = nil,  -- Use default.
  buffer_previewer_maker = nil,  -- Use default.
}
