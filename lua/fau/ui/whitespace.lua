local TAB, SPACE = 9, 32  -- byte values

local NS = vim.api.nvim_create_namespace("fvim_visual_whitespace")
local HL = "FvimVisualWhitespace"

---Extmark options drawing one glyph over a cell.
---@param text string
local function glyph(text)
  return {
    virt_text = { { text, HL } },
    virt_text_pos = "overlay",
    -- IMPO: Inline virtual text makes one column span several cells, and priority is the layout order within it:
    -- \     whoever sorts first takes the leading cells. Below an inlay hint we overwrite its text; above it, the hint
    -- \     lays out first and pushes us onto the real space. `4096` is the default a hint gets by not setting one.
    priority = fvim.settings.priority.indent.whitespace,
    hl_mode = "combine",
    ephemeral = true,
  }
end

local MARKS = { [TAB] = glyph("→"), [SPACE] = glyph("·") }

---`mode()` of every visual/select mode, mapped to the register type `getregionpos` wants.
local MODES = { v = "v", V = "V", ["\22"] = "\22", s = "v", S = "V", ["\19"] = "\22" }

---@alias fvim.ws.Range [integer, integer] {from, to} byte columns, both 1-indexed and end-inclusive
---@alias fvim.ws.Ranges table<integer, fvim.ws.Range> one range per line, keyed by 1-indexed line
---@alias fvim.ws.Cells [integer, integer] {first, last} screen column of one position, both 1-indexed

---The selected range of each line in the current redraw, keyed by 1-indexed line.
local ranges = {}  ---@type fvim.ws.Ranges


---Total width of the inline virtual text sitting in front of byte `col`.
---@param lnum integer 1-indexed
---@param col integer 1-indexed byte column
---@return integer
local function inline_width(lnum, col)
  local width = 0
  local at = { lnum - 1, col - 1 }
  local marks = vim.api.nvim_buf_get_extmarks(0, -1, at, at, { details = true, type = "virt_text" })
  for _, mark in ipairs(marks) do
    local details = mark[4]
    if details and details.virt_text_pos == "inline" then
      for _, chunk in ipairs(details.virt_text) do width = width + vim.fn.strdisplaywidth(chunk[1]) end
    end
  end
  return width
end


---Collect the selected range of every line from `top` to `bot`.
---@param top integer First row to ask about, 1-indexed.
---@param bot integer Last row to ask about, 1-indexed.
---@return fvim.ws.Ranges? ranges nil when nothing is selected
local function selection(top, bot)
  local mode = MODES[vim.fn.mode()]
  if not mode then return end

  local block_mode = mode == "\22"
  local cursor = vim.fn.getcurpos()
  local eol = block_mode and cursor[5] >= vim.v.maxcol

  -- NOTE: `anchor` can come after `cursor`; `getregionpos` sorts them itself.
  local anchor = vim.fn.getpos("v")

  -- IMPO: A block is a rectangle of cells, which `getregionpos` cannot take: it drops a corner's `off` and measures
  -- \     cells in text alone, while the painted block counts inline virtual text. So resolve it row by row.
  -- EXIT: Special handling for blockwise visual mode.
  if block_mode then
    -- NOTE: Under `virtualedit` a corner can sit past the end of a short line, where only its `off` says which cell.
    local a = vim.fn.virtcol({ anchor[2], anchor[3], anchor[4] }, true) --[[@as fvim.ws.Cells]]
    local c = vim.fn.virtcol({ cursor[2], cursor[3], cursor[4] }, true) --[[@as fvim.ws.Cells]]
    local left, right = math.min(a[1], c[1]), math.max(a[2], c[2])
    local first, last = math.max(top, math.min(anchor[2], cursor[2])), math.min(bot, math.max(anchor[2], cursor[2]))

    local result = {}
    for lnum = first, last do
      local width = vim.fn.virtcol({ lnum, "$" }) - 1
      if width >= left then  -- A shorter line stops before the block and holds nothing to draw.
        local from, to = vim.fn.virtcol2col(0, lnum, left), math.huge
        if not (eol or right > width) then  -- Otherwise the block runs past the line and `draw` clamps it.
          to = vim.fn.virtcol2col(0, lnum, right)
          -- IMPO: Every cell of an inline extmark maps back to the byte behind it, so if `right` sits on
          -- \     a cell of inline virtual text, `to` is one byte far from the real one.
          -- NOTE: To fix this, we check if the cell at `right` is occupied by inline virtual text, and if so, move back.
          if vim.fn.virtcol({ lnum, to }, true)[1] + inline_width(lnum, to) > right then to = to - 1 end
        end
        result[lnum] = { from, to }
      end
    end
    return result
  end

  ---Move a corner inside the redrawn rows: one above them takes its line from the start, one below takes it to the end.
  ---@param pos integer[]
  local function clamp(pos)
    if pos[2] >= top and pos[2] <= bot then return pos end
    local above = pos[2] < top
    local lnum = above and top or bot
    return { pos[1], lnum, above and 1 or math.max(#vim.fn.getline(lnum), 1), pos[4] }
  end

  -- Both clamped columns are always valid, so `getregionpos` cannot throw here.
  local region = vim.fn.getregionpos(clamp(anchor), clamp(cursor), { type = mode, eol = false })

  local result = {}
  -- NOTE: One `{ start, end }` pair per line, both ends inclusive byte columns; an empty line reports column 0.
  for _, pair in ipairs(region) do
    local lnum, from, to = pair[1][2], pair[1][3], pair[2][3]
    if from > 0 then result[lnum] = { from, to } end
  end
  return result
end


---Draw a glyph over every space and tab of `range` on `row`.
---@param buf integer
---@param row integer 0-indexed
---@param range fvim.ws.Range
local function draw(buf, row, range)
  local line = vim.api.nvim_buf_get_lines(buf, row, row + 1, false)[1]
  if not line then return end

  -- INFO: Marking a whole run of spaces at once is cut short by a line wrap.
  -- \     So each space gets its own glyph, which is more expensive but visually correct.
  local col, stop = range[1], math.min(range[2], #line)
  while col <= stop do
    local mark = MARKS[line:byte(col)]  -- A tab is marked at its left edge, and the rest of its cells stay blank.
    if mark then vim.api.nvim_buf_set_extmark(buf, NS, row, col - 1, mark) end
    col = col + 1
  end
end


-- NOTE: A colorscheme wipes every highlight, and it loads after this module.
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("fau_visual_whitespace", { clear = true }),
  callback = function() vim.api.nvim_set_hl(0, HL, { fg = fvim.colors.deep_gray, default = true }) end,
})

vim.api.nvim_set_decoration_provider(NS, {
  on_start = function() return MODES[vim.fn.mode()] ~= nil and vim.bo.buftype == "" end,

  on_win = function(_, win, _, top, bot)
    if win ~= vim.api.nvim_get_current_win() then return false end
    ranges = selection(top + 1, bot + 1) or {}  -- `on_win` rows are 0-indexed
    return not vim.tbl_isempty(ranges)
  end,

  -- NOTE: The range is end-exclusive, and an `end_col` of 0 means `end_row` itself is not included.
  on_range = function(_, _, buf, begin_row, _, end_row, end_col)
    for row = begin_row, end_col == 0 and end_row - 1 or end_row do
      local range = ranges[row + 1]  -- `ranges` is keyed by 1-indexed line, `row` is 0-indexed
      if range then draw(buf, row, range) end
    end
  end,
})
