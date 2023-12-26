return {
  settings = {
    Lua = {
      completion = {  -- Settings that adjust how autocompletions are provided while typing.
        enable = true,              -- Enable completion.

        autoRequire = false,        -- When the input looks like a file name, automatically require this file.

        callSnippet = "Disable",    -- Shows function call snippets. values: Disable|Both|Replace
        keywordSnippet = "Disable", -- Shows keyword syntax snippets. values: Disable|Both|Replace
        postfix = "@",              -- The symbol used to trigger the postfix suggestion.  [??? how to add]
        displayContext = 5,         -- Preview the line number of the relevant code snippet

        requireSeparator = '.',     -- The separator used when `require`.

        showParams = true,          -- Display parameters in completion list.

        showWord = "Fallback",      -- Show contextual words in suggestions. values: Enable|Fallback|Disable
        workspaceWord = false,      -- Whether the displayed context word contains the content of other files in the workspace.
      },



      diagnostics = {   -- Settings to adjust the diagnostics for Info, Warning, and Error ...
        enable = true,              -- Enable diagnostics.
        disableScheme = { "git" },  -- Do not diagnose Lua files that use the following scheme.
        disable = { "missing-fields", "inject-field" },
        globals = { "vim", "Fau_vim" },  -- Defined global variables.
        workspaceDelay = -1,  -- disable workspace diagnostics
      },



      format = {  -- Settings for configuring the built-in code formatter.
        enable = true,  -- Enable code formatter.

        defaultConfig = {
          -- -----------------------------------
          -- -------- Basic
          -- -----------------------------------
          max_line_length = "120",  -- if this is 'unset' then the line width is no longer checked

          indent_style = "tab",  -- it doesn't work in neovim
          indent_size = "2",     -- it doesn't work in neovim
          tab_width = "2",       -- it doesn't work in neovim
          continuation_indent_size = "4",

          detect_end_of_line = "false",
          end_of_line = "auto",  -- values: crlf|lf|cr|auto, if it is 'auto', in windows it is crlf other platforms are lf

          quote_style = "double",  -- values: none|single|double

          insert_final_newline = "true",


          -- -----------------------------------
          -- -------- Function
          -- -----------------------------------
          align_call_args = "true",  -- values: true|false
          align_function_define_params = "true",

          remove_expression_list_finish_comma = "true",

          call_arg_parentheses = "keep",  -- values: keep|remove|remove_table_only|remove_string_only|unambiguous_remove_string_only


          -- -----------------------------------
          -- -------- Table
          -- -----------------------------------
          table_separator_style = "comma",  -- values: none|comma|semicolon
          trailing_table_separator = "keep",  -- values: keep|never|always|smart
          continuous_assign_table_field_align_to_equal_sign = "true",
          keep_one_space_between_table_and_bracket = "true",
          align_table_field_to_first_field = "false",  -- if indent_style is tab, this option is invalid


          -- -----------------------------------
          -- -------- Statement
          -- -----------------------------------
          align_chained_expression_statement = "false",
          continuous_assign_statement_align_to_equal_sign = "true",
          if_condition_align_with_each_other = "false",
          local_assign_continuation_align_to_first_expression = "true",

          statement_inline_comment_space = "2",

          max_continuous_line_distance = "0",  -- This option indicates the definition of continuous lines, and its value determines the same continuous when the spacing between lines is less than or equal to how much.


          -- -----------------------------------
          -- -------- Indentation
          -- -----------------------------------
          label_no_indent = "false",
          do_statement_no_indent = "false",
          if_condition_no_continuation_indent = "true",
          if_branch_comments_after_block_no_indent = "true",


          -- -----------------------------------
          -- -------- Space
          -- -----------------------------------
          table_append_expression_no_space = "true",  -- like [a+b] not [a + b]


          long_chain_expression_allow_one_space_after_colon = "false",

          remove_empty_header_and_footer_lines_in_function = "true",

          space_before_function_open_parenthesis = "false",
          space_inside_function_call_parentheses = "false",
          space_inside_function_param_list_parentheses = "false",

          space_before_open_square_bracket = "false",
          space_inside_square_brackets = "false",

          keep_one_space_between_namedef_and_attribute = "false",


          -- -----------------------------------
          -- -------- row_layout
          -- -----------------------------------
          --[[
            The following configuration supports four expressions
              minLine:${n}
              keepLine
              keepLine:${n}
              maxLine:${n}
          --]]
          keep_line_after_if_statement = "minLine:0",
          keep_line_after_do_statement = "minLine:0",
          keep_line_after_while_statement = "minLine:0",
          keep_line_after_repeat_statement = "minLine:0",
          keep_line_after_for_statement = "minLine:0",
          keep_line_after_local_or_assign_statement = "minLine:0",
          keep_line_after_function_define_statement = "minLine:1",
          keep_line_after_expression_statement = "keepLine",


          -- -----------------------------------
          -- -------- Diagnostic
          -- -----------------------------------
          enable_check_codestyle = "false",
          enable_name_style_check = "false",
          -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/lua.template.editorconfig
        },
      },



      hint = {  -- Settings for configuring inline hints
        enable = true,  -- Enable inlay hint.
        arrayIndex = "Auto",  -- Show hints of array index when constructing a table. values: Enable|Disable|Auto

        paramName = "All",  -- Show hints of parameter name at the function call. values: All|Literal|Disable
        paramType = true,  -- Show type hints at the parameter of the function.

        await = true,  -- If the called function is marked ---@async, prompt await at the call.

        semicolon = "SameLine",  -- Whether to show a hint to add a semicolon to the end of a statement. values: All|SameLine|Disable

        setType = true,  -- Show a hint to display the type being applied at assignment operations.
      },



      workspace = {
        checkThirdParty = false,  -- Whether third party libraries can be automatically detected and applied.

        ignoreDir = { ".vscode", ".git" },
        ignoreSubmodules = true,  -- Whether git submodules should be ignored and not included in the workspace diagnosis.

        library = {  -- An array of abosolute or workspace-relative paths that will be added to the workspace diagnosis
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },

        useGitIgnore = true,  -- Whether files that are in .gitignore should be ignored by the language server when performing workspace diagnosis.
        -- userThirdParty = {},  -- An array of paths to custom third party libraries.
      },

    }
  }
}
