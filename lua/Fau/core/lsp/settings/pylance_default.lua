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

local pylance_settings = {
  -- pythonPath = "python3",
  analysis = {
    -- ---------- Path
    exclude = { "**/.*", "**/node_modules", "**/__pycache__", "Applications", "Desktop", "Documents", "Downloads", "Library", "Movies", "Music", "Pictures" },
    -- include = nil,
    -- ignore  = nil,
    -- extraPaths = nil,
    -- stubPath = "./typings",
    autoSearchPaths = true,

    -- ---------- Import
    addImport = { exactMatchOnly = true },
    showOnlyDirectDependenciesInAutoImport = false,
    -- packageIndexDepths = nil,
    importFormat = "absolute",  ---@type "absolute"|"relative"

    -- ---------- Completion
    autoImportCompletions = false,
    useLibraryCodeForTypes = true,
    persistAllIndices = true,
    indexing = true, userFileIndexingLimit = 2000,
    includeAliasesFromUserFiles = false, includeAliasFromUserFiles = false,
    regenerateStdLibIndices = false,
    completeFunctionParens = true,

    -- ---------- Docstring
    supportRestructuredText  = true,  -- Enable/disable support for reStructuredText in docstrings.
    supportDocstringTemplate = true,  -- Enable/disable support for docstring generation.

    -- ---------- Diagnostics
    diagnosticMode = "openFilesOnly",  ---@type "workspace"|"openFilesOnly"
    typeCheckingMode = "standard",  ---@type "off"|"basic"|"standard"|"strict"
    disableTaggedHints = false,  -- Disable hint diagnostics with special hints for grayed-out or strike-through text.
    -- diagnosticSeverityOverrides = nil,
    typeEvaluation = {
      strictListInference = true,
      strictDictionaryInference = true,
      strictSetInference = true,
      analyzeUnannotatedFunctions = true,
      strictParameterNoneValue = true,
      enableTypeIgnoreComments = true,
      deprecateTypingAliases = true,
      enableReachabilityAnalysis = true,
      enableExperimentalFeatures = false,
    },
    inlayHints= {
      callArgumentNames   = "partial",  ---@type "off"|"partial"|"all"
      functionReturnTypes = true,
      pytestParameters    = true,
      variableTypes       = true,
    },

    -- ---------- Formatting
    autoFormatStrings = true,  -- NOTE: doesn't work
    autoIndent = true,

    -- ---------- N/A
    -- fixAll = nil,
    -- nodeExecutable = nil,
    -- aiCodeActions = nil,
    -- enableNotebookDataTips = true,
    -- extraCommitChars = true,
    -- enableSyncServer = false,

    -- ---------- MISC
    languageServerMode = "default",  ---@type "light"|"default"|"full"
    enablePytestSupport = true,
    displayEnglishDiagnostics = true,
    generateWithTypeAnnotation = true,
    gotoDefinitionInStringLiteral = true,
    logLevel = "Information",  ---@type "Trace"|"Information"|"Warning"|"Error"
  },
}

return {
  default_config = {
    cmd = { "pylance", "--stdio" },
    filetypes = { "python" },
    root_dir = function(fname) return util.root_pattern(unpack(root_files))(fname) end,
    single_file_support = true,

    settings = {
      python = pylance_settings,
    },
  },
}
