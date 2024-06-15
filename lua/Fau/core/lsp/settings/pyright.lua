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

        -- extraPaths = {},
        -- typeshedPaths = {},
        stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs/stubs",

        ---@type "off"|"basic"|"strict"
        typeCheckingMode = "off",

        useLibraryCodeForTypes = true,
      }
    }
  },
}
