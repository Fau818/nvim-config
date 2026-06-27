-- =============================================================================
-- HACK: nested-field filtering for the snacks.picker matcher.
-- =============================================================================
-- snacks supports `field:value`, but only for TOP-LEVEL fields: internally it
-- does `tostring(item[field])`. Values that live in a sub-table, e.g. the
-- `keymaps` source where the buffer number sits at `item.item.buf`, are not
-- reachable.
--
-- This patch teaches the matcher to walk a dotted path:
--
--     item.buf:2         -> item.item.buf       (fuzzy "2")
--     item.item.desc:diff-> item.item.desc
--     info.what:Lua$     -> item.info.what      (all value modifiers still work)
--
-- A field with a dot (`a.b...:value`) is treated as a path relative to the
-- picker item. The original `field:value` behavior (single, dot-less field) is
-- untouched.
--
-- Ambiguity with the built-in `file.ext:line` navigation is resolved per item:
-- the nested interpretation only wins when the item ACTUALLY has that nested
-- path. Otherwise we fall back to snacks' original handling, so e.g.
-- `gitsigns.lua:34` still jumps to line 34 in a files picker (no item there has
-- an `item.gitsigns.lua` field, so it falls back).
-- =============================================================================

local M = {}

-- Two extra fields we bolt onto the matcher's per-pattern mods table.
---@class snacks.picker.matcher.Mods
---@field nested? string[] dotted path walked per-item to resolve the value
---@field nested_mods? snacks.picker.matcher.Mods value matcher reading from SCRATCH

-- A scratch key that cannot collide with any real item field. The resolved
-- nested value is parked here so the original matcher can read it, then removed.
local SCRATCH = "__snacks_nested_value__"

local patched = false

function M.setup()
  if patched then return end
  local Matcher = require("snacks.picker.core.matcher")

  local orig_prepare = Matcher._prepare
  ---@diagnostic disable-next-line: duplicate-set-field
  function Matcher:_prepare(pattern)
    -- A dotted field path: `a.b.c:value` (requires at least one dot, no slash).
    local field, rest = pattern:match("^([%w_]+%.[%w_.]*):(.*)$")
    if field then
      -- `base` keeps snacks' original interpretation (file:line / literal text)
      -- as a per-item fallback. Calling orig_prepare also sets `self.file` when
      -- the pattern is file:line-shaped, so navigation keeps working.
      local base = orig_prepare(self, pattern)
      base.nested = vim.split(field, ".", { plain = true })
      -- A separate value parser for the nested branch. Reuses every modifier
      -- (!, '...', ^, $, smartcase) via a dummy flat field, then reads from the
      -- collision-proof scratch key.
      base.nested_mods = orig_prepare(self, "nestedfield:" .. rest)
      base.nested_mods.field = SCRATCH
      return base
    end
    return orig_prepare(self, pattern)
  end

  local orig_match = Matcher._match
  ---@diagnostic disable-next-line: duplicate-set-field
  function Matcher:_match(item, mods)
    if not mods.nested then return orig_match(self, item, mods) end

    -- Resolve the nested value by walking the path.
    local val = item
    for _, key in ipairs(mods.nested) do
      if type(val) ~= "table" then val = nil break end
      val = val[key]
    end

    -- Item doesn't have this nested path: fall back to the original behavior
    -- (e.g. `foo.lua:34` file:line navigation).
    if val == nil then return orig_match(self, item, mods) end

    -- Empty value (mid-typing, e.g. `item.buf:`) matches anything that has the
    -- path. Guard before orig_match, whose fuzzy path crashes on an empty pattern.
    if mods.nested_mods.pattern == "" then return Matcher.DEFAULT_SCORE end

    -- Match the value against the scratch key, never touching real fields.
    item[SCRATCH] = val
    local a, b, c, d = orig_match(self, item, mods.nested_mods)
    item[SCRATCH] = nil
    return a, b, c, d
  end

  -- Input prompt highlighting. snacks highlights field names in the search box
  -- with `matchadd("@keyword", "\v(^|\s)\zs\w+:")`, but `\w` stops at the dot,
  -- so a dotted path like `item.buf:` gets no highlight. Add a dot-aware match
  -- so nested fields look the same as plain `file:`.
  local Input = require("snacks.picker.core.input")
  local orig_highlights = Input.highlights
  ---@diagnostic disable-next-line: duplicate-set-field
  function Input:highlights()
    orig_highlights(self)
    vim.api.nvim_win_call(self.win.win, function() vim.fn.matchadd("@keyword", "\\v(^|\\s)\\zs[0-9A-Za-z_.]+:") end)
  end

  patched = true
end

return M
