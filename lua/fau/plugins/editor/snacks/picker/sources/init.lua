local preset = require("fau.plugins.editor.snacks.picker.sources.preset")

---@type snacks.picker.sources.Config|{}|table<string, snacks.picker.Config|{}>
return {
  conda = vim.fn.executable("conda") == 1 and require("fau.plugins.editor.snacks.picker.sources.conda").conda_picker or {},
  autocmds = { layout = { preset = "telescope" }, on_show = preset.normal_mode, win = { preview = preset.minimal_preview } },

  buffers = { layout = { preset = "stack" }, on_show = preset.normal_mode, win = { preview = preset.normal_preview } },

  -- cliphist = {},
  -- colorschemes = {},

  commands        = { layout = { preset = "stack_rev" }, win = { preview = preset.minimal_preview } },
  command_history = { layout = { preset = "vscode" } },

  -- diagnostics = {},
  -- diagnostics_buffer = {},
  -- explorer = {},

  files = { layout = { preset = preset.default_layout }, hidden = true, follow = true, regex = false, win = { preview = preset.minimal_preview } },

  -- git_branches = {},
  -- git_diff = {},
  -- git_files = {},
  -- git_grep = {},
  -- git_log = {},
  -- git_log_file = {},
  -- git_log_line = {},
  -- git_stash = {},
  -- git_status = {},

  grep = {
    layout = { preset = "stack_rev" },
    win = { preview = preset.normal_preview },
    hidden = true,
    follow = true,
    regex  = false,
    args = { "--ignore-file", ("%s/git/ignore"):format(fvim.xdg_config_home) },
  },
  -- grep_buffers = { hidden = true, layout = "stack_rev", win = { preview = preset.normal_preview } },
  -- grep_word    = { hidden = true, layout = "stack_rev", win = { preview = preset.normal_preview } },

  help = { layout = { preset = "stack_rev" }, regex = false, win = { preview = preset.minimal_preview } },
  highlights = { layout = { preset = "telescope" }, confirm = preset.open_float, win = { preview = preset.minimal_preview } },

  icons = { confirm = "paste" },

  -- jumps = {},

  -- NOTE: <A-g> and <A-b> are mapped to go to toggle global and buffer keymaps.
  keymaps = { layout = { preset = preset.default_layout }, on_show = preset.normal_mode, win = { preview = preset.minimal_preview } },

  lazy = { layout = { preset = preset.default_layout }, regex = false, win = { preview = preset.minimal_preview } },

  lines = { layout = { preset = "main" }, regex = false, win = { preview = preset.normal_preview } },

  -- loclist = {},

  lsp_config           = { layout = { preset = preset.default_layout }, on_show   = preset.normal_mode, win = { preview = preset.minimal_preview } },
  lsp_declarations     = preset.lsp_action,
  lsp_definitions      = preset.lsp_action,
  lsp_type_definitions = preset.lsp_action,
  lsp_implementations  = preset.lsp_action,
  lsp_references       = preset.lsp_action,
  lsp_incoming_calls   = preset.lsp_action,
  lsp_outgoing_calls   = preset.lsp_action,

  lsp_symbols = { layout = { preset = preset.default_layout }, win = { preview = preset.minimal_preview } },
  lsp_workspace_symbols = { layout = { preset = preset.default_layout }, on_show = preset.normal_mode },

  -- man = {},
  -- martks = {},

  notifications = { on_show = preset.normal_mode, confirm = preset.open_float, win = { preview  = preset.minimal_preview } },

  pickers = { layout = { preset = preset.default_layout }, win = { preview = preset.minimal_preview } },
  picker_actions = preset.classic_normal,
  picker_format  = preset.classic_normal,
  picker_layouts = preset.classic_normal,
  picker_preview = preset.classic_normal,

  projects = { layout = { preset = preset.default_layout }, regex = false, on_show = preset.normal_mode, win = { preview = preset.minimal_preview } },

  -- qlist = {},

  recent = { layout = { preset = preset.default_layout }, hidden = true, follow = true, regex = false, on_show = preset.normal_mode, win = { preview = preset.minimal_preview } },

  -- registers = {},
  -- resume = {},
  scratch = { layout = { preset = preset.default_layout }, on_show = preset.normal_mode, win = { preview = preset.minimal_preview } },

  -- search_history = {},
  select = { layout = { preset = "select" }, regex = false, on_show = preset.normal_mode },
  spelling = { layout = { preset = "vscode" }, on_show = preset.normal_mode },
  smart = { layout = { preset = preset.default_layout }, hidden = true, follow = true, regex = false, supports_live = true, win = { preview = preset.minimal_preview } },

  -- tags = {},
  -- treesitter = {},
  -- undo = {},
  -- zoxide = {},

  -- ==================== Custom ====================
  todo_comments = { on_show = preset.normal_mode },
}
