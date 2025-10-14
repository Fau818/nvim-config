return {
  configured_ft = {},  ---@type table<string, boolean> Keep track of filetypes that have been configured
  packages      = {},  ---@type table<string, string[]> Auto installed LSP servers
}
