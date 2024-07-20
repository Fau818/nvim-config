-- ==================== Initialization ====================
vim.api.nvim_create_augroup("Fau_vim", { clear = true })


-- ==================== Components ====================
require("Fau.core.Fau_vim.autocmd.basic")
require("Fau.core.Fau_vim.autocmd.filetype")
