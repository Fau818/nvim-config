local M = {}


---@type snacks.win.Config
M.normal_preview = { minimal = false, wo = { foldenable = true, foldcolumn = "auto" }, w = { snacks_indent = true } }
---@type snacks.win.Config
M.minimal_preview = { minimal = true, wo = { foldenable = false, foldcolumn = "1" }, w = { snacks_indent = false } }

function M.default_layout() return vim.o.columns >= 120 and "default" or "dropdown" end
function M.normal_mode() vim.cmd.stopinsert() end

---@type snacks.picker.Config
M.lsp_action = { layout = { preset = "stack_rev" }, on_show = M.normal_mode, win = { preview = M.minimal_preview }, auto_confirm = false }

---@type snacks.picker.Config
M.classic_normal = { layout = { preset = M.default_layout }, on_show = M.normal_mode, win = { preview = M.minimal_preview } }


---@type snacks.picker.Action.fn
function M.open_float(picker, item, action)
  local prev_buf = picker.preview.win.buf
  if not prev_buf then fvim.notify("No preview buffer", vim.log.levels.ERROR) return end

  local new_buf = vim.api.nvim_create_buf(false, true)
  ---@diagnostic disable-next-line: param-type-mismatch
  local lines = vim.api.nvim_buf_get_lines(prev_buf, 0, -1, false)
  -- Add padding to each line.
  -- lines = vim.tbl_map(function(x) return string.format(" %s ", x) end, lines)
  -- Copy lines to new buffer.
  vim.api.nvim_buf_set_lines(new_buf, 0, -1, false, lines)

  -- Get text size.
  local text_height = #lines
  local text_width = math.max(unpack(vim.tbl_map(function(x) return #x end, lines)))

  -- Get UI size.
  local ui = vim.api.nvim_list_uis()[1]
  local win_height = math.ceil(math.min(text_height, ui.height*0.75))
  local win_width  = math.ceil(math.min(text_width, ui.width*0.8))

  local win = Snacks.win({
    show = false,
    fixbuf = true,
    minimal = true,
    border = "rounded",

    relative = "editor",
    position = "float",
    width = win_width,
    height = win_height,

    buf = new_buf,

    bo = { modifiable = false, filetype = picker.preview.item.preview.ft },
    wo = { conceallevel = 3, concealcursor = "nvic", spell = false },

    title = " Notification ",
    title_pos = "center",

    keys = { q = "close" },
    footer_pos = "center",
    footer_keys = true,
  })

  win:add_padding()
  win:show()

  picker:close()
end


return M
