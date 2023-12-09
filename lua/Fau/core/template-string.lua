-- =============================================
-- ========== Plugin Loading
-- =============================================
local template_string_ok, template_string = pcall(require, "template-string")
if not template_string_ok then Fau_vim.load_plugin_error("template-string") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  filetypes = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "python" },
  jsx_brackets = true,
  remove_template_string = true,
  restore_quotes = { normal = [["]], jsx = [["]] },
}


template_string.setup(config)
