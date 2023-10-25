-- =============================================
-- ========== Plugin Loading
-- =============================================
local cmp_zsh_ok, cmp_zsh = pcall(require, "cmp_zsh")
if not cmp_zsh_ok then Fau_vim.load_plugin_error("cmp_zsh") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = { zshrc = true, filetypes = { "zsh", "sh" } }


cmp_zsh.setup(config)
