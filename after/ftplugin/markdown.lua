if vim.bo.buftype ~= "" then return end

if vim.b.fvim_markdown_ftplugin_loaded then return end
vim.b.fvim_markdown_ftplugin_loaded = true

-- vim.opt_local.spell = true
-- vim.opt_local.spelllang = "en_us"


-- ==================== Markdown Highlight Group ====================
local ns = vim.api.nvim_create_namespace("markdown_custom_hl")

if not vim.g.markdown_hl_set then
  vim.api.nvim_set_hl(ns, "@markup.strong", { bold = true, fg = "#FCA7EA" })
  vim.g.markdown_hl_set = true
end

vim.api.nvim_win_set_hl_ns(0, ns)
