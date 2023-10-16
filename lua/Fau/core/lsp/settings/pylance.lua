local util = require("lspconfig.util")


local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
}


return {
  default_config = {
    cmd = { "pylance", "--stdio" },
    filetypes = { "python" },
    root_dir = function(fname) return util.root_pattern(unpack(root_files))(fname) end,
    single_file_support = true,

    settings = {
      python = {
        analysis = {
          autoFormatStrings = true,

          autoSearchPaths = true,

          completeFunctionParens = false,

          autoImportCompletions = true,
          exactMatchOnly        = true,
          importFormat          = "absolute",  -- values: absolute | relative

          diagnosticMode = "openFilesOnly",  -- values: workspace | openFilesOnly

          enablePytestExtra = false,
          enablePytestSupport = true,

          gotoDefinitionInStringLiteral = true,

          indexing = true,

          inlayHints= {
            callArgumentNames   = true,
            functionReturnTypes = true,
            pytestParameters    = true,
            variableTypes       = true,
          },

          logLevel = "Information",  -- values: Trace | Information | Warning | Error

          persistAllIndices = true,

          stubPath = "typings",

          typeCheckingMode = "off",  -- values: off | basic | strict

          useLibraryCodeForTypes = true,
          userFileIndexingLimit = 2000,
        },
      },
    },
  },
}
