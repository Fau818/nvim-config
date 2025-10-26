---@type snacks.win.Config
local normal_preview  = {
  minimal = false,
  wo = { foldenable = true, foldcolumn = "auto" },
  w = { snacks_indent = true },
}
---@type snacks.win.Config
local minimal_preview = {
  minimal = true,
  wo = { foldenable = false, foldcolumn = "1" },
  w = { snacks_indent = false },
}

local function normal_mode() vim.cmd.stopinsert() end


---@type snacks.picker.Action.fn
local function open_float(picker, item, action)
  local prev_buf = picker.preview.win.buf
  if not prev_buf then Fau_vim.notify("No preview buffer", vim.log.levels.ERROR) return end

  local new_buf = vim.api.nvim_create_buf(false, true)
  ---@diagnostic disable-next-line: param-type-mismatch
  local lines = vim.api.nvim_buf_get_lines(prev_buf, 0, -1, false)
  -- Add padding to each line.
  lines = vim.tbl_map(function(x) return string.format(" %s ", x) end, lines)
  -- Copy lines to new buffer.
  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)

  -- Get text size.
  local text_height = #lines
  local text_width = math.max(unpack(vim.tbl_map(function(x) return #x end, lines)))

  -- Get UI size.
  local ui = vim.api.nvim_list_uis()[1]
  local win_height = math.ceil(math.min(text_height, ui.height*0.75))
  local win_width  = math.ceil(math.min(text_width, ui.width*0.8))

  -- Center window.
  local win_row = math.floor((ui.height - win_height) / 2)
  local win_col = math.floor((ui.width - win_width) / 2)

  -- Create floating window.
  local win = vim.api.nvim_open_win(new_buf, true, {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = win_row,
    col = win_col,
    style = "minimal",
    border = "rounded",
  })

  -- Set window and buffer options.
  vim.bo[new_buf].filetype = picker.preview.item.preview.ft
  vim.bo[new_buf].modifiable = false
  vim.wo[win].spell = false
  vim.wo[win].conceallevel = 3
  vim.wo[win].concealcursor = "nciv"

  -- Map 'q' to close the floating window.
  vim.keymap.set("n", "q", "<CMD>q<CR>", { buffer = true })

  picker:close()
end


---@type snacks.picker.sources.Config|{}|table<string, snacks.picker.Config|{}>
return {
  autocmds = { layout = "telescope", on_show = normal_mode, win = { preview = minimal_preview } },

  buffers = { layout = "stack", on_show = normal_mode, win = { preview = normal_preview } },

  -- cliphist = {},
  -- colorschemes = {},

  commands        = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },
  command_history = { layout = "vscode", on_show    = normal_mode },

  -- diagnostics = {},
  -- diagnostics_buffer = {},
  -- explorer = {},

  files = { hidden = true, layout = "default", win = { preview = minimal_preview } },

  -- git_branches = {},
  -- git_diff = {},
  -- git_files = {},
  -- git_grep = {},
  -- git_log = {},
  -- git_log_file = {},
  -- git_log_line = {},
  -- git_stash = {},
  -- git_status = {},

  grep         = { hidden = true, layout = "stack_rev", win = { preview = normal_preview } },
  -- grep_buffers = { hidden = true, layout = "stack_rev", win = { preview = normal_preview } },
  -- grep_word    = { hidden = true, layout = "stack_rev", win = { preview = normal_preview } },

  help = { layout = "stack_rev", win = { preview = minimal_preview } },
  highlights = { layout = { preset = "telescope" }, confirm = open_float, win = { preview = minimal_preview } },

  icons = { confirm = "paste" },

  -- jumps = {},

  -- NOTE: <A-g> and <A-b> are mapped to go to toggle global and buffer keymaps.
  keymaps = { layout = "default", on_show = normal_mode, win = { preview = minimal_preview } },

  lazy = { layout = "default", win = { preview = minimal_preview } },

  lines = {
    layout = "main",
    win = { preview = normal_preview },
    on_show = function(picker)
      Fau_vim.functions.colorscheme.fix_comment_hl(picker.list.win.win)
      Snacks.picker.sources.lines.on_show(picker)  -- NOTE: Call the original on_show
    end,
  },

  -- loclist = {},

  lsp_config           = { layout = "default", on_show   = normal_mode, win = { preview = minimal_preview } },
  lsp_declarations     = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },
  lsp_definitions      = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },
  lsp_type_definitions = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },
  lsp_implementations  = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },
  lsp_references       = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },
  lsp_incoming_calls   = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },
  lsp_outgoing_calls   = { layout = "stack_rev", on_show = normal_mode, win = { preview = minimal_preview } },

  lsp_symbols = { layout = "default", win = { preview = minimal_preview } },
  lsp_workspace_symbols = { layout = "default", on_show = normal_mode },

  -- man = {},
  -- martks = {},

  notifications = { on_show = normal_mode, confirm = open_float, win = { preview  = minimal_preview } },

  picker_actions = { layout = "default", on_show = normal_mode,  win = { preview = minimal_preview } },
  picker_format = { layout = "default", on_show = normal_mode, win = { preview = minimal_preview } },
  picker_layouts = { layout = "default", on_show = normal_mode, win = { preview = minimal_preview } },
  picker_preview = { layout = "default", on_show = normal_mode, win = { preview = minimal_preview } },
  pickers = { layout = "default", win = { preview = minimal_preview } },

  projects = { layout = "default", on_show = normal_mode, win = { preview = minimal_preview } },

  -- qlist = {},

  recent = { hidden = true, layout = "default", on_show = normal_mode, win = { preview = minimal_preview } },

  -- registers = {},
  -- resume = {},
  -- scratch = {},  -- TODO: When you config Snacks.scratch

  -- search_history = {},
  select = { layout = { preset = "select" }, on_show = normal_mode },
  spelling = { layout = "vscode", on_show = normal_mode},
  smart = { hidden = true, supports_live = true, layout = "default", win = { preview = minimal_preview } },

  -- tags = {},
  -- treesitter = {},
  -- undo = {},
  -- zoxide = {},

  -- ==================== Custom ====================
  todo_comments = { on_show = normal_mode },
}
