-- SEE: https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
return {
  -- -----------------------------------
  -- -------- Basic
  -- -----------------------------------
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

  end_of_line          = "auto",  -- values: crlf|lf|cr|auto
  detect_end_of_line   = "false",
  insert_final_newline = "true",

  quote_style = "double",  -- values: none|single|double


  -- -----------------------------------
  -- -------- Function
  -- -----------------------------------
  align_call_args       = "true",
  align_function_params = "true",

  call_arg_parentheses  = "keep",  -- values: keep|remove|remove_table_only|remove_string_only|unambiguous_remove_string_only

  space_before_function_open_parenthesis       = "false",
  space_before_closure_open_parenthesis        = "false",
  space_before_function_call_open_parenthesis  = "false",
  space_before_function_call_single_arg        = "false",
  space_inside_function_call_parentheses       = "false",
  space_inside_function_param_list_parentheses = "false",

  ignore_spaces_inside_function_call = "true",


  -- -----------------------------------
  -- -------- Table
  -- -----------------------------------
  align_array_table                  = "true",
  align_continuous_rect_table_field  = "true",
  align_continuous_similar_call_args = "true",

  table_separator_style    = "comma",  -- values: none|comma|semicolon|only_kv_colon
  trailing_table_separator = "smart",  -- values: keep|never|always|smart

  space_around_table_field_list      = "true",
  space_around_table_append_operator = "true",


  -- -----------------------------------
  -- -------- Statement
  -- -----------------------------------
  align_continuous_assign_statement = "true",

  space_before_attribute = "true",
  space_after_comma      = "true",

  space_after_comma_in_for_statement = "true",


  -- -----------------------------------
  -- -------- If Condition
  -- -----------------------------------
  align_if_branch = "false",

  never_indent_before_if_condition  = "false",
  never_indent_comment_on_if_branch = "false",


  -- -----------------------------------
  -- -------- Space
  -- -----------------------------------
  space_before_open_square_bracket = "false",
  space_inside_square_brackets     = "false",

  space_around_math_operator    = "true",
  space_around_concat_operator  = "true",
  space_around_logical_operator = "true",
  space_around_assign_operator  = "true",


  -- -----------------------------------
  -- -------- Line Space
  -- -----------------------------------
  -- values: keep|fixed(n)|min(n)|max(n)
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

  -- values: keep|always|same_line|replace_with_newline|never?
  ignore_space_after_colon                 = "same_line",
  remove_call_expression_list_finish_comma = "same_line",
  end_statement_with_semicolon             = "same_line",


  -- -----------------------------------
  -- -------- Unknown
  -- -----------------------------------
  align_chain_expr = "none",
  align_continuous_line_space = "1",
  keep_indents_on_empty_lines = "false",

}
