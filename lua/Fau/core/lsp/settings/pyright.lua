-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
return {
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,

        ---@type "workspace"|"openFilesOnly"
        diagnosticMode = "openFilesOnly",
        -- diagnosticSeverityOverrides = {},

        -- extraPaths = {},
        -- typeshedPaths = {},
        stubPath = "typings",

        -- logLevel = "Information",  -- values: Error|Warning|Information|Trace

        typeCheckingMode = "off", -- values: off|basic|strict

        useLibraryCodeForTypes = true,
      }
    }
  }
}
