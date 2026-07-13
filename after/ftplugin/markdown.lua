if vim.bo.buftype ~= "" then return end

-- -- ==================== Keep Fence Lines Visible (raw query) ====================
-- -- nvim's markdown highlights query hides code-fence delimiter lines outright via
-- -- `(#set! conceal_lines "")` (active at conceallevel >= 2, i.e. also in edit mode since the
-- -- global conceallevel is 2). render-markdown disables those query patterns so that *it* owns
-- -- line-hiding (render mode only, via its own extmarks) -- but it does so once per session,
-- -- against the query object cached at that moment. nvim clears that cache on every 'runtimepath'
-- -- change (:h treesitter, nvim.treesitter.query_cache_reset augroup), and every lazy-loaded
-- -- plugin changes rtp, so a later markdown buffer can get a fresh query with the hiding
-- -- re-enabled. Symptom: ``` lines invisible even in edit mode, popping back in after an edit
-- -- (the edit clears the highlighter's materialized marks). Re-apply the disable on every
-- -- FileType event instead: cheap, idempotent, self-healing, ids computed from the live query.
-- do
--   local ok, query = pcall(vim.treesitter.query.get, "markdown", "highlights")
--   if ok and query and query.query.disable_pattern then
--     for id, directives in pairs(query.info.patterns) do
--       for _, d in ipairs(directives) do
--         if d[1] == "set!" and d[2] == "conceal_lines" then query.query:disable_pattern(id) end
--       end
--     end
--   end
-- end


-- ==================== Markdown Buffer Configs ====================
if vim.b.fvim_markdown_ftplugin_loaded then return end
vim.b.fvim_markdown_ftplugin_loaded = true

local bufnr = vim.api.nvim_get_current_buf()
vim.schedule(function()
  if not vim.api.nvim_buf_is_valid(bufnr) then return end
  ---@diagnostic disable-next-line: undefined-field
  vim.api.nvim_buf_call(bufnr, function() vim.opt_local.formatoptions:append("or") end)
end)
-- vim.opt_local.spell = true
-- vim.opt_local.spelllang = "en_us"

vim.keymap.set({ "n", "x", "o" }, "J", "5j", { buffer = true, remap = true, desc = "Goto: Five Lines Down" })
vim.keymap.set({ "n", "x", "o" }, "K", "5k", { buffer = true, remap = true, desc = "Goto: Five Lines Up" })


-- ================================================================================
-- ===== WARNING: The following code is written by AI and not fully reviewed! =====
-- ================================================================================

-- ==================== Conceal-aware Motions ====================
-- In "render mode" (`<C-r>`, see render-markdown.lua: conceallevel=2 + concealcursor=nc),
-- concealed markdown syntax (`**`, `[](...)`, fences, ...) stays hidden even under the cursor, so
-- plain motions leave the cursor on invisible characters (h/l/w/b/e) or on the visually wrong
-- column (j/k, whose `curswant` tracks the raw column, not the rendered one).
--
-- No Neovim API reports the *rendered* screen column -- `screenpos()` explicitly ignores conceal
-- (:h screenpos()) and `screencol()` only reflects the last completed redraw -- so the renderer's
-- per-line decision is rebuilt here from the same two sources it uses:
--   1. treesitter highlight captures whose *metadata* carries `conceal` (the actual rule, see
--      highlighter.lua; matching on the capture name would miss links, entities, fences, ...);
--   2. extmarks with a `conceal` field (render-markdown.nvim's checkboxes, tables, bullets, ...).
-- The same two sources also report `conceal_lines` (fully hidden lines, e.g. fence delimiters
-- with code.border = "hide"): j/k slide past such lines, and w/b/e treat them as concealed.
-- (:h api.txt claims extmark details lack `conceal_lines`; empirically 0.12.4 does return it.)
--
-- Known limitations (accepted):
--   * Inline virtual text that shifts following characters is not accounted for (overlay-style
--     virtual text keeps column geometry and is fine).
--   * Ephemeral (decoration-provider) conceals are invisible to nvim_buf_get_extmarks().
--   * The width model assumes conceallevel 2 (a concealed range collapses to its replacement
--     char, or to nothing when the replacement is empty) -- which is what render mode sets.
--
-- Everything gates on the actual on-screen state (conceal_active() below), so in edit mode
-- (concealcursor = "") these maps fall through to plain motions. Maps are Normal-mode only on
-- purpose: render mode uses concealcursor = "nc", so Visual/Insert already reveal the cursor
-- line and need no help.


---Whether Normal-mode conceal is in effect in the current window (render mode).
local function conceal_active() return vim.wo.conceallevel > 0 and vim.wo.concealcursor:find("n", 1, true) ~= nil end

---@alias fvim.md.ConcealRange [integer, integer, integer] {start_col, end_col, replacement_width}

---Collect concealed byte ranges on `row` from treesitter highlights.
---@param buf integer
---@param row integer 0-based
---@param ranges fvim.md.ConcealRange[] appended to
---@return boolean hidden whether the whole line is hidden by `conceal_lines` metadata
local function ts_conceal_ranges(buf, row, ranges)
  local hidden = false
  -- No active highlighter means treesitter conceal is not rendered at all.
  if not vim.treesitter.highlighter.active[buf] then return hidden end
  local ok, parser = pcall(vim.treesitter.get_parser, buf)
  if not ok or not parser then return hidden end
  pcall(function() parser:parse({ row, row + 1 }) end)  -- ensure injections (markdown_inline) are parsed
  parser:for_each_tree(function(tstree, ltree)
    if not tstree then return end
    local root = tstree:root()
    local root_srow, _, root_erow = root:range()
    if root_srow > row or root_erow < row then return end
    local qok, query = pcall(vim.treesitter.query.get, ltree:lang(), "highlights")
    if not qok or not query then return end
    for id, node, metadata in query:iter_captures(root, buf, row, row + 1) do
      -- Same rule the highlighter applies: match-level or capture-level metadata.
      local conceal = metadata.conceal or (metadata[id] and metadata[id].conceal)
      if type(conceal) == "string" then
        local srow, scol, erow, ecol = node:range()
        ranges[#ranges+1] = {
          srow == row and scol or 0,
          erow == row and ecol or math.huge,
          conceal ~= "" and 1 or 0,
        }
      end
      local conceal_lines = metadata.conceal_lines or (metadata[id] and metadata[id].conceal_lines)
      if type(conceal_lines) == "string" then hidden = true end
    end
  end)
  return hidden
end

---Collect concealed byte ranges on `row` from extmarks. `overlap = true` is essential: without
---it only marks *starting* inside the queried range are returned, missing every range-spanning
---conceal mark (which is most of what render-markdown places).
---@param buf integer
---@param row integer 0-based
---@param ranges fvim.md.ConcealRange[] appended to
---@return boolean hidden whether the whole line is hidden by a `conceal_lines` mark
local function extmark_conceal_ranges(buf, row, ranges)
  local hidden = false
  local marks = vim.api.nvim_buf_get_extmarks(buf, -1, { row, 0 }, { row, -1 }, { details = true, overlap = true })
  for _, m in ipairs(marks) do
    local srow, scol, d = m[2], m[3], m[4]
    if d and not d.invalid then
      if d.conceal ~= nil then
        local erow, ecol = d.end_row or srow, d.end_col or scol
        local s = srow == row and scol or 0
        local e = erow == row and ecol or math.huge
        if e > s then ranges[#ranges+1] = { s, e, d.conceal ~= "" and 1 or 0 } end
      end
      ---@diagnostic disable-next-line: undefined-field  -- api.txt/LuaLS lag: details does return it
      if d.conceal_lines ~= nil then hidden = true end
    end
  end
  return hidden
end

---@class fvim.md.LineInfo
---@field pos integer[] 1-based first-byte index of each character
---@field n integer character count
---@field hidden boolean whole line hidden via `conceal_lines`
---@field concealed boolean[] per character
---@field disp integer[] display column (1-based) where each character renders

---Scan `row` once: whether the whole line is hidden, and for every character, whether it is
---concealed and at which display column it renders (a concealed range contributes only its
---replacement char's width). One treesitter pass plus one extmark query per call -- cheap
---enough to recompute per keypress, which also dodges cache invalidation (extmark churn does
---not bump changedtick).
---@param buf integer
---@param row integer 0-based
---@return fvim.md.LineInfo
local function line_info(buf, row)
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, true)[1] or ""
  local ranges = {}  ---@type fvim.md.ConcealRange[]
  local ts_hidden = ts_conceal_ranges(buf, row, ranges)
  local extmark_hidden = extmark_conceal_ranges(buf, row, ranges)
  local hidden = ts_hidden or extmark_hidden

  local pos = vim.str_utf_pos(line)
  local n = #pos
  local concealed, disp = {}, {}
  local width = 1
  for i = 1, n do
    local byte0 = pos[i] - 1
    local covering  ---@type fvim.md.ConcealRange?
    for _, r in ipairs(ranges) do
      if byte0 >= r[1] and byte0 < r[2] then
        covering = r
        break
      end
    end
    concealed[i] = hidden or covering ~= nil
    disp[i] = width
    if covering then
      if byte0 == covering[1] then width = width + covering[3] end  -- replacement cchar's cell
    else
      local next0 = i < n and pos[i + 1] - 1 or #line
      width = width + vim.fn.strdisplaywidth(line:sub(byte0 + 1, next0), width - 1)
    end
  end
  return { pos = pos, n = n, hidden = hidden, concealed = concealed, disp = disp }
end

---Index (into LineInfo arrays) of the character containing byte column `col`; nil on empty line.
---@param info fvim.md.LineInfo
---@param col integer 0-based byte column
local function char_index_at(info, col)
  for i = info.n, 1, -1 do
    if info.pos[i] - 1 <= col then return i end
  end
  return nil
end

---Whether the character under the cursor is concealed (incl. a fully hidden line).
local function cursor_concealed(buf)
  local cur = vim.api.nvim_win_get_cursor(0)
  local info = line_info(buf, cur[1] - 1)
  local i = char_index_at(info, cur[2])
  return info.hidden or (i ~= nil and info.concealed[i])
end

---h/l over *visible* characters: each count step advances to the next visible character on the
---line; when there is none left in that direction (e.g. only concealed delimiters up to the
---line edge), the cursor stays put -- visually there is nowhere to go.
---@param dir 1|-1
local function visible_hl(dir)
  return function()
    if not conceal_active() then
      vim.cmd("normal! " .. vim.v.count1 .. (dir == 1 and "l" or "h"))
      return
    end
    local buf = vim.api.nvim_get_current_buf()
    local cur = vim.api.nvim_win_get_cursor(0)
    local info = line_info(buf, cur[1] - 1)
    local start = char_index_at(info, cur[2])
    if not start then return end
    local target = start
    for _ = 1, vim.v.count1 do
      local j = target + dir
      while j >= 1 and j <= info.n and info.concealed[j] do j = j + dir end
      if j < 1 or j > info.n then break end
      target = j
    end
    if target ~= start then vim.api.nvim_win_set_cursor(0, { cur[1], info.pos[target] - 1 }) end
  end
end

---w/b/e that re-run the motion while it lands on concealed text. Re-running (instead of
---sidestepping with h/l) preserves the motion's semantics: `b` must land on a word *start*, so
---landing on a hidden `**` re-`b`s to the previous word. If the motion stops making progress
---while still hidden (buffer edge), the whole move is undone: there was no visible target.
local function visible_word(motion)
  return function()
    if not conceal_active() then
      vim.cmd("normal! " .. vim.v.count1 .. motion)
      return
    end
    local buf = vim.api.nvim_get_current_buf()
    local origin = vim.api.nvim_win_get_cursor(0)
    vim.cmd("normal! " .. vim.v.count1 .. motion)
    for _ = 1, 8 do
      if not cursor_concealed(buf) then return end
      local before = vim.api.nvim_win_get_cursor(0)
      vim.cmd("normal! " .. motion)
      local after = vim.api.nvim_win_get_cursor(0)
      if after[1] == before[1] and after[2] == before[2] then break end
    end
    if cursor_concealed(buf) then vim.api.nvim_win_set_cursor(0, origin) end
  end
end

-- Sticky "wanted" display column (Vim's `curswant`), reimplemented ourselves since we own j/k.
-- `sticky_pos` is where *we* last placed the cursor for that wanted column: if the cursor is
-- still exactly there next time j/k runs, nothing else has moved it, so the want column carries
-- over unchanged (this is what stops a short line from "shrinking" the remembered column). Any
-- other motion (h/l/w/b/e, $, 0, f, search, mouse, ...) leaves the cursor somewhere else, so the
-- mismatch is detected without hooking into every possible motion.
local sticky_col, sticky_pos = nil, nil

---j/k that keep the *visual* column: derive the display column on the current line (or reuse
---the sticky one if nothing moved the cursor since our last j/k), do the raw move, slide past
---fully hidden lines (`conceal_lines`), then land on the character whose rendered cells cover
---that column -- picking only visible characters, so j/k never parks the cursor on hidden text.
local function visible_jk(key)
  return function()
    local count = vim.v.count1
    if not conceal_active() then
      sticky_col, sticky_pos = nil, nil
      vim.cmd("normal! " .. count .. key)
      return
    end
    local buf = vim.api.nvim_get_current_buf()
    local cur = vim.api.nvim_win_get_cursor(0)

    local want
    if sticky_pos and sticky_pos[1] == cur[1] and sticky_pos[2] == cur[2] then
      want = sticky_col
    elseif vim.fn.getcurpos()[5] == vim.v.maxcol then
      -- Something else moved the cursor, but Vim's own curswant is still the `$` sentinel
      -- (MAXCOL): honor it the same way Vim does -- always the last visible char of each line.
      want = math.huge
    else
      local info = line_info(buf, cur[1] - 1)
      local ci = char_index_at(info, cur[2])
      want = ci and info.disp[ci] or 1
    end

    vim.cmd("normal! " .. count .. key)

    local new = vim.api.nvim_win_get_cursor(0)
    if new[1] == cur[1] then
      sticky_col, sticky_pos = want, new
      return
    end
    -- Keep moving in the same direction while the landing line is entirely hidden; when only
    -- hidden lines remain up to the buffer edge, undo the whole move -- no visible target.
    local dir = key == "j" and 1 or -1
    local last = vim.api.nvim_buf_line_count(buf)
    local row = new[1]
    local info = line_info(buf, row - 1)
    while info.hidden do
      row = row + dir
      if row < 1 or row > last then
        vim.api.nvim_win_set_cursor(0, cur)
        sticky_col, sticky_pos = want, cur
        return
      end
      info = line_info(buf, row - 1)
    end
    -- The last visible char whose display column is <= want covers the wanted cell (this also
    -- handles double-width chars); if the line's first visible char is already past `want`, take
    -- that one. A line with no visible chars keeps the raw landing.
    local best
    for i = 1, info.n do
      if not info.concealed[i] then
        if info.disp[i] <= want then
          best = i
        else
          best = best or i
          break
        end
      end
    end
    local final = { row, best and (info.pos[best] - 1) or 0 }
    if best or row ~= new[1] then vim.api.nvim_win_set_cursor(0, final) end
    sticky_col, sticky_pos = want, vim.api.nvim_win_get_cursor(0)
  end
end

for key, fn in pairs({
  h = visible_hl(-1),
  l = visible_hl(1),
  w = visible_word("w"),
  b = visible_word("b"),
  e = visible_word("e"),
  j = visible_jk("j"),
  k = visible_jk("k"),
}) do
  vim.keymap.set("n", key, fn, { buffer = true, desc = "Conceal-aware " .. key })
end
