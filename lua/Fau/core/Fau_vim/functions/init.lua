-- =============================================
-- ========== Functions
-- =============================================
require("Fau.core.Fau_vim.functions.notify")

return {
  format = require("Fau.core.Fau_vim.functions.format"),
  indent = require("Fau.core.Fau_vim.functions.indent"),
  lsp    = require("Fau.core.Fau_vim.functions.lsp"),
  utils  = require("Fau.core.Fau_vim.functions.utils"),
  test   = require("Fau.core.Fau_vim.functions.test"),
}
