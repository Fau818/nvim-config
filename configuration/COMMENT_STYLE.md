# Comment Style

Section separator comments come in four **weights**.


| Weight | Form | Snippet |
|---|---|---|
| 1 | 3-line `═` box, label centred | `sec1` |
| 2 | single `═` line, label centred | `sec2` |
| 3 | single `─` line, label left | `sec3` |
| 4 | `┄` label, no tail | `sec4` |


```lua
-- ════════════════════════════════════════════════════════════
-- ═════════════════════════ Weight 1 ═════════════════════════
-- ════════════════════════════════════════════════════════════

-- ═════════════════════════ Weight 2 ═════════════════════════

-- ─── Weight 3 ───────────────────────────────────────────────

-- ┄┄┄ Weight 4
```

Weights 1-3 pad to **60 glyph columns past the comment leader** -- column 63 for
a `--` leader, 62 for `#`. Indentation eats into the tail, so right edges line up
however deep the marker sits. A label that would leave under 3 tail glyphs keeps
3 and overruns.

## Choosing a weight

**Weight is the size of a division, not its depth.** Start at whichever weight
fits the largest division; skipping a weight only means the file has no division
of that size.

- Weights 1 and 2 are one role at two costs, 1 above 2. Box it when skimming at
  speed must catch it and sections are ~20+ lines apart, so the frames do not
  dominate; single line otherwise. Both can appear in one file -- box for regions,
  single line for sections inside them -- but usually one of the two is enough.
- A marker dividing a block rather than the file takes weight 3 or 4, however big
  the block is. Indented 4+ spaces is almost always inside a block.

## Blank lines

**Above**, when a line of content precedes the marker:

- weight 1, 2, 3: **2**
- weight 4: **1**
- top of the file, or first thing inside a scope (`{`, `function(...)`, `do`, `then`): **0**

**Below**:

- centred (weight 1, 2), a banner that wants air: **1**
- left aligned (weight 3, 4), a label pointing at the code under it: **0**

Two markers in a row need no rule: the gap is the upper marker's `below`.
