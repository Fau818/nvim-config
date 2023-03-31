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
        diagnosticMode = "workspace",
        -- diagnosticSeverityOverrides = {},

        -- extraPaths = { "/usr/local/lib/python3.10/site-packages/" },
        -- typeshedPaths = { "/usr/local/lib/python3.10/site-packages/" },
        stubPath = "/usr/local/lib/python3.10/site-packages/typings",

        -- logLevel = "Information",  -- values: Error|Warning|Information|Trace

        typeCheckingMode = "off", -- values: off|basic|strict

        useLibraryCodeForTypes = true,
      }
    }
  }
}
