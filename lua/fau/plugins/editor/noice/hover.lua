local M = {}


-- ==================== CLeanup Functions ====================
---Strip decorative section-separator comment lines from a markdown doc string.
---A line is dropped when (ignoring leading whitespace and any backslashes)
---it starts with `===` (3+ `=`) or `----` (4+ `-`, so the markdown `---` rule lives).
---@param value string
---@return string
function M.doc_cleaner(value)
  local kept = {}
  for _, line in ipairs(vim.split(value, "\n", { plain = true })) do
    local probe = line:gsub("^%s+", ""):gsub("\\", "")
    if not (probe:match("^===") or probe:match("^%-%-%-%-")) then kept[#kept + 1] = line end
  end

  return table.concat(kept, "\n")
end


---Strip Markdown backslash-escapes (`\_` -> `_`, `\*` -> `*`, ...) that pyright/basedpyright add
---defensively when turning a docstring into hover Markdown, even though a lone `_`/`*` fully inside a word
---@param value string
---@return string
function M.unescape_markdown(value)
  local chars = "\\`*_{}[]()#+-.!"
  local class = chars:gsub(".", "%%%0")  -- escape every char for use inside a Lua pattern class
  local result = value:gsub("\\([" .. class .. "])", "%1")
  return result
end


---LSP hover `contents` can be a string, a { value = ... } object, or a list of either (MarkedString | MarkedString[] | MarkupContent).
---@param contents lsp.MarkedString | lsp.MarkedString[] | lsp.MarkupContent
---@return lsp.MarkedString | lsp.MarkedString[] | lsp.MarkupContent
local function scrub(contents)
  if type(contents) == "string" then return M.unescape_markdown(M.doc_cleaner(contents))
  elseif type(contents) == "table" then
    if type(contents.value) == "string" then contents.value = scrub(contents.value)  --[[@as string]]
    elseif vim.islist(contents) then for i, c in ipairs(contents) do contents[i] = scrub(c)  --[[@as lsp.MarkedString]] end end
  end
  return contents
end


-- Wrap `noice.lsp.hover.on_hover`. `noice.lsp.M.hover` re-`require`s the hover
-- module and reads `.on_hover` on every call, so replacing the field is enough.
function M.setup()
  local ok, Hover = pcall(require, "noice.lsp.hover")
  if not ok then return end
  if Hover._hover_patched then return end
  Hover._hover_patched = true

  local _on_hover = Hover.on_hover
  ---@diagnostic disable-next-line: duplicate-set-field
  Hover.on_hover = function(err, result, ctx)
    if result and result.contents then result.contents = scrub(result.contents) end
    return _on_hover(err, result, ctx)
  end
end


return M
