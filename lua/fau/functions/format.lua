local M = {}


-- ═══════════════ Trim Blank Lines and Spaces ════════════════

M._trim_text_source = "default"


function M.__trim_text()
  local save_cursor = vim.fn.getpos(".")
  vim.api.nvim_command([[silent! %s#\($\n\s*\)\+\%$##]])
  vim.api.nvim_command([[silent! %s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
end

M.trim_text = function()
  if M._trim_text_source == "default" then M.__trim_text()
  elseif M._trim_text_source == "mini" then
    local trailspace = require("mini.trailspace")
    trailspace.trim_last_lines(); trailspace.trim()
  else
    fvim.notify(("Unknown trim text source: %s. Back to default."):format(M._trim_text_source), vim.log.levels.WARN)
    M.__trim_text()
  end
end


-- ═════════════════ Separator Normalization ══════════════════

local SEP_SPAN  = 60   -- glyph columns after the comment leader
local SEP_HEAVY = "═"  -- top level: a 3-line box, or a single line
local SEP_MID   = "─"  -- `┄` markers carry no tail, so none is needed here


---Right-trim a trailing run of `ch`, which may be multi-byte (Lua patterns
---match bytes, so `ch.."+"` cannot be used here).
local function rstrip_run(s, ch)
  while s:sub(-#ch) == ch do s = s:sub(1, -#ch - 1) end
  return s
end


---Left-trim a leading run of `ch`.
local function lstrip_run(s, ch)
  while s:sub(1, #ch) == ch do s = s:sub(#ch + 1) end
  return s
end


---Comment leader of the current buffer: `--` for lua, `#` for python, …
local function comment_leader()
  local leader = (vim.bo.commentstring or ""):match("^%s*(.-)%s*%%s")
  return (leader ~= "" and leader) or nil
end


---`^(indent)(rest)$` matcher for comment lines carrying `leader`. The space after the
---leader is the safety rail of the whole module: it is what keeps lua's `---` doc
---comments, and runs like `-------`, out of everything below.
local function marker_pattern(leader)
  return ("^(%%s*)%s (.*)$"):format(vim.pesc(leader))
end


---The rule that a comment body of nothing but `---` or `===` stands for, one glyph
---for one; nil for a body that is anything else.
local function ascii_shorthand(rest)
  local dashes, equals = rest:match("^(%-%-%-+)%s*$"), rest:match("^(===+)%s*$")
  if dashes then return SEP_MID:rep(#dashes) end
  if equals then return SEP_HEAVY:rep(#equals) end
end


---Opt this buffer out of the ASCII shorthand, when the file already draws its rules
---that way. Those are the author's own, and rewriting them would litter someone
---else's repository with non-ASCII diffs — the rest of the normalizer never has that
---problem, because it only ever touches glyphs that came from the `sec*` snippets.
---
---Only ever call this on an untouched file: once a rule is typed, the buffer can no
---longer tell that line apart from the file's own. Width normalization is unaffected,
---and `normalize_separators(_, _, true)` still forces the shorthand by hand.
function M.detect_ascii_separators()
  local leader = comment_leader()
  if not leader then return end

  local pattern = marker_pattern(leader)
  local uses_ascii = false
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local _, rest = line:match(pattern)
    if rest and ascii_shorthand(rest) then uses_ascii = true; break end
  end
  vim.b.fau_ascii_separators = uses_ascii
end


---Re-pad section markers so every one of them ends on the same column, `SEP_SPAN`
---glyphs past the comment leader. This is what makes the `sec*` snippets
---self-correcting: they emit a tail sized for the default label, and any other label
---length gets fixed up here.
---
---Top-level markers (`═`, whether boxed or a single line) are centred, because a
---centred label reads as a standalone banner. The levels below (`─`, `┄`) stay left
---aligned, because they are labels that point at the code right under them.
---
---A line of bare `---` or `===` is rewritten into `─`/`═` first and then falls through
---to those rules, so `---` keeps the width it was typed at (an unlabelled `─` is left
---alone) while `===` fills out into a full-width frame line.
---@param from? integer 0-based first line to scan (default: whole buffer)
---@param to? integer exclusive last line
---@param force? boolean apply the shorthand even in a file that opted out of it
function M.normalize_separators(from, to, force)
  local leader = comment_leader()
  if not leader then return end

  local count = vim.api.nvim_buf_line_count(0)
  from = math.max(from or 0, 0)
  if to == nil or to < 0 then to = count else to = math.min(to, count) end
  if from >= to then return end

  local lines = vim.api.nvim_buf_get_lines(0, from, to, false)
  local pattern = marker_pattern(leader)
  local target = vim.fn.strdisplaywidth(leader) + 1 + SEP_SPAN
  local shorthand = force or not vim.b.fau_ascii_separators

  ---`ch+ Label` with the run stripped from both ends, or nil when there is no label.
  local function label_of(rest, ch)
    local label = rstrip_run(lstrip_run(rest, ch):gsub("^%s+", ""), ch):gsub("%s+$", "")
    return label ~= "" and label or nil
  end

  for i, line in ipairs(lines) do
    local indent, rest = line:match(pattern)
    local new

    if rest and rest ~= "" then
      local head = ("%s%s "):format(indent, leader)
      local room = target - vim.fn.strdisplaywidth(head)

      -- The branches below then apply the usual width rules to what the shorthand
      -- produced, so `===` still fills out into a full box frame line.
      local ascii = shorthand and ascii_shorthand(rest)
      if ascii then
        rest = ascii
        new = head .. rest
      end

      local function tailed(ch, label)
        local h = ("%s%s %s "):format(head, ch:rep(3), label)
        return h .. ch:rep(math.max(target - vim.fn.strdisplaywidth(h), 3))
      end

      if rest:sub(1, #SEP_HEAVY) == SEP_HEAVY then
        local label = rstrip_run(rest, SEP_HEAVY) ~= "" and label_of(rest, SEP_HEAVY) or nil
        if not label then
          new = head .. SEP_HEAVY:rep(math.max(room, 3))          -- box frame line
        else
          local pad = math.max(room - vim.fn.strdisplaywidth(label) - 2, 2)
          local left = math.floor(pad / 2)                        -- odd glyph to the right
          new = ("%s%s %s %s"):format(head, SEP_HEAVY:rep(left), label, SEP_HEAVY:rep(pad - left))
        end
      elseif rest:sub(1, #SEP_MID) == SEP_MID then
        local label = label_of(rest, SEP_MID)
        if label then new = tailed(SEP_MID, label) end
      end
    end

    if new and new ~= line then
      vim.api.nvim_buf_set_lines(0, from + i - 1, from + i, false, { new })
    end
  end

  -- A forced run just rewrote what the opt-out keys on, so take the snapshot again:
  -- the file goes back to the shorthand once none of its own ASCII rules are left.
  if force then M.detect_ascii_separators() end
end


-- ═══════════════════════ Smart Format ═══════════════════════

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
  vim.api.nvim_command("nohlsearch")
  fvim.notify("not found formatter, use auto indent!", vim.log.levels.INFO, { render = "minimal" })
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
  fvim.notify(("formatted by: %s"):format(table.concat(names, ", ")), vim.log.levels.INFO, { render = "minimal" })
end


return M
