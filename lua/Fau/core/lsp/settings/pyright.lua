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

        diagnosticMode = "workspace", -- values: workspace|openFilesOnly
        -- diagnosticSeverityOverrides = {},

        -- extraPaths = {},
        -- typeshedPaths = {},
        -- stubPath = "",

        -- logLevel = "Information",  -- values: Error|Warning|Information|Trace

        typeCheckingMode = "off", -- values: off|basic|strict

        -- useLibraryCodeForTypes = true,  -- Note: If false (default), not the default behavior. [Don't know why]
      }
    }
  }
}
