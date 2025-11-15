if vim.b.fvim_qf_ftplugin_loaded then return end
vim.b.fvim_qf_ftplugin_loaded = true

-- DESC: `<CR>` to open the entry.
vim.keymap.set("n", "<CR>", "<CR>", { silent=true, buffer=true })
