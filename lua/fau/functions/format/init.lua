local M = {}

M.tag = require("fau.functions.format.tagcomment")  -- `TAG:` comments


-- ┌──────────────────────────────────────────────────────────┐
-- │                      Disable Flags                       │
-- └──────────────────────────────────────────────────────────┘

---Whether `fvim_format` or `fvim_format_<feature_name>` is disabled.
---@param name "trim"|"sep"|"tag"
---@param bufnr? integer Default is the current buffer.
---@return boolean disabled
function M.is_disabled(name, bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local function off(value) return value == false or value == 0 end  -- `:let g:x = 0` reaches Lua as the number 0
  for _, flag in ipairs({ "fvim_format", ("fvim_format_%s"):format(name) }) do
    if off(vim.g[flag]) or off(vim.b[bufnr][flag]) then return true end
  end
  return false
end


---Run each step (trim, separators, tags) that is not disabled for the buffer.
---@param bufnr? integer Default is the current buffer.
function M.run(bufnr)
  M.trim_text(bufnr)
  M.normalize_separators(bufnr)
  M.tag.normalize(bufnr)
end


-- ┌──────────────────────────────────────────────────────────┐
-- │               Trim Blank Lines and Spaces                │
-- └──────────────────────────────────────────────────────────┘

M._trim_text_source = nil


local function _trim_text()
  local save_cursor = vim.fn.getpos(".")
  vim.api.nvim_command([[silent! keeppatterns %s#\($\n\s*\)\+\%$##]])
  vim.api.nvim_command([[silent! keeppatterns %s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
end


---Trim trailing blank lines and trailing spaces.
---@param bufnr? integer Default is the current buffer.
---@param force? boolean Whether to force it to run even if it's disabled.
M.trim_text = function(bufnr, force)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not force and M.is_disabled("trim", bufnr) then return end
  vim.api.nvim_buf_call(bufnr, function()
    if M._trim_text_source == nil then _trim_text()
    elseif M._trim_text_source == "mini" then
      local trailspace = require("mini.trailspace")
      trailspace.trim_last_lines(); trailspace.trim()
    else
      fvim.notify(("Unknown trim text source: %s. Back to default."):format(M._trim_text_source), vim.log.levels.WARN)
      _trim_text()
    end
  end)
end


-- ┌──────────────────────────────────────────────────────────┐
-- │                 Separator Normalization                  │
-- └──────────────────────────────────────────────────────────┘

local SEP_SPAN   = 60   -- glyph columns after the comment leader
local SEP_LEN    = 3    -- glyphs in a marker prefix, and the shortest run that reads as a rule
local SEP_PAD    = 2    -- the fewest spaces between a box's label and each of its bars
local SEP_DOUBLE = "═"  -- weight 2: a single line, label centered
local SEP_SINGLE = "─"  -- one level down: a label and a tail
local SEP_DASHED = "┄"  -- the level below that: a fixed prefix, and no tail
local SEP_BOXES  = {    -- the 3-line boxes, as { top-left, horizontal, top-right, vertical, bottom-left, bottom-right }
  { "╔", "═", "╗", "║", "╚", "╝" },  -- weight 0: the file's title
  { "┌", "─", "┐", "│", "└", "┘" },  -- weight 1
}


-- ═════════════════════════ Helpers ══════════════════════════

---Right-trim a trailing run of `ch`, which may be multi-byte (Lua patterns match bytes, so regex cannot be used here).
local function rstrip_run(s, ch)
  while vim.endswith(s, ch) do s = s:sub(1, -#ch - 1) end
  return s
end


---Left-trim a leading run of `ch`.
local function lstrip_run(s, ch)
  while vim.startswith(s, ch) do s = s:sub(#ch + 1) end
  return s
end


---The label between the runs of `ch`, or nil when there is none.
local function label_of(body, ch)
  local label = vim.trim(rstrip_run(lstrip_run(vim.trim(body), ch), ch))  -- trim first: a stray space stops the strip
  return label ~= "" and label or nil
end


-- ═════════════════════ ASCII Shorthand ══════════════════════

---Rewrite an ASCII rule into glyphs, one for one, with an optional label
---(`=== Label`, `=== Label ===`); nil for a body that is anything else.
--- - `===` → `═` for `sec2`; a label between two of these lines becomes a `sec0` box
--- - `---` → `─` for `sec3`; a label between two of these lines becomes a `sec1` box
--- - `~~~` → `┄` for `sec4`
---
---A trailing run is dropped, since the width rules below redraw it
local function ascii_shorthand(rest)
  local function convert(ascii, glyph)
    local run, label = rest:match(("^(%s+)(.*)$"):format(ascii))
    if not run or #run < SEP_LEN then return end
    if label ~= "" and not label:find("^%s") then return end
    label = label:gsub("^%s+", ""):gsub(("%%s*%s+$"):format(ascii), ""):gsub("%s+$", "")
    return glyph:rep(#run) .. (label ~= "" and (" " .. label) or "")
  end
  return convert("=", SEP_DOUBLE) or convert("%-", SEP_SINGLE) or convert("~", SEP_DASHED)
end


---Detect if a buffer uses ASCII rules for its section markers.
---This will be stored in `vim.b.fvim_ascii_separators` for disabling the
---glyph section marker feature.
---@param bufnr integer buffer number (default: current buffer)
---@return boolean? ascii_separators true/false if detected, nil if no comment leader
function M.detect_ascii_separators(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local leader, pattern = fvim.utils.comment_parts(bufnr)
  if not leader then return end

  local uses_ascii = false
  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    local _, rest = line:match(pattern)
    if rest and ascii_shorthand(rest) then uses_ascii = true; break end
  end
  vim.b[bufnr].fvim_ascii_separators = uses_ascii

  return uses_ascii
end


-- ═══════════════════════ Line Markers ═══════════════════════

---Redraw a one-line marker (`sec2`, `sec3` or `sec4`) in its standard form.
---@param head string indent, comment leader and the space after it
---@param body string rest of the line, with the shorthand already applied
---@param target integer display column that `═` and `─` markers end on
---@return string? line the redrawn line; nil when `body` is not a marker
local function redraw_line(head, body, target)
  local room = target - vim.fn.strdisplaywidth(head)

  -- CASE1: `sec2`, the label centered between two runs of `═`. A bare `═` rule is drawn in full.
  if vim.startswith(body, SEP_DOUBLE) then
    local label = label_of(body, SEP_DOUBLE)
    if not label then return head .. SEP_DOUBLE:rep(math.max(room, SEP_LEN)) end
    local pad = math.max(room - vim.fn.strdisplaywidth(label) - 2, SEP_LEN * 2)
    local left = math.floor(pad / 2)  -- odd glyph to the right
    return ("%s%s %s %s"):format(head, SEP_DOUBLE:rep(left), label, SEP_DOUBLE:rep(pad - left))
  end

  -- CASE2: `sec3`, `───` and the label, then a tail of `─`. A bare `─` rule is drawn in full.
  if vim.startswith(body, SEP_SINGLE) then
    local label = label_of(body, SEP_SINGLE)
    if not label then return head .. SEP_SINGLE:rep(math.max(room, SEP_LEN)) end
    local start = ("%s%s %s "):format(head, SEP_SINGLE:rep(SEP_LEN), label)
    return start .. SEP_SINGLE:rep(math.max(target - vim.fn.strdisplaywidth(start), SEP_LEN))
  end

  -- CASE3: `sec4`, `┄┄┄` and the label, with no tail. A bare `┄` rule stays as it is.
  if vim.startswith(body, SEP_DASHED) then
    local label = label_of(body, SEP_DASHED)
    return label and ("%s%s %s"):format(head, SEP_DASHED:rep(SEP_LEN), label) or head .. body
  end
end


-- ═══════════════════════ Box Markers ════════════════════════

---Draw a box marker (`sec0` or `sec1`) around a label.
---@param head string indent, comment leader and the space after it
---@param style string[] the box's glyphs, an entry of `SEP_BOXES`
---@param label string text of the middle line, centered
---@param target integer display column the box ends on; a label too long for it widens the box
---@return string[] lines the top, middle and bottom lines
local function boxed(head, style, label, target)
  local tl, h, tr, v, bl, br = unpack(style)
  local width = vim.fn.strdisplaywidth(label)
  local inner = math.max(target - vim.fn.strdisplaywidth(head) - 2, width + 2 * SEP_PAD)  -- a long label widens the box
  local left = math.floor((inner - width) / 2)  -- odd glyph to the right
  local middle = (" "):rep(left) .. label .. (" "):rep(inner - width - left)
  return { head .. tl .. h:rep(inner) .. tr, head .. v .. middle .. v, head .. bl .. h:rep(inner) .. br }
end


---Redraw three comment lines as a box marker (`sec0` or `sec1`), if they form one.
---@param top? {head: string, body: string} first line, split as in `normalize_separators`; nil if not a comment
---@param mid? {head: string, body: string} second line
---@param bot? {head: string, body: string} third line
---@param target integer display column the box ends on
---@return string[]? lines the redrawn top, middle and bottom lines; nil when they do not form a box
local function redraw_box(top, mid, bot, target)
  -- EXIT: Not three comment lines with the same indent and leader.
  if not (top and mid and bot) or top.head ~= mid.head or top.head ~= bot.head then return end

  for _, style in ipairs(SEP_BOXES) do
    local tl, h, _, v, bl = unpack(style)

    -- CASE1: Already drawn. Its corners are enough, since the middle may have lost its bars while editing.
    if vim.startswith(top.body, tl) and vim.startswith(bot.body, bl) then
      local label = label_of(mid.body, v)
      return label and boxed(top.head, style, label, target)
    end

    -- CASE2: A label between two bare rules of the box's line (`===` → `═`, `---` → `─`).
    -- NOTE: The old `sec1` (`═` rules around `═══ Label ═══`) lands here too, and becomes the `sec1` box.
    if lstrip_run(top.body, h) == "" and lstrip_run(bot.body, h) == "" then
      local label = label_of(mid.body, h)
      local old = vim.startswith(mid.body, SEP_DOUBLE)
      return label and boxed(top.head, old and SEP_BOXES[2] or style, label, target)
    end
  end
end


-- ════════════════════════ Normalize ═════════════════════════

---Redraw every section marker in the range; all but `┄` end on the same column:
--- - box (`sec0`, `sec1`): framed, label centered
--- - `═` (`sec2`): label centered
--- - `─` (`sec3`): label after `───`, then a tail
--- - `┄` (`sec4`): label after `┄┄┄`, no tail
---
---SEE: `ascii_shorthand()` for the ASCII to glyph conversion rules.
---@param bufnr? integer buffer number (default: current buffer)
---@param from? integer 0-based first line to scan (default: whole buffer)
---@param to? integer exclusive last line
---@param shorthand? boolean apply the shorthand even in a file that opted out of it
---@param force? boolean whether to force it to run even if it's disabled
function M.normalize_separators(bufnr, from, to, shorthand, force)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not force and M.is_disabled("sep", bufnr) then return end

  -- EXIT: No line comment, or a block one (`/* %s */`, `<!-- %s -->`) whose closing part a rule would run past.
  local leader, pattern = fvim.utils.comment_parts(bufnr)
  if not leader or vim.bo[bufnr].commentstring:find("%%s%s*%S") then return end

  from = from or 0
  local lines = vim.api.nvim_buf_get_lines(bufnr, from, to or -1, false)  -- out-of-range ends are clamped
  local target = vim.fn.strdisplaywidth(leader) + 1 + SEP_SPAN
  shorthand = shorthand or not vim.b[bufnr].fvim_ascii_separators

  -- STEP1: Split each comment line into its head (indent and leader) and its body, with the shorthand applied.
  local parts = {}
  for i, line in ipairs(lines) do
    local indent, body = line:match(pattern)
    if body and body ~= "" then
      parts[i] = { head = indent .. leader .. " ", body = shorthand and ascii_shorthand(body) or body }
    end
  end

  -- STEP2: Redraw a box 3 lines at a time, any other line on its own; write only the lines that changed.
  local i = 1
  while i <= #lines do
    local p = parts[i]
    -- CASE1: Lines i to i+2 form a box: redraw all three.
    local new = redraw_box(p, parts[i + 1], parts[i + 2], target)
    -- CASE2: Otherwise redraw line i alone; a line that is not a marker stays as it is.
    if not new then new = { p and redraw_line(p.head, p.body, target) or lines[i] } end
    if not vim.deep_equal(new, vim.list_slice(lines, i, i + #new - 1)) then
      vim.api.nvim_buf_set_lines(bufnr, from + i - 1, from + i - 1 + #new, false, new)
    end
    i = i + #new
  end

  -- The forced run converted the ASCII rules this flag was based on, so recompute it.
  if force then M.detect_ascii_separators(bufnr) end
end


-- ┌──────────────────────────────────────────────────────────┐
-- │                       Smart Format                       │
-- └──────────────────────────────────────────────────────────┘

---Smart indent a file or range.
function M.auto_indent()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    vim.api.nvim_command("normal! =")
  else  -- indent all buffer
    local save_cursor = vim.fn.getpos(".")
    vim.api.nvim_command("normal! gg=G")
    vim.fn.setpos(".", save_cursor)
  end
  M.trim_text(nil, true)
  fvim.notify("not found formatter, use auto indent!", vim.log.levels.INFO, { render = "minimal", id = "smart_format" })
end


---Smart format (if no lsp formatter: use auto_indent)
function M.smart_format()
  local filetype = vim.bo.filetype

  -- NOTE: Special treamtment for some filetypes.
  -- if filetype == "python" then return M.auto_indent()
  if filetype == "c" or filetype == "cpp" then return M.auto_indent() end

  -- By lsp capability (visual mode uses rangeFormatting, see `vim.lsp.buf.format`)
  local mode = vim.fn.mode()
  local method = (mode == "v" or mode == "V") and "textDocument/rangeFormatting" or "textDocument/formatting"
  local clients = vim.lsp.get_clients({ bufnr = 0, method = method })
  if #clients == 0 then return M.auto_indent() end

  vim.lsp.buf.format()

  local names = vim.tbl_map(function(client) return client.name end, clients)
  fvim.notify(("formatted by: %s"):format(table.concat(names, ", ")), vim.log.levels.INFO, { render = "minimal", id = "smart_format" })
end


return M
