local fvim_augroup = vim.api.nvim_create_augroup("fau_vim", { clear = true })


-- ════════════════════════════════════════════════════════════
-- ═══════════════════════════ Core ═══════════════════════════
-- ════════════════════════════════════════════════════════════

-- ══════════════════════════ Basic ═══════════════════════════

---Keep cursor on the last closed position when enter a buffer.
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

---Disable horizonatal mouse scroll in terminal buffers.
vim.api.nvim_create_autocmd("TermOpen", {
  group = fvim_augroup,
  callback = function(ev)
    local opts = { buffer = ev.buf }
    for _, key in ipairs({ "<ScrollWheelLeft>", "<ScrollWheelRight>", "<S-ScrollWheelUp>", "<S-ScrollWheelDown>" }) do
      vim.keymap.set({ "n", "t" }, key, "<Nop>", opts)
    end
    vim.opt_local.wrap = true
  end,
})


-- ═══════════════════════ Indentation ════════════════════════

vim.api.nvim_create_autocmd("OptionSet", {
  group = fvim_augroup,
  pattern = "tabstop",
  desc = "`tabstop` will be reset to 2 if tabstop >= 8.",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = vim.go.tabstop end end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = fvim_augroup,
  pattern = "shiftwidth",
  desc = "Lock `shiftwidth` to 0",
  callback = function() vim.bo.shiftwidth = 0 end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  group = fvim_augroup,
  pattern = "softtabstop",
  desc = "Lock `softtabstop` to -1",
  callback = function() vim.bo.softtabstop = -1 end,
})


-- ═══════════════════════════ Yank ═══════════════════════════

vim.api.nvim_create_autocmd("TextYankPost", {
  group = fvim_augroup,
  pattern = "*",
  desc = "Highlight the yank section.",
  callback = function() vim.highlight.on_yank() end
})


-- ═══════════════════════════ Save ═══════════════════════════

vim.api.nvim_create_autocmd("BufReadPost", {
  group = fvim_augroup,
  pattern = "*",
  -- NOTE: The snapshot has to be taken while the file is untouched: a rule typed later
  -- on is indistinguishable from one the file came with. Deferred because this group is
  -- registered from `init.lua`, so it runs before filetype detection does and there is
  -- no `commentstring` to read yet.
  desc = "Opt a file that draws its own rules in ASCII out of the `---`/`===` shorthand.",
  callback = function(ev)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ev.buf) then
        vim.api.nvim_buf_call(ev.buf, fvim.format.detect_ascii_separators)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = fvim_augroup,
  pattern = "*",
  -- NOTE: The snapshot has to be taken while the file is untouched: a rule typed later
  -- on is indistinguishable from one the file came with. Deferred because this group is
  -- registered from `init.lua`, so it runs before filetype detection does and there is
  -- no `commentstring` to read yet.
  desc = "Opt a file that draws its own rules in ASCII out of the `---`/`===` shorthand.",
  callback = function(ev)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(ev.buf) then
        vim.api.nvim_buf_call(ev.buf, fvim.format.detect_ascii_separators)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = fvim_augroup,
  pattern = "*",
  desc = "Trim blank lines and spaces, and re-pad separator comments, before writing buffer to file.",
  callback = function()
    fvim.format.trim_text()
    fvim.format.normalize_separators()
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = fvim_augroup,
  pattern = "MiniSnippetsSessionStop",
  desc = "Re-pad the separator tail right after a `sec1`/`sec2` snippet is finished.",
  callback = function()
    local line = vim.fn.line(".")
    fvim.format.normalize_separators(line - 3, line + 2)
  end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = fvim_augroup,
  pattern = "*",
  desc = "Auto save buffer.",
  -- NOTE: `update` throws E32 on a nameless buffer, which passes both other guards.
  callback = function()
    if vim.bo.buftype == "" and vim.bo.modifiable and vim.api.nvim_buf_get_name(0) ~= "" then
      vim.cmd("update")
    end
  end,
})


-- ════════════════════════════════════════════════════════════
-- ═════════════════════ Non-VSCode Only ══════════════════════
-- ════════════════════════════════════════════════════════════

-- IMPORTANT: The following autocmds are only loaded in non-VSCode environment.
if vim.g.vscode then return end
-- WARNING: The following autocmds are only loaded in non-VSCode environment.


-- ══════════════════ Markdown Highlighting ═══════════════════

---Colored bold/italic markup for regular markdown buffers.
local fvim_markdown_hl_ns = vim.api.nvim_create_namespace("fvim_markdown_hl_ns")
vim.api.nvim_set_hl(fvim_markdown_hl_ns, "@markup.strong", { fg = fvim.colors.pink, bold = true })
vim.api.nvim_set_hl(fvim_markdown_hl_ns, "@markup.italic", { fg = fvim.colors.light_red, bold = true, italic = true })

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinNew" }, {
  group = vim.api.nvim_create_augroup("fau_tokyonight_markdown_regular_only", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" or vim.bo[args.buf].filetype ~= "markdown" then return end

    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_hl_ns(win, fvim_markdown_hl_ns)
  end,
})


-- ═══════════════════════ Auto Reload ════════════════════════

-- WORKAROUND: `autoread` only takes effect when Neovim explicitly checks a file's mtime.
-- Trigger it check on the events most likely to mean the file changed on disk.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = fvim_augroup,
  pattern = "*",
  desc = "Check if the current file has changed on disk and reload it.",
  callback = function() if vim.fn.mode() ~= "c" then vim.cmd("checktime") end end,
})

-- WORKAROUND: When we do vibe coding in a terminal, the file buffers might not be refreshed in time.
-- So we check all buffers 1s after the terminal last printed something.
local checktime_debounce = vim.uv.new_timer()
if checktime_debounce then
  vim.api.nvim_create_autocmd("TextChangedT", {
    group = fvim_augroup,
    pattern = "*",
    desc = "Recheck all buffers 1s after the Claude Code terminal last printed something.",
    callback = function(args)
      local ok, terminal = pcall(require, "claudecode.terminal")
      if not ok or args.buf ~= terminal.get_active_terminal_bufnr() then return end
      checktime_debounce:stop()
      checktime_debounce:start(1000, 0, vim.schedule_wrap(function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" then vim.cmd("checktime " .. buf) end
        end
      end))
    end,
  })
end

-- WORKAROUND: A same-filetype reload re-fires `FileType`, and stock ftplugins unconditionally undo buffer settings via `b:undo_ftplugin`.
-- Scope to affected filetypes and unchanged-filetype refires only, so real switches (json -> jsonc) still use Vim's normal undo-then-reload flow.
-- SEE: Only work around for filetypes disabled by `*_recommended_style`; check `lua/fau/config/init.lua`
vim.api.nvim_create_autocmd("FileType", {
  group = fvim_augroup,
  pattern = { "go", "markdown", "python", "rust", "yaml" },
  desc = "Don't let ftplugins undo their own settings on a same-filetype reload.",
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then return end
    if vim.b[args.buf].fvim_last_filetype == args.match then vim.b[args.buf].undo_ftplugin = nil end
    vim.b[args.buf].fvim_last_filetype = args.match
  end,
})


-- ════════════════════════ Filetypes ═════════════════════════

vim.api.nvim_create_autocmd("FileType", {
  group = fvim_augroup,
  pattern = { "snacks_notif", "git", "checkhealth", "grug-far-history", "help", "qf" },
  desc = "Use `q` to close window.",
  callback = function(args)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then return end
      vim.keymap.set(
        "n", "q", function() fvim.utils.buf_remove(args.buf) end,
        { buffer = args.buf, desc = "Quit buffer" }
      )
    end)
  end,
})


-- ════════════════════ Visual Block Mode ═════════════════════

-- SEE: https://github.com/neovim/neovim/issues/25926
-- WORKAROUND: Blockwise visual ops resolve their block boundaries from screen columns, which inline inlay-hint virt_text inflates.
-- Hide hints for the whole lifetime of a blockwise edit, including the insert phase of c/I/A.

local MAXCOL = vim.v.maxcol  -- curswant of `$`; drives the blockwise-$ feature
local MAX_TRY = 50
local DELAY = 20  -- ms

---Re-sync curswant with the cursor's current screen column, preserving `$`.
local function resync_curswant() if vim.fn.winsaveview().curswant < MAXCOL then vim.fn.winrestview({ curswant = vim.fn.virtcol(".") - 1 }) end end

---After hints are re-enabled, they reappear only once the LSP round-trip finishes.
---Anything reading the cursor in that window (statusline etc.) locks curswant to the hint-less layout,
---so j/k later drift left by the hint width. Poll until the hints are actually back, then re-sync.
---@param win integer
---@param bufnr integer
local function fixup_curswant_after_restore(win, bufnr)
  local pos = vim.api.nvim_win_get_cursor(win)
  local tries = 0

  local function is_valid()
    return vim.api.nvim_win_is_valid(win)
      and vim.api.nvim_win_get_buf(win) == bufnr
      and vim.api.nvim_get_mode().mode == "n"
      and not vim.b[bufnr].inlay_hint_hidden
      and vim.deep_equal(vim.api.nvim_win_get_cursor(win), pos)
  end

  local function fixup()
    tries = tries + 1
    if tries > MAX_TRY or not is_valid() then return end
    if #vim.lsp.inlay_hint.get({ bufnr = bufnr }) == 0 then vim.defer_fn(fixup, DELAY) return end
    vim.cmd("redraw")  -- make the decoration provider apply the extmarks now
    vim.api.nvim_win_call(win, resync_curswant)
  end

  fixup()
end

vim.api.nvim_create_autocmd("ModeChanged", {
  group = fvim_augroup,
  callback = function(args)
    local buf = args.buf
    ---@diagnostic disable-next-line: undefined-field
    local mode = vim.v.event.new_mode

    -- `inlay_hint_hidden`: set while we've force-hidden hints for a blockwise edit, so the elseif below knows there's something of ours to restore.
    if mode:find("\22") then
      if vim.lsp.inlay_hint.is_enabled({ bufnr = buf }) then
        vim.b[buf].inlay_hint_hidden = true
        vim.lsp.inlay_hint.enable(false, { bufnr = buf })
        -- curswant was computed while hints were visible; recompute it so j/k don't jump to the stale, hint-inflated screen column.
        resync_curswant()
      end
    elseif vim.b[buf].inlay_hint_hidden and not mode:find("[i\22]") then
      -- NOTE: `c/I/A` in V-B mode pass through insert mode, and <Esc> replication is screen-column based.
      -- Hints must stay hidden until back in normal mode. ModeChanged fires before replication, hence scheduling past current key processing.
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(buf) then return end
        -- FIX: VB mode -> insert -> <C-d>
        -- An insert-mode mapping running `normal!` (e.g. the `<D-v>` paste) round-trips i -> n -> v -> n and lands here,
        -- but we're back in the blockwise insert by now -- keep the hints hidden and wait for the edit to really end.
        if not vim.b[buf].inlay_hint_hidden then return end
        if vim.api.nvim_get_mode().mode:find("[i\22]") then return end
        vim.b[buf].inlay_hint_hidden = nil
        vim.lsp.inlay_hint.enable(true, { bufnr = buf })
        fixup_curswant_after_restore(vim.api.nvim_get_current_win(), buf)
      end)
    end
  end,
})


-- ══════════════════════ Pinned Windows ══════════════════════

-- ─── Pin & Redirect ─────────────────────────────────────────
---The side of the current window a main window belongs on: whichever one faces the editor's centre.
---@return "left"|"right"|"above"|"below"
local function main_side()
  local row, col = unpack(vim.api.nvim_win_get_position(0))
  local width, height = vim.api.nvim_win_get_width(0), vim.api.nvim_win_get_height(0)
  if width < vim.o.columns then return col * 2 + width > vim.o.columns and "left" or "right" end
  return row * 2 + height > vim.o.lines and "above" or "below"
end

---Pin `buf` to the current window: record it, and keep `wipe` buffers alive across redirects.
local function pin(buf)
  vim.w.pinned_buf = buf
  -- Taken now, while the window still has the neighbours that give the answer meaning.
  vim.w.main_side = main_side()
  if vim.bo[buf].bufhidden == "wipe" then vim.bo[buf].bufhidden = "hide" vim.b[buf].wipe_on_unpin = true end
end

---Wipe a `hide`-demoted pinned buffer.
local function unpin(buf)
  if not buf or not vim.api.nvim_buf_is_valid(buf) then return end
  if not vim.b[buf].wipe_on_unpin then return end
  vim.api.nvim_buf_delete(buf, { force = true })
end

---Pin windows for non-regular buffers.
vim.api.nvim_create_autocmd("BufEnter", {
  group = fvim_augroup,
  callback = function(env)
    if vim.api.nvim_win_get_config(0).relative ~= "" then return end
    if vim.bo[env.buf].buftype == "" or vim.bo[env.buf].filetype == "snacks_dashboard" then return end

    if vim.w.pinned_buf then return end

    -- Record the first non-regular buffer shown in the window as the pinned buffer.
    pin(env.buf)
  end,
})

---Wipe `hide`-demoted pinned buffers once their window closes (mirrors the original `wipe`).
vim.api.nvim_create_autocmd("WinClosed", {
  group = fvim_augroup,
  callback = function(env)
    local win = tonumber(env.match)
    if not win or not vim.api.nvim_win_is_valid(win) then return end
    unpin(vim.w[win].pinned_buf)
  end,
})

---Redirect buffer switches in pinned windows to an alternate window.
vim.api.nvim_create_autocmd("BufEnter", {
  group = fvim_augroup,
  callback = function(env)
    local pinned_buf = vim.w.pinned_buf
    if not pinned_buf or env.buf == pinned_buf then return end
    if not vim.api.nvim_buf_is_valid(pinned_buf) then return end

    -- NOTE: Allow buffer switches within non-regular buffers (e.g. aerial refreshing its outline).
    if vim.bo[env.buf].buftype ~= "" then unpin(pinned_buf) pin(env.buf) return end

    -- Redirect into a real editing window.
    local target = fvim.utils.get_main_win(function(w) return not vim.w[w].pinned_buf end)

    -- NOTE: Use `noautocmd` to place the buffer back silently.
    vim.cmd("noautocmd buffer " .. pinned_buf)

    if target then
      vim.api.nvim_win_set_buf(target, env.buf)
    else
      -- Every window is pinned -- the last main window is gone, so put one back where it used to sit.
      -- NOTE: `nvim_open_win` starts a split from the global option values; `:split` would copy the pinned window's.
      fvim.notify("No main window found, opening one.", vim.log.levels.ERROR)
      local ok, win = pcall(vim.api.nvim_open_win, env.buf, false, { win = 0, split = vim.w.main_side or "left" })
      if not ok then return end  -- NOTE: Too cramped to hold another window.
      target = win
    end

    vim.api.nvim_set_current_win(target)
  end,
})


-- ═══════════════════════════ LSP ════════════════════════════

-- WORKAROUND: On detach Neovim only resets the client's PUSH namespace (`vim/lsp/client.lua` `_on_detach`);
-- PULL diagnostics are cleared by a separate handler that fires only once the LAST pull-capable client
-- leaves the buffer. So with two pull servers on one buffer (e.g. python's `basedpyright` + `ruff`),
-- stopping one leaves its diagnostics stuck. Mirror the per-client push cleanup for pull.
vim.api.nvim_create_autocmd("LspDetach", {
  group = fvim_augroup,
  desc = "Clear a detaching client's stale (pull) diagnostics.",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- Diagnostic namespaces (`vim/lsp/diagnostic.lua`, `get_namespace`):
    --   push: `nvim.lsp.<name>.<id>`           -- one per client
    --   pull: `nvim.lsp.<name>.<id>.<pull_id>` -- one per provider
    -- Push is left alone (Neovim resets it on detach, `client.lua`). Pull can't be
    -- resolved without its `pull_id`, which isn't exposed -- so clear every namespace
    -- under the client's `...<id>.` prefix; the trailing dot selects pull only and
    -- stops id `1` matching `12`.
    local prefix = ("nvim.lsp.%s.%d."):format(client.name, client.id)
    local bufnr = args.buf
    -- Defer so any in-flight diagnostic response settles before we clear.
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) then return end
      for name, ns in pairs(vim.api.nvim_get_namespaces()) do
        if vim.startswith(name, prefix) then vim.diagnostic.reset(ns, bufnr) end
      end
    end)
  end,
})

---Neovim never stops a client just because its last buffer detached, so stop it once nothing is attached.
---Delayed so a quick buffer swap within the same project doesn't cause a pointless restart.
local LSP_STOP_DEBOUNCE = 3000
vim.api.nvim_create_autocmd("LspDetach", {
  group = fvim_augroup,
  desc = "Stop a client once its last attached buffer closes.",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name == "copilot" then return end
    vim.defer_fn(function()
      if not client:is_stopped() and vim.tbl_isempty(client.attached_buffers) then client:stop() end
    end, LSP_STOP_DEBOUNCE)
  end,
})


-- ══════════════════════ Shell Cwd Sync ══════════════════════

---The `nvim` wrapper in `zsh/plugins/neovim.zsh` sets this to a temp file path
---so that the shell can read the current working directory.
if vim.env.NVIM_CWD_FILE then
  vim.api.nvim_create_autocmd("VimLeave", {
    group = fvim_augroup,
    callback = function()
      local file = io.open(vim.env.NVIM_CWD_FILE, "w")
      if not file then return end
      file:write(vim.fn.getcwd())
      file:close()
    end,
  })
end


-- ══════════════════════════ Kitty ═══════════════════════════

if fvim.kitty.is_enabled then
  -- SEE: https://sw.kovidgoyal.net/kitty/mapping/#conditional-mappings-depending-on-the-state-of-the-focused-window
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    group = fvim_augroup,
    callback = fvim.kitty.activate_in_editor,
  })

  vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    group = fvim_augroup,
    callback = fvim.kitty.deactivate_in_editor,
  })

  vim.api.nvim_create_autocmd("TermEnter", {
    group = fvim_augroup,
    callback = function() fvim.kitty.deactivate_in_editor() end,
  })

  vim.api.nvim_create_autocmd("TermLeave", {
    group = fvim_augroup,
    callback = function() fvim.kitty.activate_in_editor() end,
  })
end
