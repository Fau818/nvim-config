-- ==================== Initialization ====================
vim.api.nvim_create_augroup("fau_vim", { clear = true })


-- =============================================
-- ========== Basic
-- =============================================
-- Keep cursor on the last closed position when enter a buffer.
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

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

-- DESC: Use `q` to close the float window.
vim.api.nvim_create_autocmd("FileType", {
  group = "fau_vim",
  desc = "Use `q` to close the float window.",
  pattern = { "snacks_notif", "git" },
  callback = function() vim.keymap.set("n", "q", "<CMD>q<CR>", { silent=true, buffer=true }) end
})

-- DESC: Treat docker-compose.yaml and docker-compose.yml to docker-compose filetype.
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = "fau_vim",
  desc = "Correct filetype for docker-compose.",
  pattern = { "docker-compose.yaml", "docker-compose.yml" },
  callback = function() vim.opt_local.filetype = "yaml.docker-compose" end
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
