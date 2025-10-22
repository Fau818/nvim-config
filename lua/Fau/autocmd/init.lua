-- ==================== Initialization ====================
vim.api.nvim_create_augroup("Fau_vim", { clear = true })


-- ==================== Components ====================
require("Fau.autocmd.basic")
require("Fau.autocmd.filetype")
