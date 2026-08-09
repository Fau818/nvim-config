local M = {}


---Opening section marker; UTF-8 glyphs need no escaping.
local SEP_MARKERS = {
  "^═══",       -- `sec1`/`sec2`: a box frame line, or a centred banner
  "^───",       -- `sec3`: a tailed section
  "^┄┄┄",       -- `sec4`: a bare subsection
  "^===",       -- legacy ASCII section (3+ `=`)
  "^%-%-%-%-",  -- legacy ASCII subsection (4+ `-`, so the markdown `---` rule lives)
}


---Strip decorative section-marker comment lines from a markdown doc string.
---Run it on unescaped text: a legacy `----` marker reaches us as `\-\-\-\-`.
---@param value string
---@return string
function M.doc_cleaner(value)
  local kept = {}
  for _, line in ipairs(vim.split(value, "\n", { plain = true })) do
    local probe = line:gsub("^%s+", "")
    if not vim.iter(SEP_MARKERS):any(function(pat) return probe:match(pat) ~= nil end) then kept[#kept + 1] = line end
  end

  return table.concat(kept, "\n")
end


---Strip the escapes (`\_` -> `_`) pyright/basedpyright put on every Markdown special char in a docstring.
---@param value string
---@return string
function M.strip_escapes(value)
  local chars = "\\`*_{}[]()#+-.!"
  local class = chars:gsub(".", "%%%0")  -- escape every char for use inside a Lua pattern class
  local result = value:gsub("\\([" .. class .. "])", "%1")
  return result
end


---LSP hover `contents` can be a string, a { value = ... } object, or a list of either (MarkedString | MarkedString[] | MarkupContent).
---@param contents lsp.MarkedString | lsp.MarkedString[] | lsp.MarkupContent
---@return lsp.MarkedString | lsp.MarkedString[] | lsp.MarkupContent
local function scrub(contents)
  if type(contents) == "string" then return M.doc_cleaner(M.strip_escapes(contents))
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
