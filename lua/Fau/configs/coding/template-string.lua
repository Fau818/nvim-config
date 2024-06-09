-- =============================================
-- ========== Plugin Configurations
-- =============================================
local template_string = require("template-string")

local config = {
  filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
  jsx_brackets = true,
  remove_template_string = true,
  restore_quotes = { normal = [["]], jsx = [["]] },
}

template_string.setup(config)
