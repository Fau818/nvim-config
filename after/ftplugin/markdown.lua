if vim.bo.buftype ~= "" then return end

if vim.b.fvim_markdown_ftplugin_loaded then return end
vim.b.fvim_markdown_ftplugin_loaded = true

-- vim.opt_local.spell = true
-- vim.opt_local.spelllang = "en_us"
