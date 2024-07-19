local util = require("lspconfig.util")

local root_files = {
  ".luarc.json",
  ".luarc.jsonc",
  ".luacheckrc",
  ".stylua.toml",
  "stylua.toml",
  "selene.toml",
  "selene.yml",
  ".gitignore",
}

return {
  root_dir = function(fname)
    local root = util.root_pattern(unpack(root_files))(fname)
    if root and root ~= vim.env.HOME then return root end
    return util.find_git_ancestor(fname)
  end,

  -- SEE: https://luals.github.io/wiki/settings
  settings = {
    Lua = {
      addonManager = { enable = true },

      completion = {    -- Settings that adjust how autocompletions are provided while typing.
        enable = true,  -- Enable completion.

        autoRequire = false,     -- When the input looks like a file name, automatically require this file.
        requireSeparator = ".",  -- The separator used when `require`.

        ---@type "Disable"|"Both"|"Replace"
        callSnippet = "Disable",  -- Shows function call snippets.
        ---@type "Disable"|"Both"|"Replace"
        keywordSnippet = "Disable",  -- Shows keyword syntax snippets.
        displayContext = 5,          -- Preview the line number of the relevant code snippet
        postfix = "@",               -- The symbol used to trigger the postfix suggestion.  [??? how to add]
        showParams = true,           -- Display parameters in completion list.

        ---@type "Enable"|"Fallback"|"Disable"
        showWord = "Fallback",  -- Show contextual words in suggestions.
        workspaceWord = true,   -- Whether the displayed context word contains the content of other files in the workspace.
      },

      diagnostics = {   -- Settings to adjust the diagnostics for Info, Warning, and Error ...
        enable = true,  -- Enable diagnostics.
        disable = { "missing-fields", "inject-field" },
        disableScheme = { "git" },  -- Do not diagnose Lua files that use the following scheme.

        -- globals = {},              -- Defined global variables.
        -- unusedLocalExclude = {},   -- Define variable names that will not be reported as an unused local by unused-local.

        -- groupFileStatus = nil,     -- Use default
        -- groupSeverity = nil,       -- Use default
        -- neededFileStatus = nil,    -- Use default
        -- severity = nil,            -- use default

        ---@type "Enable"|"Opened"|"Disable"
        ignoredFiles = "Opened",  -- Set how files that have been ignored should be diagnosed.
        ---@type "Enable"|"Opened"|"Disable"
        libraryFiles = "Opened",  -- Set how files loaded with workspace.library are diagnosed.

        workspaceDelay = -1,  -- Disable workspace diagnostics
        ---@type "OnChange"|"OnSave"|"Disable"
        workspaceEvent = "OnSave",  -- Set when the workspace diagnostics should be analyzed.
        workspaceRate  = 100,       -- Define the rate at which the workspace will be diagnosed as a percentage.
      },

      -- doc = {},

      format = {        -- Settings for configuring the built-in code formatter.
        enable = true,  -- Enable code formatter.
        defaultConfig = require("Fau.core.lsp.settings.lua_ls.format_config"),
      },

      hint = {              -- Settings for configuring inline hints
        enable     = true,  -- Enable inlay hint.
        await      = true,  -- If the called function is marked ---@async, prompt await at the call.
        ---@type "Enable"|"Disable"|"Auto"
        arrayIndex = "Auto",  -- Show hints of array index when constructing a table.
        ---@type "All"|"Literal"|"Disable"
        paramName  = "All",  -- Show hints of parameter name at the function call.
        paramType  = true,   -- Show type hints at the parameter of the function.
        ---@type "All"|"SameLine"|"Disable"
        semicolon  = "SameLine",  -- Whether to show a hint to add a semicolon to the end of a statement.
        setType    = true,        -- Show a hint to display the type being applied at assignment operations.
      },

      hover = {
        enable        = true,
        enumsLimit    = 5,     -- A value has multiple possible types, limit the number of types displayed.
        expandAlias   = true,  -- When hovering a value with an @alias for its type, should the alias be expanded into its values.
        previewFields = 50,    -- When a table is hovered, its fields will be displayed in the tooltip. This setting limits how many fields can be seen in the tooltip.
        viewNumber    = true,  -- Enable hovering a non-decimal value to see its numeric value.
        viewString    = true,  -- Enable hovering a string that contains an escape character to see its true string value.
        viewStringMax = 1000,  -- The maximum number of characters that can be previewed by hovering a string before it is truncated.
      },

      -- misc = {},
      runtime = { version = "LuaJIT" },

      semantic = {
        enable     = true,   -- Whether semantic colouring should be enabled.
        annotation = true,   -- Whether semantic colouring should be enabled for type annotations.
        keyword    = false,  -- You should only need to enable this setting if your editor is unable to highlight Lua's syntax.
        variable   = true,   -- Whether the server should provide semantic colouring of variables, fields, and parameters.
      },

      signatureHelp = { enbable = true },

      -- spell = {},

      type = {
        castNumberToInteger = false,  -- Whether casting a number to an integer is allowed.
        weakNilCheck        = false,  -- Whether it is permitted to assign a union type that contains nil to a variable that does not permit it.
        weakUnionCheck      = false,  -- Whether it is permitted to assign a union type which only has one matching type to a variable.
      },

      -- window = {},  -- For VSCode

      workspace = {
        checkThirdParty = "Disable",  -- Whether third party libraries can be automatically detected and applied.
        ignoreDir = { ".vscode", ".git" },
        ignoreSubmodules = true,  -- Whether git submodules should be ignored and not included in the workspace diagnosis.
        -- library = {},
        maxPreload = 5000,    -- The maximum amount of files that can be diagnosed. More files will require more RAM.
        useGitIgnore = true,  -- Whether files that are in .gitignore should be ignored by the language server when performing workspace diagnosis.
        -- userThirdParty = {},  -- An array of paths to custom third party libraries.
      },

    },
  },
}
