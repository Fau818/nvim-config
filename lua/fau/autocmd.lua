-- ==================== Initialization ====================
vim.api.nvim_create_augroup("fau_vim", { clear = true })


-- =============================================
-- ========== Basic
-- =============================================
-- Keep cursor on the last closed position when enter a buffer.
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

---Disable horizonatal mouse scroll in terminal buffers.
vim.api.nvim_create_autocmd("TermOpen", {
  group = "fau_vim",
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
  pattern = "*",
  group = "fau_vim",
  desc = "Highlight the yank section.",
  callback = function() vim.highlight.on_yank() end
})


-- ==================== Save ====================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = "fau_vim",
  desc = "Trim blank lines and spaces before writing buffer to file.",
  callback = function() fvim.format.trim_text() end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  pattern = "*",
  group = "fau_vim",
  desc = "Auto save buffer.",
  callback = function() if vim.bo.buftype == "" and vim.bo.modifiable then vim.cmd("update") end end,
})


-- ==================== Indentation ====================
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "tabstop",
  group = "fau_vim",
  desc = "`tabstop` will be reset to 2 if tabstop >= 8.",
  callback = function() if vim.bo.tabstop >= 8 then vim.bo.tabstop = 2 end end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "shiftwidth",
  group = "fau_vim",
  desc = "Lock `shiftwidth` to 0",
  callback = function() vim.bo.shiftwidth = 0 end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "softtabstop",
  group = "fau_vim",
  desc = "Lock `softtabstop` to -1",
  callback = function() vim.bo.softtabstop = -1 end,
})


-- =============================================
-- ========== Filetypes
-- =============================================
-- DESC: Take `*.dconf` as `conf` filetype. (For Surge Detached Configuration)
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.dconf",
  group = "fau_vim",
  desc = "Take `*.dconf` as `conf` filetype.",
  callback = function() vim.opt_local.filetype = "conf" end
})

-- DESC: Treat docker-compose.yaml and docker-compose.yml to docker-compose filetype.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = "fau_vim",
  desc = "Correct filetype for docker-compose.",
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  callback = function() vim.opt_local.filetype = "yaml.docker-compose" end
})

-- DESC: Use `q` to close certain filetypes.
vim.api.nvim_create_autocmd("FileType", {
  group = "fau_vim",
  desc = "Use `q` to close window.",
  pattern = { "snacks_notif", "git", "checkhealth", "grug-far-history", "help", "qf" },
  callback = function(args)
    vim.bo[args.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, args.buf, { force = true })
      end, { buffer = args.buf, silent = true, desc = "Quit buffer" })
    end)
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
  group = "fau_vim",
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
  group = "fau_vim",
  callback = function(env)
    local win = tonumber(env.match)
    if not win or not vim.api.nvim_win_is_valid(win) then return end
    unpin(vim.w[win].pinned_buf)
  end,
})

---Redirect buffer switches in pinned windows to an alternate window.
vim.api.nvim_create_autocmd("BufEnter", {
  group = "fau_vim",
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
vim.api.nvim_create_autocmd("LspAttach", {
  group = "fau_vim",
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then fvim.notify("Failed to get LSP client.", vim.log.levels.ERROR) return end
    fvim.lsp.on_attach(client, args.buf)
  end,
})


-- =============================================
-- ========== Kitty
-- =============================================
if fvim.kitty.is_enabled then
  -- SEE: https://sw.kovidgoyal.net/kitty/mapping/#conditional-mappings-depending-on-the-state-of-the-focused-window
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    group = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true }),
    callback = fvim.kitty.activate_in_editor,
  })

  vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
    callback = fvim.kitty.deactivate_in_editor,
  })

  vim.api.nvim_create_autocmd("TermEnter", {
    group = "fau_vim",
    callback = function() fvim.kitty.deactivate_in_editor() end,
  })

  vim.api.nvim_create_autocmd("TermLeave", {
    group = "fau_vim",
    callback = function() fvim.kitty.activate_in_editor() end,
  })
end
