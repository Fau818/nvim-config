---@type vim.lsp.Config
return {
  cmd_env = { TOMBI_SCHEMA_TRUSTED_HOSTS = "www.schemastore.org" },
  on_attach = function(client, bufnr) client.server_capabilities.documentFormattingProvider = false end,
}
