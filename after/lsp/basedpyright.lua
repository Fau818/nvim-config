---@type vim.lsp.Config
return {
  -- NOTE: LSP settings may be ignored. (More info in the link below.)
  -- SEE: https://docs.basedpyright.com/v1.36.1/configuration/config-files/#overriding-language-server-settings
  settings = {
    python = { pythonPath = nil, venvPath = nil },
    basedpyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
      disableTaggedHints = false,

      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,

        diagnosticMode = "openFilesOnly",  ---@type "openFilesOnly" | "workspace"
        logLevel = "Information",  ---@type "Error" | "Warning" | "Information" | "Trace"

        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          callArgumentNamesMatching = false,
          genericTypes = true,
        },

        useTypingExtensions = false,
        -- fileEnumerationTimeout = nil,  -- Use default.
        autoFormatStrings = true,  -- NOTE: Neovim doesn't support it yet. Planned for 0.12.

        -- configFilePath = nil,  -- Use default.

        -- ==================== pyproject.toml ====================
        exclude = { "**/.git", "**/.idea", "**/.vscode", "**/.cache", "**/.venv", "**/__pycache__", "**/.mypy_cache", "**/node_modules" },
        -- extraPaths = nil,  -- Use default.
        -- stubPath = nil,  -- Use default.
        -- typeshedPaths = nil,  -- Use default.
        -- baselineFile = nil,  -- Use default.

        useLibraryCodeForTypes = true,

        typeCheckingMode = "recommended",  ---@type "off"|"basic"|"standard"|"strict"|"recommended"|"all"

        ---@type table<string, "error"|"warning"|"information"|"hint"|"none"|boolean>
        diagnosticSeverityOverrides = {
          reportUnusedCallResult = "none",
          reportUnusedParameter  = "hint",
          reportUnusedVariable   = "hint",
          reportUnreachable      = "information",
          reportMissingTypeStubs = "hint",
        }
      },
    },
  },
}
