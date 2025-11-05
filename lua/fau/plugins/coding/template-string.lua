---@type LazySpec
return {
  -- DESC: Auto convert normal string to template string.
  ---@module "template-string.nvim"
  "axelvc/template-string.nvim",
  ft = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "svelte", "python", "cs" },

  opts = {
    filetypes = nil,  -- Use default filetypes.
    jsx_brackets = true,
    remove_template_string = true,
    restore_quotes = { normal = [["]], jsx = [["]] },
  },
}
