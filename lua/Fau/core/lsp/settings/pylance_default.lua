local util = require("lspconfig.util")

local root_files = {
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
}

return {
  default_config = {
    cmd = { "pylance", "--stdio" },
    filetypes = { "python" },
    root_dir = function(fname)
      local root = util.root_pattern(unpack(root_files))(fname)
      if root and root ~= vim.env.HOME then return root end
      return util.find_git_ancestor(fname)
    end,
    single_file_support = true,

    settings = {
      python = {
        -- pythonPath = "python3",
        analysis = {
          addImport = { exactMatchOnly = true },

          autoFormatStrings     = true,
          autoImportCompletions = true,
          autoSearchPaths       = true,

          completeFunctionParens = false,

          ---@type "workspace"|"openFilesOnly"
          diagnosticMode = "openFilesOnly",

          enablePytestExtra   = false,
          enablePytestSupport = true,
          enableSyncServer    = false,
          extraCommitChars    = true,

          gotoDefinitionInStringLiteral = true,

          ---@type "absolute"|"relative"
          importFormat = "absolute",
          indexing = true,

          inlayHints= {
            callArgumentNames   = "partial",
            functionReturnTypes = true,
            pytestParameters    = true,
            variableTypes       = true,
          },

          ---@type "Trace"|"Information"|"Warning"|"Error"
          logLevel = "Information",

          persistAllIndices = true,

          stubPath = "typings",

          ---@type "off"|"basic"|"strict"
          typeCheckingMode = "off",

          useLibraryCodeForTypes = true,
          userFileIndexingLimit = 2000,
        },
      },
    },
  },
}
