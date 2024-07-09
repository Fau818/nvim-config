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
    cmd = { "delance-langserver", "--stdio" },
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

          completeFunctionParens = true,

          diagnosticMode = "openFilesOnly",  ---@type "workspace"|"openFilesOnly"

          enablePytestExtra   = false,
          enablePytestSupport = true,
          enableSyncServer    = false,
          extraCommitChars    = true,

          gotoDefinitionInStringLiteral = true,

          importFormat = "absolute",  ---@type "absolute"|"relative"
          indexing = true,

          inlayHints= {
            callArgumentNames   = "partial",
            functionReturnTypes = true,
            pytestParameters    = true,
            variableTypes       = true,
          },

          logLevel = "Information",  ---@type "Trace"|"Information"|"Warning"|"Error"

          persistAllIndices = true,

          stubPath = "typings",

          typeCheckingMode = "off",  ---@type "off"|"basic"|"strict"

          useLibraryCodeForTypes = true,
          userFileIndexingLimit = 2000,
        },
      },
    },
  },
}
