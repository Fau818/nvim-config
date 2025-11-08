---@type vim.lsp.Config
return {
  settings = {
    python = { pythonPath = nil, venvPath = nil },
    basedpyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
      disableTaggedHints = false,

      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,

        diagnosticMode = "workspace",  ---@type "openFilesOnly" | "workspace"

        logLevel = "Information",  ---@type "Error" | "Warning" | "Information" | "Trace"

        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          callArgumentNamesMatching = false,
          genericTypes = true,
        },

        useTypingExtensions = true,  -- TEST: Default is false, try it! On Nov 7, 2025
        -- fileEnumerationTimeout = nil,  -- Use default.

        autoFormatStrings = true,  -- NOTE: Neovim doesn't support it yet. Planned for 0.12.

        configFilePath = string.format("%s/configuration/pyproject.toml", fvim.nvim_config_path),
      },
    },
  },
}
