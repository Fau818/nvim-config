local M = {}

M.tag = require("fau.functions.format.tagcomment")  -- `TAG:` comments


-- ════════════════════════════════════════════════════════════
-- ═══════════════ Trim Blank Lines and Spaces ════════════════
-- ════════════════════════════════════════════════════════════

M._trim_text_source = nil


local function _trim_text()
  local save_cursor = vim.fn.getpos(".")
  vim.api.nvim_command([[silent! keeppatterns %s#\($\n\s*\)\+\%$##]])
  vim.api.nvim_command([[silent! keeppatterns %s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
end


M.trim_text = function()
  if M._trim_text_source == nil then _trim_text()
  elseif M._trim_text_source == "mini" then
    local trailspace = require("mini.trailspace")
    trailspace.trim_last_lines(); trailspace.trim()
  else
    fvim.notify(("Unknown trim text source: %s. Back to default."):format(M._trim_text_source), vim.log.levels.WARN)
    _trim_text()
  end
end


-- ════════════════════════════════════════════════════════════
-- ═════════════════ Separator Normalization ══════════════════
-- ════════════════════════════════════════════════════════════

local SEP_SPAN  = 60   -- glyph columns after the comment leader
local SEP_LEN   = 3    -- glyphs in a marker prefix, and the shortest run that reads as a rule
local SEP_HEAVY = "═"  -- top level: a 3-line box, or a single line
local SEP_MID   = "─"  -- one level down: a label and a tail
local SEP_LIGHT = "┄"  -- the level below that: a fixed prefix, and no tail



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


---Rewrite an ASCII rule into glyphs, one for one, with an optional label
---(`=== Label`, `=== Label ===`); nil for a body that is anything else.
--- - `===` → `═` for `sec2`; a `sec1` box is three of these lines
--- - `---` → `─` for `sec3`
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
  return convert("=", SEP_HEAVY) or convert("%-", SEP_MID) or convert("~", SEP_LIGHT)
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


---Redraw every section marker in the range: `═` centred and `─` tailed out to the same
---end column, `┄` given a fixed prefix.
---SEE: `ascii_shorthand()` for the ASCII to glyph conversion rules.
---@param bufnr? integer buffer number (default: current buffer)
---@param from? integer 0-based first line to scan (default: whole buffer)
---@param to? integer exclusive last line
---@param force? boolean apply the shorthand even in a file that opted out of it
function M.normalize_separators(bufnr, from, to, force)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local leader, pattern = fvim.utils.comment_parts(bufnr)
  if not leader then return end

  local count = vim.api.nvim_buf_line_count(bufnr)
  from = math.max(from or 0, 0)
  if to == nil or to < 0 then to = count else to = math.min(to, count) end
  if from >= to then return end

  local lines = vim.api.nvim_buf_get_lines(bufnr, from, to, false)
  local target = vim.fn.strdisplaywidth(leader) + 1 + SEP_SPAN
  local shorthand = force or not vim.b[bufnr].fvim_ascii_separators

  ---The label between the runs of `ch`, or nil when there is none.
  local function label_of(rest, ch)
    local label = rstrip_run(lstrip_run(rest, ch):gsub("^%s+", ""), ch):gsub("%s+$", "")
    return label ~= "" and label or nil
  end

  ---Three `ch`, the label, then a tail of `ch` out to column `target`.
  local function tailed(head, ch, label)
    local h = ("%s%s %s "):format(head, ch:rep(SEP_LEN), label)
    return h .. ch:rep(math.max(target - vim.fn.strdisplaywidth(h), SEP_LEN))
  end

  ---The marker redrawn, or nil when the line carries no marker to redraw.
  local function rewrite(line)
    local indent, rest = line:match(pattern)
    if not rest or rest == "" then return end

    local head = ("%s%s "):format(indent, leader)
    local room = target - vim.fn.strdisplaywidth(head)
    local new

    -- Convert first, so the branches below run on the glyph form.
    local glyphs = shorthand and ascii_shorthand(rest) or false
    if glyphs then rest = glyphs; new = head .. rest end

    if vim.startswith(rest, SEP_HEAVY) then
      local label = label_of(rest, SEP_HEAVY)
      if not label then new = head .. SEP_HEAVY:rep(math.max(room, SEP_LEN))  -- box frame line
      else
        local pad = math.max(room - vim.fn.strdisplaywidth(label) - 2, SEP_LEN * 2)
        local left = math.floor(pad / 2)                        -- odd glyph to the right
        new = ("%s%s %s %s"):format(head, SEP_HEAVY:rep(left), label, SEP_HEAVY:rep(pad - left))
      end
    elseif vim.startswith(rest, SEP_MID) then
      local label = label_of(rest, SEP_MID)
      if label then new = tailed(head, SEP_MID, label) end
    elseif vim.startswith(rest, SEP_LIGHT) then
      local label = label_of(rest, SEP_LIGHT)
      if label then new = ("%s%s %s"):format(head, SEP_LIGHT:rep(SEP_LEN), label) end
    end

    return new
  end

  for i, line in ipairs(lines) do
    local new = rewrite(line)
    if new and new ~= line then
      vim.api.nvim_buf_set_lines(bufnr, from + i - 1, from + i, false, { new })
    end
  end

  -- The forced run converted the ASCII rules this flag was based on, so recompute it.
  if force then M.detect_ascii_separators(bufnr) end
end


-- ════════════════════════════════════════════════════════════
-- ═══════════════════════ Smart Format ═══════════════════════
-- ════════════════════════════════════════════════════════════

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
  M.trim_text()
  fvim.notify("not found formatter, use auto indent!", vim.log.levels.INFO, { render = "minimal", id = "smart_format" })
end


---Smart format (if no lsp formatter: use auto_indent)
function M.smart_format()
  local filetype = vim.bo.filetype

  -- NOTE: Special treamtment for some filetypes.
  -- if filetype == "python" then return M.auto_indent()  -- TEST: Use ruff for python formatting. Nov 7, 2025.
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
