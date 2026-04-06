---Overrides the "f" surround for nvim-surround with async vim.ui.input
---(snacks.input + LSP completion). Returns nil to abort nvim-surround,
---then inserts manually in the callback.

---Known limitations:
--- - Only works for single-line selections.

local M = {}

--- Open vim.ui.input with LSP clients from the original buffer attached
--- to the snacks_input buffer, so blink.cmp can provide LSP completions.
---@param bufnr integer
---@param opts table  vim.ui.input options (prompt, default, etc.)
---@param callback fun(input: string?)
function M.input_with_lsp(bufnr, opts, callback)
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  vim.ui.input(opts, callback)

  if #clients == 0 then return end

  -- After vim.ui.input returns, snacks_input creates its buffer on the next tick.
  vim.schedule(function()
    local input_buf = vim.api.nvim_get_current_buf()
    if input_buf == bufnr then
      vim.notify("Failed to open input buffer for LSP completion", vim.log.levels.ERROR)
      return
    end

    -- Attach the same LSP clients to the input buffer for completion.
    local attached = {}
    for _, client in ipairs(clients) do
      if vim.lsp.get_client_by_id(client.id) then
        if pcall(vim.lsp.buf_attach_client, input_buf, client.id) then attached[#attached+1] = client.id end
      end
    end

    -- Detach on BufLeave (before buffer is destroyed) to cancel pending
    -- LSP requests and avoid "Invalid buffer id" errors from late responses.
    if #attached > 0 then
      vim.api.nvim_create_autocmd("BufLeave", {
        buffer = input_buf,
        once = true,
        callback = function() for _, id in ipairs(attached) do pcall(vim.lsp.buf_detach_client, input_buf, id) end end,
      })
    end
  end)
end

---Sanitize function name input: trim whitespace and strip trailing "()".
---@param input string?
---@return string
local function sanitize_func_name(input)
  if not input then return "" end
  -- NOTE: Take only the last line (LSP auto-import may prepend import statements).
  local last_line = input:match("[^\n]+$") or input
  local name = vim.trim(last_line)
  return (name:gsub("%(%s*%)$", ""))
end

---Get the selection marks based on nvim-surround's current mode.
---pending_surround == true -> normal mode (operator marks [ ]),
---otherwise -> visual mode (visual marks < >).
---@param bufnr integer
---@return integer[] mark_start {line(1-idx), col(0-idx)}
---@return integer[] mark_end   {line(1-idx), col(0-idx)}
local function get_selection_marks(bufnr)
  local marks = require("nvim-surround").pending_surround and { "[", "]" } or { "<", ">" }
  return vim.api.nvim_buf_get_mark(bufnr, marks[1]), vim.api.nvim_buf_get_mark(bufnr, marks[2])
end

---Find the function name selection at cursor using nvim-surround's own detection
---(TreeSitter @call.outer with pattern fallback, then change.target extraction).
---@return { name: string, row: integer, name_start: integer, name_end: integer }|nil
local function find_func_call_at_cursor()
  local selections = require("nvim-surround.utils").get_nearest_selections("f", "change")
  if not selections or not selections.left then return nil end
  local s = selections.left.first_pos
  local e = selections.left.last_pos
  local row = s[1] - 1
  local name = vim.api.nvim_buf_get_text(0, row, s[2] - 1, e[1] - 1, e[2], {})[1]
  return { name = name, row = row, name_start = s[2] - 1, name_end = e[2] }
end

M.surrounds = {
  ["f"] = {
    add = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local mark_start, mark_end = get_selection_marks(bufnr)

      M.input_with_lsp(bufnr, { prompt = "Function: " }, function(func_name)
        func_name = sanitize_func_name(func_name)
        if func_name == "" then
          require("nvim-surround.buffer").clear_highlights()
          return
        end
        vim.schedule(function()
          local row = mark_start[1] - 1  -- 0-indexed
          local start_col = mark_start[2]
          local line_text = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""
          local end_col = math.min(mark_end[2] + 1, #line_text)
          local selected = line_text:sub(start_col + 1, end_col)
          vim.api.nvim_buf_set_text(bufnr, row, start_col, row, end_col, { func_name .. "(" .. selected .. ")" })
        end)
      end)

      -- Abort nvim-surround's own insertion; we handle it in the callback.
      return nil
    end,

    -- find / delete stay at nvim-surround defaults (no user input needed)

    change = {
      replacement = function()
        local call = find_func_call_at_cursor()
        if not call then return nil end
        local bufnr = vim.api.nvim_get_current_buf()

        M.input_with_lsp(bufnr, { prompt = "Function: ", default = call.name }, function(func_name)
          func_name = sanitize_func_name(func_name)
          if func_name == "" then
            require("nvim-surround.buffer").clear_highlights()
            return
          end
          vim.schedule(function() vim.api.nvim_buf_set_text(bufnr, call.row, call.name_start, call.row, call.name_end, { func_name }) end)
        end)

        -- Abort nvim-surround's own change; we handle it in the callback.
        return nil
      end,
    },
  },
}

return M
