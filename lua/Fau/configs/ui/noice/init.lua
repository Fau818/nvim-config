-- =============================================
-- ========== Plugin Configurations
-- =============================================
local noice = require("noice")
local config = require("Fau.configs.ui.noice.config")
noice.setup(config)



-- =============================================
-- ========== Keymaps
-- =============================================
vim.keymap.set("n", "<C-f>", function()
  if not require("noice.lsp").scroll(2) then
    return Fau_vim.functions.utils.reveal_in_system()
  end
end, { silent = true, expr = true })


vim.keymap.set("n", "<C-b>", function()
  if not require("noice.lsp").scroll(-2) then return nil end
end, { silent = true, expr = true })
