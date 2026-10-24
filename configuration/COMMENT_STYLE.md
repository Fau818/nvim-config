# Comment Style

Section separators are comments that split a file into parts you can spot while
scrolling. They come in five **weights**, from 0 (heaviest) to 4 (lightest):

```lua
-- ╔══════════════════════════════════════════════════════════╗
-- ║                         Weight 0                         ║
-- ╚══════════════════════════════════════════════════════════╝

-- ┌──────────────────────────────────────────────────────────┐
-- │                         Weight 1                         │
-- └──────────────────────────────────────────────────────────┘

-- ═════════════════════════ Weight 2 ═════════════════════════

-- ─── Weight 3 ───────────────────────────────────────────────

-- ┄┄┄ Weight 4
```

A box outranks a line, and double (`═`) outranks single (`─`).

## Writing one

No need to draw them by hand. Expand a snippet, or type the shorthand and save:

| Weight | Snippet | Shorthand |
|---|---|---|
| 0 | `sec0` | a label between two `===` lines |
| 1 | `sec1` | a label between two `---` lines |
| 2 | `sec2` | `=== Label` |
| 3 | `sec3` | `--- Label` |
| 4 | `sec4` | `~~~ Label` |

One line makes a line and a label between two makes a box; `=` draws double, `-`
single.

## What saving does

Saving redraws every marker in the file, and finishing a snippet redraws the ones
it inserted:

- The shorthand turns into box-drawing characters.
- Weights 0-3 end **60 columns past the comment leader**: column 63 for `--`, 62
  for `#`. Indentation shortens the marker, so right edges line up at any depth.
- An edited label is centered again. A line whose label is too long keeps 3 rule
  characters on each side and runs over; a box grows to keep 2 spaces either side
  of its label, and shrinks back once the label is shorter.

It leaves alone:

- A file that already has ASCII rules (`# --- Name ---`) when opened. The shorthand
  is off there, but markers drawn in glyphs are still redrawn.
- Filetypes with block comments (`/* %s */`, `<!-- %s -->`).

To turn it off, set `vim.g.fvim_format_sep = false` (or `0`), or `vim.b` for one
buffer; `fvim_format` turns off every format step. `:NormalizeSeparators` redraws
on demand, over a range if given; with `!` it also applies the shorthand in an
ASCII file.

The code is in `lua/fau/functions/format/init.lua`, the snippets in `snippets/all.json`.

## Choosing a weight

**Weight is the size of a division, not its depth.** Start at whichever weight
fits the largest division; skipping a weight only means the file has no division
of that size.

- Weight 0 is the file's title: at most once, at the very top.
- Weight 1 marks the biggest parts of a long file. Use it only when they are ~20+
  lines apart, or the boxes crowd the code. Weight 2 is the next size down, or the
  top level of a shorter file.
- A marker dividing a block rather than the file takes weight 3 or 4, however big
  the block is. Indented 4+ spaces is almost always inside a block.
- Below the title, a file rarely needs more than three weights; needing a fourth
  usually means it should be split.

## Blank lines

| Weight | Above | Below |
|---|---|---|
| 0 | 0 (it opens the file) | 1 |
| 1, 2 | 2 | 1 |
| 3 | 2 | 0 |
| 4 | 1 | 0 |

Centered markers are banners and want air below; left-aligned ones label the code
right under them. **Above** is 0 when the marker is the first thing in the file or
inside a scope (`{`, `function(...)`, `do`, `then`). Two markers in a row need no
rule: the gap is the upper marker's **Below**.
