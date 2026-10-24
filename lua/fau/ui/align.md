# align.lua

Keeps hand-aligned code aligned while LSP inlay hints are shown.


## The problem

Neovim draws an inlay hint as inline virtual text. The hint takes up screen cells in the middle of the line, so
everything after it moves right. Hand-aligned code relies on every row reaching its column at the same screen
cell. Once the rows get different amounts of hint text in front of that column, they stop lining up.

The source is aligned:

```lua
resize(80, 24)          -- default size
move(0)                 -- top-left
```

With parameter-name hints, it isn't:

```
resize(width: 80, height: 24)          -- default size
move(x: 0)                 -- top-left
```

The first row gets 15 cells of hints in front of its comment and the second gets 3, so the comments end up 12
cells apart. The same happens to aligned `=` signs, table values, and so on.

Neovim has no option for this, because inline virtual text always takes its own cells. No other editor found
handles it either (see [Prior art](#prior-art)), so the usual answer is to turn hints off or show them only on
demand.


## The solution

The hints can't be made narrower, but the other rows can be padded. When rows are aligned to one column, the
rows with fewer hint cells in front of it get extra spaces right before the column, and it lines up again:

```
resize(width: 80, height: 24)          -- default size
move(x: 0)                             -- top-left
```

- The text and the hints are untouched. The padding is virtual text too, and the cursor skips over it.
- A column moves right, to wherever its most-pushed row puts it.
- Several aligned columns on the same rows (for example `=` signs and comments) work too. Each column lines up
  after the padding added to the columns before it.


## Usage

- It works in every buffer that shows inlay hints, from any server (lua_ls, basedpyright, gopls, ...). There is
  nothing to configure.
- To turn it off, comment out `require("fau.ui.align")` in `lua/fau/ui/init.lua`. Nothing else in the config
  refers to this module.
- Hiding the hints (`<Leader>lh`, or `vim.lsp.inlay_hint.enable(false)`) removes the padding along with them.

A column counts as aligned when:

- nearby rows have the same kind of token at the same screen column: `--` under `--`, `=` under `=`, or a word
  or number under a word or number;
- at least one of those rows has 2 or more spaces in front of it, since a single space is ordinary spacing.

Rows that end before the column don't break it, and one longer row may run through it. A blank row ends it.

Not handled, on purpose:

- **A gap that contains a tab.** A tab already shrinks to absorb the hint cells in front of it.
- **Other virtual text,** such as Copilot or completion ghost text. Counting it would make whole blocks jump
  while you type.

**Blockwise Visual mode.** The workaround in `autocmd.lua` hides the hints during blockwise edits, and the
padding disappears in the same call, so nothing there needs to change. Keep that workaround, though. Blockwise
edits break wherever rows have hints of different widths in front of the block, whether the rows are aligned or
not. This was tested on 0.12.6 with the rows `f(long_name: 1, 2)` and `g(a: 1, 2)`, selecting both `1`s with
`<C-v>j`:

| Operation | Workaround on | Workaround removed |
|---|---|---|
| `d` | `f(, 2)` and `g(, 2)` | `f(, 2)` and `g(`: the rest of row 2 is deleted |
| `ly` | yanks `"1,\n1,"` | yanks `"1,\n1, 2)     "` |

**Names.** The padding is tagged with the highlight group `FvimHintAlign`, which has no attributes of its own.
The decoration provider is registered under the namespace `fvim_hint_align`.


## How it works

A decoration provider runs on every window redraw (`on_win`):

1. Return early if the buffer has no hints.
2. Widen the visible rows to whole units: runs of non-blank rows, cut at every multiple of 500. This way
   every window computes the same padding for a row.
3. Find the anchors, which are the characters a run of spaces leads up to. Chain the ones on nearby rows
   into columns, and note how many hint cells sit in front of each.
4. Going left to right, move each column as far as its most-pushed row needs, and pad the other rows to match.
5. Compare with the padding already placed, and change only what differs.

Design decisions:

- **The padding lives in the hints' own namespace, `nvim.lsp.inlayhint`** (marked `HACK:` in the code). That
  way, whatever clears the hints clears the padding in the same call. When the padding had its own namespace,
  it lasted one redraw longer than the hints. The blockwise workaround's `virtcol('.')` then counted it, and
  `<C-v>` then `j` landed 8 columns too far right.
- **The module loads `vim.lsp.inlay_hint` before registering.** Decoration providers run in the order they
  were first registered, not in namespace order (probed on 0.12.6), and this one has to see the hints that
  `vim.lsp` places in the same redraw.
- **Units keep windows in agreement.** The marks belong to the buffer, so if two windows computed different
  padding, each would keep undoing the other's, forever.
- **Marks are diffed, not rewritten.** Every extmark change schedules a redraw of its line.
- **`priority = 0`** lays the padding out first in its column. **`hl_mode = "combine"`** lets the CursorLine
  and Visual backgrounds show through it.
- **Only alike tokens chain.** This rule came from a survey of 10 config files with real lua_ls hints. Without
  it, code that happened to reach a comment column dragged the comments along 5 times, and once the padding
  landed inside a string.

Rejected alternatives:

- **Concealing spaces.** The concealed spaces would reappear on the cursor line.
- **Ephemeral extmarks.** Neovim 0.12.6 doesn't draw inline virtual text from ephemeral marks.
- **A `refresh()` call in `autocmd.lua`.** It would tie the two files together.
- **Wrapping `vim.lsp.inlay_hint.enable`.** It patches a core function and misses the other ways hints get
  cleared.


## Limits

- While you edit a row inside an aligned block, that row can look further out of line than it is in the source.
- `vim.lsp` only places hint marks on rows that have been on screen. Scrolling more of a long block into view
  can therefore push its column further right.
- A column never continues across a multiple of 500 rows.
- The module relies on `vim.lsp` internals:
  - the namespace name;
  - hints being persistent extmarks placed in `on_win`;
  - hints being cleared with `nvim_buf_clear_namespace`.

  Recheck these after a Neovim upgrade (`runtime/lua/vim/lsp/inlay_hint.lua`). The worst case is that the
  padding stops working or stays one redraw too long. It can't change any text.
- In Visual mode, `ui/whitespace.lua` marks only the real spaces, so the padding cells stay blank.
- Cost:
  - about 0.18 ms per redraw of a 53-row window;
  - it grows with rows times aligned columns: 200 rows with 150 columns each took about 10 ms.


## Verified

Tested on 2026-10-24 with Neovim 0.12.6 and lua_ls 3.19.2, headless, reading the result back with
`screenstring()`:

- With real lua_ls hints, the table in `noice/hover.lua` lines up, and so do aligned `=` signs and comments.
  Across 10 config files, padding appears nowhere else.
- Editing in Insert mode, undo and redo, adding a row while hints refresh, and `vim.lsp` re-applying hints all
  keep the block aligned.
- Hiding the hints, per buffer or globally, removes the padding in the same call, and it comes back with the
  hints.
- With `autocmd.lua` unmodified, `<C-v>` then `j` lands on the same text column.
- Two windows with different views of one buffer settle after one redraw.
- Also covered:
  - leading tabs;
  - tab gaps;
  - CJK text;
  - CursorLine and Visual backgrounds;
  - a block that crosses row 500.
- LuaLS reports no problems.


## Re-testing

```lua
-- Save as probe.lua and run: nvim --clean --headless -c 'luafile probe.lua'
vim.o.columns = 80
dofile(vim.fn.expand("~/.config/nvim/lua/fau/ui/align.lua"))
local ns = vim.api.nvim_create_namespace("nvim.lsp.inlayhint")
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "resize(80, 24)          -- default size", "move(0)                 -- top-left" })
local function hint(row, col, text) vim.api.nvim_buf_set_extmark(0, ns, row, col, { virt_text = { { text } }, virt_text_pos = "inline" }) end
hint(0, 7, "width: "); hint(0, 11, "height: "); hint(1, 5, "x: ")
vim.cmd("redraw!")  -- a headless instance only redraws when told to
for row = 1, 2 do
  local cells = {}
  for col = 1, 60 do cells[#cells + 1] = vim.fn.screenstring(row, col) end
  print(table.concat(cells))  -- both `--` should sit in one column
end
vim.cmd("qa!")
```

To test with real hints, open a file and wait for the server to start. Then turn hints off and on once with
`vim.lsp.inlay_hint.enable(false/true, { bufnr = 0 })`, and run `redraw` until the hint marks appear. A headless
instance can record lines as drawn before the hints arrive, and the off/on cycle makes `vim.lsp` draw them
again.


## Prior art

From a web search on 2026-10-24. The links were not re-checked.

- VS Code closed the request as working as designed (microsoft/vscode#166947). Its mitigation is
  `editor.inlayHints.enabled: offUnlessPressed`.
- ReSharper 2022.2 has a "Fix alignment for Inlay Hints" option, but it covers multiline statements only.
- Neovim upstream has nothing. A PR to shift `colorcolumn` by the width of hints was closed
  (neovim/neovim#24090).
- The same technique, padding the other rows with inline extmarks, appears in `elastictabstops.nvim` and in
  render-markdown's padded table cells.
