return {
  -- =============================================
  -- ========== General
  -- =============================================
  builtin = {
    theme        = "dropdown",
    initial_mode = "insert",
    previewer = false,

    include_extensions = true,   ---@type boolean
    use_default_opts   = false,  ---@type boolean
  },

  resume = {
    cache_index = 1,  ---@type number what picker to resume, where 1 denotes most recent
  },

  pickers = { initial_mode = "normal" },

  planets = {
    initial_mode = "normal",

    show_pluto = true,  ---@type boolean
    show_moon  = true,  ---@type boolean
  },

  symbols = { initial_mode = "normal" },

  -- spell_suggest = {},



  -- =============================================
  -- ========== Neovim
  -- =============================================
  autocommands = { layout_strategy = "vertical", initial_mode = "insert" },

  commands = {
    layout_strategy = "horizontal",
    initial_mode    = "insert",

    show_buf_command = true,  ---@type boolean
  },

  quickfix = {
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
  },
  quickfixhistory = {},

  loclist = {
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
  },

  help_tags = {
    layout_strategy = "vertical",
    initial_mode    = "insert",
  },

  marks = {
    file_encoding = nil,  ---@type string
    mark_type = "all",  ---@type "all"|"global"|"local"
  },

  registers = {},

  colorscheme = {
    enable_preview = true,  ---@type boolean
    ignore_builtins = false,  ---@type boolean
  },

  keymaps = {
    layout_strategy = "horizontal",

    modes = { "n", "i", "c", "x" },  ---@type table
    show_plug = true,  ---@type boolean
    only_buf = false,  ---@type boolean
    lhs_filter = nil,  ---@type function
    filter = nil,  ---@type function
  },

  highlights = { layout_strategy = "horizontal", initial_mode = "insert" },

  current_buffer_tags = {
    ctags_file     = nil,    ---@type string
    show_line      = true,   ---@type boolean
    only_sort_text = false,  ---@type boolean
    fname_width    = nil,    ---@type number
  },

  tagstack = {
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
  },

  jumplist = {
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
  },

  -- command_history = { filter_fn = nil },
  -- search_history = {},
  -- vim_options = {},
  -- man_pages = {},
  -- reloader = {},
  -- filetypes = {},



  -- =============================================
  -- ========== Files
  -- =============================================
  find_files = {
    theme        = "dropdown",
    initial_mode = "insert",
    previewer = false,

    find_command = { "fd", "--type", "file" },
    file_entry_encoding = nil,  ---@type string encoding of output of `find_command`

    search_dirs = nil,  ---@type table
    search_file = nil,  ---@type string

    follow = true,  ---@type boolean follows symlinks
    hidden = true,  ---@type boolean determines whether to show hidden files
    no_ignore = false,  ---@type boolean show files ignored by `.gitignore`
    no_ignore_parent = false,  ---@type boolean show files ignored by `.gitignore` in parent dirs
    file_encoding = nil,  ---@type string
  },

  oldfiles = {
    theme        = "dropdown",
    initial_mode = "normal",

    cwd_only = false,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  buffers = {
    theme        = "dropdown",
    initial_mode = "normal",

    show_all_buffers = true,  ---@type boolean
    ignore_current_buffer = false,  ---@type boolean
    cwd_only = false,  ---@type boolean
    sort_lastused = false,  ---@type boolean
    sort_mru = false,  ---@type boolean
    bufnr_width = nil,  ---@type number default: dynamic
    file_encoding = nil,  ---@type string
    sort_buffers = nil,  ---@type function
    select_current = false,  ---@type boolean
  },



  -- =============================================
  -- ========== Grep Text
  -- =============================================
  grep_string = {
    layout_strategy = "vertical",
    initial_mode    = "normal",

    grep_open_files = nil,  ---@type boolean
    search_dirs     = nil,  ---@type table

    -- TODO: Use a input box to get the search pattern.
    glob_pattern = nil,  ---@type string|table
    type_filter  = nil,  ---@type string

    ---@type function|table
    additional_args = { "--hidden" },
    max_results = nil,  ---@type number
    disable_coordinates = nil,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  live_grep = {
    layout_strategy = "vertical",
    initial_mode    = "insert",

    -- TODO: Use a input box to get the search pattern.
    grep_open_files = nil,  ---@type boolean
    search_dirs     = nil,  ---@type table

    use_regex = true,  ---@type boolean
    word_match = nil,  ---@type string can be set to `-w` to enable exact word matches

    ---@type function|table
    additional_args = { "--hidden" },
    disable_coordinates = nil,  ---@type boolean
    only_sort_text = false,  ---@type boolean  only sort the text, not the file, line or row
    file_encoding = nil,  ---@type string
  },

  -- TODO: QAQ?
  treesitter = {
    show_line = true,  ---@type boolean
    bufnr = nil,  ---@type number default: current buffer
    symbol_width = nil,  ---@type number defalut: 25

    symbols = nil,  ---@type string|table filter results by symbol kind(s)
    ignored_symbols = nil,  ---@type string|table list of symbol kind(s) to ignore

    symbol_highlights = nil,  ---@type table<string,string>

    file_encoding = nil,  ---@type string
  },

  current_buffer_fuzzy_find = {
    skip_empty_lines = true,  ---@type boolean
    results_ts_highlight = true,  ---@type boolean
    file_encoding = nil,  ---@type string
  },



  -- =============================================
  -- ========== LSP
  -- =============================================
  lsp_definitions = {
    layout_strategy = "bottom_pane",
    initial_mode    = "normal",

    jump_type = "never",  ---@type "tab"|"tab drop"|"split"|"vsplit"|"never"
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
    reuse_win = false,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  lsp_type_definitions = {
    layout_strategy = "bottom_pane",
    initial_mode    = "normal",

    jump_type = "never",  ---@type "tab"|"tab drop"|"split"|"vsplit"|"never"
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
    reuse_win = false,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  lsp_implementations = {
    layout_strategy = "bottom_pane",
    initial_mode    = "normal",

    jump_type = "never",  ---@type "tab"|"tab drop"|"split"|"vsplit"|"never"
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
    reuse_win = false,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  lsp_references = {
    theme        = "cursor",
    initial_mode = "normal",

    include_declaration  = true,  ---@type boolean
    include_current_line = true,  ---@type boolean
    jump_type = "never",  ---@type "tab"|"tab drop"|"split"|"vsplit"|"never"
    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
    reuse_win = false,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  lsp_incoming_calls = {
    layout_strategy = "bottom_pane",
    initial_mode    = "normal",

    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  lsp_outgoing_calls = {
    layout_strategy = "bottom_pane",
    initial_mode    = "normal",

    show_line = true,  ---@type boolean
    trim_text = false,  ---@type boolean
    file_encoding = nil,  ---@type string
  },

  lsp_document_symbols = {
    layout_strategy = "horizontal",
    initial_mode    = "normal",

    fname_width = nil,  ---@type number
    symbol_width = nil,  ---@type number
    symbol_type_width = nil,  ---@type number
    show_line = true,  ---@type boolean
    symbols = nil,  ---@type string|table
    ignore_symbols = nil,  ---@type string|table
    symbol_highlights = nil,  ---@type table
    file_encoding = nil,  ---@type string
  },

  lsp_workspace_symbols = {
    layout_strategy = "horizontal",
    initial_mode    = "normal",

    fname_width = nil,  ---@type number
    symbol_width = nil,  ---@type number
    symbol_type_width = nil,  ---@type number
    show_line = true,  ---@type boolean
    symbols = nil,  ---@type string|table
    ignore_symbols = nil,  ---@type string|table
    symbol_highlights = nil,  ---@type table
    file_encoding = nil,  ---@type string
  },

  lsp_dynamic_workspace_symbols = {
    initial_mode = "insert",

    fname_width = nil,  ---@type number
    show_line = true,  ---@type boolean
    symbols = { "class", "function" },  ---@type string|table
    ignore_symbols = nil,  ---@type string|table
    symbol_highlights = nil,  ---@type table
    file_encoding = nil,  ---@type string
  },

  diagnostics = {
    layout_strategy = "bottom_pane",
    initial_mode    = "normal",

    severity = nil,  ---@type string|number
    severity_limit = vim.log.levels.WARN,  ---@type string|number
    severity_bound = nil,  ---@type string|number
    root_dir = nil,  ---@type string|number
    no_unlisted = nil,  ---@type boolean
    no_sign = false,  ---@type boolean
    line_width = nil,  ---@type string|number|"full"
    namespace = nil,  ---@type number
    disable_coordinates = false,  ---@type boolean
    sort_by = "buffer",  ---@type string
  },



  -- =============================================
  -- ========== Git
  -- =============================================
  git_files = {
    use_file_path = false,  ---@type boolean if we should use the current buffer git root
    use_git_root  = true,   ---@type boolean if we should use git root as cwd or the cwd (important for submodule)

    show_untracked     = false,  ---@type boolean
    recurse_submodules = false,  ---@type boolean

    git_command   = nil,  ---@type table
    file_encoding = nil,  ---@type string
  },

  git_commits = {
    use_file_path = false,  ---@type boolean if we should use the current buffer git root
    use_git_root  = true,   ---@type boolean if we should use git root as cwd or the cwd (important for submodule)
    git_command   = nil,    ---@type table
  },

  git_bcommits = {
    use_file_path = false,  ---@type boolean if we should use the current buffer git root
    use_git_root  = true,   ---@type boolean if we should use git root as cwd or the cwd (important for submodule)
    current_file  = nil,    ---@type string specify the current file that should be used for bcommits
    git_command   = nil,    ---@type table
  },

  git_bcommits_range = {
    use_git_root  = true,  ---@type boolean if we should use git root as cwd or the cwd (important for submodule)
    current_file  = nil,  ---@type string specify the current file that should be used for bcommits
    git_command   = nil,  ---@type table
  },

  git_branches = {
    use_file_path = false,  ---@type boolean if we should use the current buffer git root
    use_git_root  = true,   ---@type boolean if we should use git root as cwd or the cwd (important for submodule)
    show_remote_tracking_branches = true,  ---@type boolean show remote tracking branches like origin/main
  },

  git_status = {
    use_file_path = false,  ---@type boolean if we should use the current buffer git root
    use_git_root  = true,   ---@type boolean if we should use git root as cwd or the cwd (important for submodule)
    git_icons     = nil,    ---@type table
    expand_dir    = true,   ---@type boolean
  },

  git_stash = {
    use_file_path = false,  ---@type boolean if we should use the current buffer git root
    use_git_root  = true,   ---@type boolean if we should use git root as cwd or the cwd (important for submodule)
    show_branch   = true,   ---@type boolean
  },

}
