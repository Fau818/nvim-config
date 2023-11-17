-- =============================================
-- ========== Plugin Loading
-- =============================================
local noice_ok, noice = pcall(require, "noice")
if not noice_ok then Fau_vim.load_plugin_error("noice") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = require("Fau.core.noice.config")
noice.setup(config)



-- =============================================
-- ========== Keymaps
-- =============================================
vim.keymap.set("n", "<C-f>", function()
  if not require("noice.lsp").scroll(2) then
    return Fau_vim.functions.utils.reveal_in_finder()
  end
end, { silent = true, expr = true })


vim.keymap.set("n", "<C-b>", function()
  if not require("noice.lsp").scroll(-2) then return nil end
end, { silent = true, expr = true })
