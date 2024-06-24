-- ==================== Smart Scroll ====================
vim.keymap.set("n", "<C-f>", function()
  if not require("noice.lsp").scroll(2) then
    return Fau_vim.functions.utils.reveal_in_system()
  end
end, { silent = true, expr = true, desc = "Scroll Down or Reveal File" })


vim.keymap.set("n", "<C-b>", function()
  if not require("noice.lsp").scroll(-2) then return nil end
end, { silent = true, expr = true, desc = "Scroll Up" })
