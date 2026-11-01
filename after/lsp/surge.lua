---@type vim.lsp.Config
return {
  cmd = { "/Applications/Surge.app/Contents/Applications/surge-cli", "lsp", "--stdio" },
  filetypes = { "surge" },
  -- NOTE: The server parses by language ID: `surge-module` for a module, `surge` for a profile or a `.dconf` section.
  get_language_id = function(bufnr) return vim.endswith(vim.api.nvim_buf_get_name(bufnr), ".sgmodule") and "surge-module" or "surge" end,
}
