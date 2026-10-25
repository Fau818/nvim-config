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

## What saving does

- The shorthand turns into box-drawing characters.
- Weights 0-3 end **60 columns past the comment leader**: column 62 for `#`, 63 for
  `--`. Indented markers are shorter, so right edges line up at any depth.
- Labels are centered again, and a box widens for a long label.
- Left alone: filetypes with block comments, and the shorthand in files that already
  use ASCII rules (`# --- Name ---`).

`vim.g.fvim_format_sep = false` turns it off, and `:NormalizeSeparators` runs it on
demand. The code is in `lua/fau/functions/format/init.lua`, the snippets in
`snippets/all.json`.

## Choosing a weight

**Weight is the size of a division, not its depth.**

- **0**: the file's title, at most once, at the top.
- **1**: the biggest parts of a long file, as a guide ~20+ lines each. Parts at the
  same level keep the same weight, even a short one.
- **2**: the next size down, or the top level of a shorter file.
- **3** and **4**: smaller groups, and any division inside a block.

## Blank lines

| Weight | Above | Below |
|---|---|---|
| 0 | 0, or 1 after a shebang | 1 |
| 1, 2 | 2 | 1 |
| 3 | 2 | 0 |
| 4 | 1 | 0 |

Centered markers are banners and want air below; left-aligned ones label the code
right under them. **Above** is 0:

- at the top of the file, or inside a scope (`{`, `function(...)`, `do`, `then`);
- optionally, under a header of the file's own format, such as an INI `[Section]`;
- optionally, between tiny weight-4 parts of a line or two.

Two markers in a row: the gap is the upper one's **Below**.
