-- ==================== Initialization ====================
local fvim_augroup = vim.api.nvim_create_augroup("fau_vim", { clear = true })


-- =============================================
-- ========== Basic
-- =============================================
-- Keep cursor on the last closed position when enter a buffer.
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

-- ==================== Yank ====================
vim.api.nvim_create_autocmd("TextYankPost", {
  group = fvim_augroup,
  pattern = "*",
  desc = "Highlight the yank section.",
  callback = function() vim.highlight.on_yank() end
})


-- ==================== Save ====================
vim.api.nvim_create_autocmd("BufWritePre", {
  group = fvim_augroup,
  pattern = "*",
  desc = "Trim blank lines and spaces before writing buffer to file.",
  callback = function() fvim.format.trim_text() end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  group = fvim_augroup,
  pattern = "*",
  desc = "Auto save buffer.",
  callback = function() if vim.bo.buftype == "" and vim.bo.modifiable then vim.cmd("update") end end,
})


-- ==================== Autoread ====================
-- NOTE: `autoread` only takes effect when Neovim explicitly checks a file's
-- mtime; it does not poll on its own. Trigger that check on the events most
-- likely to mean the file changed on disk.
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = fvim_augroup,
  pattern = "*",
  desc = "Check if the current file has changed on disk and reload it.",
  callback = function() if vim.fn.mode() ~= "c" then vim.cmd("checktime") end end,
})


-- ==================== Indentation ====================
vim.api.nvim_create_autocmd("OptionSet", {
  group = fvim_augroup,
  pattern = "tabstop",
  desc = "`tabstop` will be reset to 2 if tabstop >= 8.",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = 2 end end,
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


-- =============================================
-- ========== Filetypes
-- =============================================
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = fvim_augroup,
  pattern = "*.dconf",
  desc = "Take `*.dconf` as `conf` filetype. (For Surge Detached Configuration)",
  callback = function() vim.opt_local.filetype = "conf" end
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = fvim_augroup,
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  desc = "Correct filetype for docker-compose.",
  callback = function() vim.opt_local.filetype = "yaml.docker-compose" end
})

vim.api.nvim_create_autocmd("FileType", {
  group = fvim_augroup,
  pattern = { "snacks_notif", "git", "checkhealth", "grug-far-history", "help", "qf" },
  desc = "Use `q` to close window.",
  callback = function(args)
    -- vim.bo[args.buf].buflisted = false
    -- vim.schedule(function()
    --   vim.keymap.set("n", "q", function()
    --     vim.cmd("close")
    --     pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
    --   end, { buffer = args.buf, silent = true, desc = "Quit buffer" })
    -- end)

    -- TEST: Use fvim.utils.buf_remove() to remove the buffer. (On Jun 23, 2026)
    vim.schedule(function()
      vim.keymap.set("n", "q", function() fvim.utils.buf_remove(args.buf) end, { buffer = args.buf, desc = "Quit buffer" })
    end)
  end,
})


-- =============================================
-- ========== Visual Block Mode
-- =============================================
-- SEE: https://github.com/neovim/neovim/issues/25926
-- WORKAROUND: Blockwise visual ops resolve their block boundaries from screen columns,
-- which inline inlay-hint virt_text inflates. Hide hints for the whole
-- lifetime of a blockwise edit, including the insert phase of c/I/A.

local MAXCOL = 2147483647  -- curswant of `$`; drives the blockwise-$ feature
local MAX_TRY = 50
local DELAY = 20   -- ms

---Re-sync curswant with the cursor's current screen column, preserving `$`.
local function resync_curswant() if vim.fn.winsaveview().curswant < MAXCOL then vim.fn.winrestview({ curswant = vim.fn.virtcol(".") - 1 }) end end

---After hints are re-enabled, they reappear only once the LSP round-trip
---finishes. Anything reading the cursor in that window (statusline etc.)
---locks curswant to the hint-less layout, so j/k later drift left by the
---hint width. Poll until the hints are actually back, then re-sync.
---@param win integer
---@param bufnr integer
local function fixup_curswant_after_restore(win, bufnr)
  local pos = vim.api.nvim_win_get_cursor(win)
  local tries = 0

  local function is_valid()
    return vim.api.nvim_win_is_valid(win)
      and vim.api.nvim_win_get_buf(win) == bufnr
      and vim.api.nvim_get_mode().mode == "n"
      and not vim.b[bufnr].inlay_hint_restore
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
    ---@diagnostic disable-next-line: undefined-field
    local mode = vim.v.event.new_mode

    if mode:find("\22") then
      -- The `inlay_hint_restore` check covers re-entering blockwise mode
      -- before a pending scheduled restore has run.
      if vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }) or vim.b[args.buf].inlay_hint_restore then
        vim.b[args.buf].inlay_hint_restore = true
        vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
        -- curswant was computed while hints were visible; recompute it so
        -- j/k don't jump to the stale, hint-inflated screen column.
        resync_curswant()
      end
    elseif vim.b[args.buf].inlay_hint_restore and not mode:find("[i\22]") then
      -- NOTE: `c/I/A` in V-B mode pass through insert mode, and <Esc> replication is screen-column based.
      -- Hints must stay hidden until back in normal mode. ModeChanged fires before replication, hence scheduling past current key processing.
      vim.b[args.buf].inlay_hint_restore = nil
      vim.schedule(function()
        if not vim.api.nvim_buf_is_valid(args.buf) or vim.b[args.buf].inlay_hint_restore then return end
        vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        fixup_curswant_after_restore(vim.api.nvim_get_current_win(), args.buf)
      end)
    end
  end,
})


-- =============================================
-- ========== Pinned Windows
-- =============================================
---Pin `buf` to the current window: record it, and keep `wipe` buffers alive across redirects.
local function pin(buf)
  vim.w.pinned_buf = buf
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
    if not target then fvim.notify("Switch buffer failed.", vim.log.levels.ERROR) return end

    -- NOTE: Use `noautocmd` to place the buffer back silently.
    vim.cmd("noautocmd buffer " .. pinned_buf)
    vim.api.nvim_win_set_buf(target, env.buf)
    vim.api.nvim_set_current_win(target)
  end,
})


-- =============================================
-- ========== LSP
-- =============================================
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = fvim_augroup,
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if not client then fvim.notify("Failed to get LSP client.", vim.log.levels.ERROR) return end
--     fvim.lsp.on_attach(client, args.buf)
--   end,
-- })

-- FIX: On detach Neovim only resets the client's PUSH namespace (`vim/lsp/client.lua`
-- `_on_detach`); PULL diagnostics are cleared by a separate handler that fires only
-- once the LAST pull-capable client leaves the buffer. So with two pull servers on
-- one buffer (e.g. python's `basedpyright` + `ruff`), stopping one leaves its
-- diagnostics stuck. Mirror the per-client push cleanup for pull.
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


-- =============================================
-- ========== Kitty
-- =============================================
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
