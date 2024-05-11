-- =============================================
-- ========== Plugin Loading
-- =============================================
local windows_ok, windows = pcall(require, "windows")
if not windows_ok then Fau_vim.load_plugin_error("windows") return end



-- =============================================
-- ========== Configuration
-- =============================================
vim.keymap.set("n", "<C-w>z", "<CMD>WindowsMaximize<CR>")
vim.keymap.set("n", "<C-w>_", "<CMD>WindowsMaximizeVertically<CR>")
vim.keymap.set("n", "<C-w>|", "<CMD>WindowsMaximizeHorizontally<CR>")
vim.keymap.set("n", "<C-w>=", "<CMD>WindowsEqualize<CR>")


local config = {
  autowidth = {
    enable = true,
    winwidth = 0.65,
  },
  ignore = {
    -- buftype = {  },
    filetype = Fau_vim.file.disabled_filetypes,
  },
  animation = {
    enable = true,
    duration = 250,
    fps = 60,
    easing = "in_out_sine",
  }
}


windows.setup(config)
