local M = {}


local CONT       = "\\"  -- stands in for the tag on every line below it
local TAG_END    = ": "  -- closes a tag


-- ════════════════════════════════════════════════════════════
-- ═════════════════════════ Anatomy ══════════════════════════
-- ════════════════════════════════════════════════════════════

---The tag at the head of a comment body (`NOTE`, `CASE1`, `TODO 2`) and the text after it.
---NOTE: The whitespace is required, so that a `HTTP://…` in a comment is not read as a tag.
---@param body string a comment line with its indent and leader already stripped.
---@return string? tag the keyword alone (`NOTE`, `TODO 2`); the `:` is not part of it.
---@return string? text everything past the `:`, trimmed and possibly empty; nil whenever `tag` is.
local function tag_parts(body)
  local tag, text = body:match([[^(%u[%u%d_]+%s?[%d%.]*):(%s.*)$]])
  return tag and vim.trim(tag), text and vim.trim(text)
end


---The text after a continuation marker, or nil when `body` does not carry one.
---@param body string a comment line with its indent and leader already stripped.
---@return string? text what follows the marker and its padding, trimmed; `""` for a bare marker.
local function continuation_body(body) return body:match([[^\%s*(.-)%s*$]]) end


---The prefix that stands in for `tag` on the lines below it, holding their bodies in the same column.
---@param indent string the indent of the tag line it belongs to.
---@param leader string the comment leader of the buffer.
---@param tag string the tag it stands in for, without its `TAG_END`.
---@return string prefix `<indent><leader> <CONT>`, padded out to where the tag's own text begins.
local function continuation_prefix(indent, leader, tag)
  local pad = vim.fn.strdisplaywidth(tag .. TAG_END) - vim.fn.strdisplaywidth(CONT)
  return ("%s%s %s%s"):format(indent, leader, CONT, (" "):rep(pad))
end


---The tag comment that owns `row`, reached by walking up over the continuation lines above it.
---@param bufnr integer the buffer to read the lines from.
---@param row integer 0-based row in the block: the tag line, or a continuation line under it.
---@param pattern string the buffer's comment line pattern, from `fvim.utils.comment_parts`.
---@return string? indent shared by every line of the block; nil when `row` is in no tag comment.
---@return string? tag the owning tag, without its `TAG_END`.
local function tag_at(bufnr, row, pattern)
  local indent, tag
  while row >= 0 and not tag do
    local ind, body = (vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""):match(pattern)
    if not body or (indent and ind ~= indent) then return end
    indent, tag = ind, tag_parts(body)
    if not tag and not continuation_body(body) then return end
    row = row - 1
  end
  return indent, tag
end


-- ════════════════════════════════════════════════════════════
-- ══════════════════════════ Format ══════════════════════════
-- ════════════════════════════════════════════════════════════

---Give every tag comment its `TAG_END` and a padded continuation line for every line below the tag.
---@param bufnr? integer buffer number (default: current buffer)
function M.normalize(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local leader, pattern = fvim.utils.comment_parts(bufnr)
  if not leader then return end

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  ---Rewrite row `i` (1-based), unless it already reads that way.
  local function rewrite(i, new)
    new = new:gsub("%s+$", "")
    if new ~= lines[i] then vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, { new }) end
  end

  -- Scanning down, a tag line always comes before the lines it owns, so each block is done at once.
  local i = 1
  while i <= #lines do
    local indent, body = lines[i]:match(pattern)
    local tag, text
    if body then tag, text = tag_parts(body) end

    if not tag then i = i + 1
    else
      rewrite(i, ("%s%s %s%s"):format(indent, leader, tag, TAG_END) .. text)
      local prefix = continuation_prefix(indent, leader, tag)

      repeat
        i = i + 1
        local ind, next_body = (lines[i] or ""):match(pattern)
        local cont = ind == indent and next_body and continuation_body(next_body)
        if cont then rewrite(i, prefix .. cont) end
      until not cont
    end
  end
end


-- ════════════════════════════════════════════════════════════
-- ═════════════════════════ Editing ══════════════════════════
-- ════════════════════════════════════════════════════════════

---Join the line below into the current one, dropping its continuation marker; plain `J` otherwise.
function M.merge_line()
  local bufnr = vim.api.nvim_get_current_buf()
  local leader, pattern = fvim.utils.comment_parts(bufnr)
  if not leader then return vim.api.nvim_command("normal! " .. vim.v.count1 .. "J") end

  for _ = 1, math.max(vim.v.count1 - 1, 1) do
    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    local pair = vim.api.nvim_buf_get_lines(bufnr, row, row + 2, false)
    if #pair < 2 then return end

    local _, body = pair[2]:match(pattern)
    local text = body and continuation_body(body)
    if text and text ~= "" then
      local head = (pair[1]:gsub("%s+$", ""))
      vim.api.nvim_buf_set_lines(bufnr, row, row + 2, false, { head .. " " .. text })
      vim.api.nvim_win_set_cursor(0, { row + 1, #head })
    else
      vim.api.nvim_command("normal! J")
    end
  end
end


---Break the tag comment at the cursor, marking the new line as a continuation; a plain newline anywhere else.
function M.newline()
  local function plain() fvim.utils.feedkeys("<CR>", "in") end

  local bufnr = vim.api.nvim_get_current_buf()
  local leader, pattern = fvim.utils.comment_parts(bufnr)
  if not leader then return plain() end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local indent, tag = tag_at(bufnr, row - 1, pattern)
  if not tag then return plain() end

  local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]
  local prefix = continuation_prefix(indent, leader, tag)
  local head = (line:sub(1, col):gsub("%s+$", ""))
  if #head < #prefix then return plain() end  -- cursor still inside the comment's own tag

  local tail = (line:sub(col + 1):gsub("^%s+", ""))
  vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, { head, prefix .. tail })
  vim.api.nvim_win_set_cursor(0, { row + 1, #prefix })
end


return M
