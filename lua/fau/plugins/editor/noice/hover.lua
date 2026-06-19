-- ==================== Hover: strip decorative comment lines ====================
-- lua_ls (and other servers) bind a comment touching a definition as its
-- documentation, so our section separators (`seccom`/`secsep`/`subseccom`/
-- `subsecsep` snippets) leak into the hover doc. noice renders hover via its own
-- pipeline (`vim.lsp.buf.hover = noice M.hover` -> `noice.lsp.hover.on_hover` ->
-- `Format.format(message, result.contents)`), bypassing `vim.lsp.handlers` and
-- `vim.lsp.util.convert_input_to_markdown_lines`. So we wrap `on_hover` and scrub
-- `result.contents` before noice ever formats it.

local M = {}

-- LSP hover `contents` can be a string, a { value = ... } object, or a list of
-- either (MarkedString | MarkedString[] | MarkupContent). Scrub each variant via
-- the shared `fvim.utils.strip_doc_separators`.
---@param contents string | MarkedString[] | MarkupContent
---@return any
local function scrub(contents)
  if type(contents) == "string" then return fvim.utils.doc_cleaner(contents)
  elseif type(contents) == "table" then
    if type(contents.value) == "string" then contents.value = fvim.utils.doc_cleaner(contents.value)
    elseif vim.islist(contents) then for i, c in ipairs(contents) do contents[i] = scrub(c) end end
  end
  return contents
end


-- Wrap `noice.lsp.hover.on_hover`. `noice.lsp.M.hover` re-`require`s the hover
-- module and reads `.on_hover` on every call, so replacing the field is enough.
function M.setup()
  local ok, Hover = pcall(require, "noice.lsp.hover")
  if not ok then return end
  if Hover.__strip_decorative then return end
  Hover.__strip_decorative = true

  local on_hover = Hover.on_hover
  ---@diagnostic disable-next-line: duplicate-set-field
  Hover.on_hover = function(err, result, ctx)
    if result and result.contents then result.contents = scrub(result.contents) end
    return on_hover(err, result, ctx)
  end
end


return M
