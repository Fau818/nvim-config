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
  if not item then fvim.notify("No item selected", vim.log.levels.ERROR) return end

  local content = item.preview.text or "No content to display"
  local lines = vim.split(content, "\n")
  local text_width = math.max(1, unpack(vim.tbl_map(vim.fn.strdisplaywidth, lines))) + 2
  local text_height = #lines

  local win = Snacks.win({
    text = content,
    fixbuf = true,
    minimal = true,
    border = "rounded",

    relative = "editor",
    position = "float",
    width  = function(self) return math.ceil(math.min(text_width, vim.o.columns * 0.8)) end,
    height = function(self) return math.ceil(math.min(text_height, vim.o.lines * 0.75)) end,
    resize = true,

    bo = { modifiable = false, filetype = item.preview.ft or "markdown" },
    wo = { conceallevel = 3, concealcursor = "nvic", spell = false, statuscolumn = " " },  -- NOTE: `statuscolumn = " "` is for padding left.

    title = " Notification ",
    footer_keys = true,
  })

  picker:close()
end


return M
