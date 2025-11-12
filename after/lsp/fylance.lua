-- SEE: https://github.com/microsoft/pylance-release/tree/main/docs/settings
local settings = {
  python = {
    -- pythonPath = "python3",  -- Set dynamically in before_init.
    analysis = {
      -- ==================== Path ====================
      -- exclude = { "**/.*", "**/node_modules", "**/__pycache__", "Applications", "Desktop", "Documents", "Downloads", "Library", "Movies", "Music", "Pictures" },
      -- include = nil,
      -- ignore  = nil,
      -- extraPaths = nil,
      -- stubPath = "./typings",
      autoSearchPaths = true,  -- Automatically add common search paths like src.


      -- ==================== Import ====================
      autoImportCompletions = true,
      showOnlyDirectDependenciesInAutoImport = false,
      -- packageIndexDepths = nil,
      importFormat = "absolute",  ---@type "absolute"|"relative"


      -- ==================== Completion ====================
      useLibraryCodeForTypes = true,
      persistAllIndices = true,  -- Indices for all third party libraries will be persisted to disk.
      indexing = true,
      userFileIndexingLimit = 2000,
      includeAliasesFromUserFiles = true,
      regenerateStdLibIndices = true,
      -- TEST: Set to true  Nov 11, 2025
      completeFunctionParens = true,  -- NOTE: If use `blink.cmp`, please set it to false.


      -- ==================== Diagnostics ====================
      diagnosticMode = "workspace",  ---@type "workspace"|"openFilesOnly"  -- TEST: Set to "workspace"  Nov 6, 2025
      typeCheckingMode = "standard",  ---@type "off"|"basic"|"standard"|"strict"
      disableTaggedHints = false,  -- Disable hint diagnostics with special hints for grayed-out or strike-through text.
      -- diagnosticSeverityOverrides = nil,
      typeEvaluation = {
        analyzeUnannotatedFunctions = true,
        deprecateTypingAliases = true,
        disableBytesTypePromotions = true,
        enableExperimentalFeatures = false,
        enableReachabilityAnalysis = true,
        enableTypeIgnoreComments = true,
        strictDictionaryInference = true,
        strictListInference = true,
        strictParameterNoneValue = true,
        strictSetInference = true,
      },
      inlayHints = {
        callArgumentNames   = "partial",  ---@type "off"|"partial"|"all"
        functionReturnTypes = true,
        pytestParameters    = true,
        variableTypes       = true,
      },


      -- ==================== Formatting ====================
      autoIndent = true,
      autoSplitStrings = true,   -- NOTE: doesn't work
      autoFormatStrings = true,  -- NOTE: doesn't work


      -- ==================== N/A ====================
      -- fixAll = nil,
      -- nodeExecutable = nil,
      -- aiCodeActions = nil,
      -- enableNotebookDataTips = true,
      -- extraCommitChars = true,
      -- enableSyncServer = false,
      -- enableColorPicker = true,


      -- ==================== MISC ====================
      languageServerMode = "default",  ---@type "light"|"default"|"full"
      enablePytestSupport = true,
      enableTroubleshootMissingImports = true,
      displayEnglishDiagnostics = true,
      generateWithTypeAnnotation = true,
      gotoDefinitionInStringLiteral = true,
      logLevel = "Information",  ---@type "Trace"|"Information"|"Warning"|"Error"


      -- ==================== Experimental ====================
      cacheLSPData = true,
      -- enableAsyncProgram = true,  -- NOTE: don't enable it.
      enablePrecomputeContext = true,

      -- ---------- Docstring
      supportRestructuredText  = true,  -- Enable/disable support for reStructuredText in docstrings.
      supportDocstringTemplate = true,  -- Enable/disable support for docstring generation.
    },
  },
}


---@type vim.lsp.Config
return {
  name = "fylance",
  cmd = { "fylance", "--stdio"  },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },

  -- before_init = function(_, config) config.settings.python.pythonPath = vim.fn.exepath("python3") end,

  settings = settings,
}
