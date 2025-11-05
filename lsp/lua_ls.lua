-- SEE: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
local format_config = {
  -- ==================== Basic ====================
  max_line_length                 = "120",
  auto_collapse_lines             = "false",
  break_all_list_when_line_exceed = "false",
  break_before_braces             = "false",

  indent_style        = "space",  -- it doesn't work in neovim
  indent_size         = "2",      -- it doesn't work in neovim
  tab_width           = "2",      -- it doesn't work in neovim
  continuation_indent = "4",

  space_before_inline_comment     = "2",
  align_continuous_inline_comment = "true",

  ---@type "crlf"|"lf"|"cr"|"auto"
  end_of_line          = "auto",
  detect_end_of_line   = "false",
  insert_final_newline = "true",

  ---@type "none"|"single"|"double"
  quote_style = "double",


  -- ==================== Function ====================
  align_call_args       = "true",
  align_function_params = "true",

  ---@type "keep"|"remove"|"remove_table_only"|"remove_string_only"|"unambiguous_remove_string_only"
  call_arg_parentheses  = "keep",

  space_before_function_open_parenthesis       = "false",
  space_before_closure_open_parenthesis        = "false",
  space_before_function_call_open_parenthesis  = "false",
  space_before_function_call_single_arg        = "false",
  space_inside_function_call_parentheses       = "false",
  space_inside_function_param_list_parentheses = "false",

  ignore_spaces_inside_function_call = "true",


  -- ==================== Table ====================
  align_array_table                  = "true",
  align_continuous_rect_table_field  = "true",
  align_continuous_similar_call_args = "true",

  ---@type "none"|"comma"|"semicolon"|"only_kv_colon"
  table_separator_style    = "comma",
  ---@type "keep"|"never"|"always"|"smart"
  trailing_table_separator = "smart",

  space_around_table_field_list      = "true",
  space_around_table_append_operator = "true",


  -- ==================== Statement ====================
  align_continuous_assign_statement = "true",

  space_before_attribute = "true",
  space_after_comma      = "true",

  space_after_comma_in_for_statement = "true",


  -- ==================== Conditional ====================
  align_if_branch = "false",

  never_indent_before_if_condition  = "false",
  never_indent_comment_on_if_branch = "false",


  -- ==================== Space ====================
  space_before_open_square_bracket = "false",
  space_inside_square_brackets     = "false",

  space_around_math_operator    = "true",
  space_around_concat_operator  = "true",
  space_around_logical_operator = "true",
  space_around_assign_operator  = "true",


  -- ==================== Line Space ====================
  ---@type "keep"|"fixed(n)"|"min(n)"|"max(n)"
  line_space_after_if_statement              = "keep",
  line_space_after_do_statement              = "keep",
  line_space_after_while_statement           = "keep",
  line_space_after_repeat_statement          = "keep",
  line_space_after_for_statement             = "keep",
  line_space_after_local_or_assign_statement = "keep",
  line_space_after_function_statement        = "min(2)",
  line_space_after_expression_statement      = "keep",
  line_space_after_comment                   = "keep",
  line_space_around_block                    = "keep",

  ---@type "keep"|"always"|"same_line"|"replace_with_newline"|"never"
  ignore_space_after_colon                 = "same_line",
  remove_call_expression_list_finish_comma = "same_line",
  end_statement_with_semicolon             = "same_line",


  -- ==================== Unknown ====================
  align_chain_expr = "none",
  align_continuous_line_space = "1",
  keep_indents_on_empty_lines = "false",
}


return {
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

        -- globals = { "vim", "fvim" },              -- Defined global variables.
        -- unusedLocalExclude = {},   -- Define variable names that will not be reported as an unused local by unused-local.

        -- groupFileStatus = nil,     -- Use default
        -- groupSeverity = nil,       -- Use default
        -- neededFileStatus = nil,    -- Use default
        -- severity = nil,            -- use default

        ---@type "Enable"|"Opened"|"Disable"
        ignoredFiles = "Opened",  -- Set how files that have been ignored should be diagnosed.
        ---@type "Enable"|"Opened"|"Disable"
        libraryFiles = "Opened",  -- Set how files loaded with workspace.library are diagnosed.

        -- workspaceDelay = -1,  -- NOTE: Keep it enabled, otherwise `lazydev.nvim` will not work properly (no diagnostics auto refresh).
        ---@type "OnChange"|"OnSave"|"Disable"
        workspaceEvent = "OnSave",  -- Set when the workspace diagnostics should be analyzed.
        workspaceRate  = 100,       -- Define the rate at which the workspace will be diagnosed as a percentage.
      },

      -- doc = {},

      format = {        -- Settings for configuring the built-in code formatter.
        enable = true,  -- Enable code formatter.
        defaultConfig = format_config,
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
