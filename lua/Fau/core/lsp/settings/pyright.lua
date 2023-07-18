-- https://github.com/microsoft/pyright/blob/main/docs/settings.md
local util = require('lspconfig.util')


local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}


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

        typeCheckingMode = "off", -- values: off|basic|strict

        useLibraryCodeForTypes = true,
      }
    }
  },

  root_dir = function(fname)
    local root = util.root_pattern(unpack(root_files))(fname)
    if root and root ~= vim.env.HOME then return root end
    return util.find_git_ancestor(fname)
  end,
}
