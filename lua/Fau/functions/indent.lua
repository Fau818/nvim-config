-- =============================================
-- ========== Functions: Indent
-- =============================================
return {
  ---@param force? boolean Whether to use guess-indent to detect indent.
  toggle_indent_width = function(force)
    vim.bo.softtabstop = -1
    vim.bo.shiftwidth = 0

    local indent_type = vim.bo.expandtab and "space" or "tab"
    local indent_width = vim.bo.tabstop
    local new_width = indent_width == 2 and 4 or 2

    if not force then
      -- Try to use guess-indent to detect current indent
      local guess_indent_ok, _ = pcall(require, "guess-indent")
      if guess_indent_ok then
        vim.api.nvim_command("GuessIndent")
        -- If indent was changed, then do nothing
        local cur_indent_type = vim.bo.expandtab and "space" or "tab"
        if vim.bo.tabstop ~= indent_width or cur_indent_type ~= indent_type then return end
      end
    end

    if indent_type == "space" then
      -- Convert to tab firstly
      vim.bo.expandtab = false
      vim.api.nvim_command("retab!")
      -- Set to new indent width
      vim.bo.tabstop = new_width
      -- Restore to space secondly
      vim.bo.expandtab = true
      vim.api.nvim_command("retab")
    else
      vim.bo.tabstop = new_width
    end

  end,


  -- -----------------------------------
  -- -------- TODO......
  -- -----------------------------------
  ---use specific indent setting for a filetype
  ---@param indent_type "tab"|"space"
  ---@param indent_width 2|4|8
  __use_indent = function(indent_type, indent_width)
    local for_tab = indent_type == "tab" and " noexpandtab" or " expandtab"
    local command = "setlocal tabstop=" .. indent_width .. for_tab

    vim.api.nvim_command(command)
  end,


  ---@return Fau_vim_file_indent
  __get_indent = function()
    local filetype = vim.bo.filetype

    if Fau_vim.file_indent[filetype] == nil then -- use default indent
      Fau_vim.file_indent[filetype] = {
        indent_type  = Fau_vim.file_indent.default.indent_type,
        indent_width = Fau_vim.file_indent.default.indent_width
      }
    end

    return Fau_vim.file_indent[filetype]
  end,


  set_indent = function()
    local file_indent = Fau_vim.functions.indent.__get_indent()
    Fau_vim.functions.indent.__use_indent(file_indent.indent_type, file_indent.indent_width)
  end,


  ---Cycle indent
  cycle_indent = function()
    local filetype    = vim.bo.filetype
    local file_indent = Fau_vim.functions.indent.__get_indent()
    local default     = Fau_vim.file_indent.default

    if file_indent.indent_type == "tab" then
      -- switch indent_type to space
      Fau_vim.file_indent[filetype].indent_type  = "space"
      Fau_vim.file_indent[filetype].indent_width = default.indent_width == 2 and 2 or 4
    else
      if file_indent.indent_width == default.indent_width then
        Fau_vim.file_indent[filetype].indent_width = default.indent_width == 2 and 4 or 2
      else
        Fau_vim.file_indent[filetype].indent_type  = "tab"
        Fau_vim.file_indent[filetype].indent_width = default.indent_width == 2 and 2 or 4
      end
    end

    -- if file_indent.indent_width == default.indent_width then
    --   -- Switch to another indent_width
    --   Fau_vim.file_indent[filetype].indent_width = default.indent_width == 2 and 4 or 2
    -- else
    --   -- Switch to another indent_type
    --   Fau_vim.file_indent[filetype].indent_type  = file_indent.indent_type == "space" and "tab" or "space"
    --   Fau_vim.file_indent[filetype].indent_width = default.indent_width == 2 and 2 or 4
    -- end

    -- TODO: cycle indent auto convert indent_type and indent_width
    -- TIPS: This need to ensure original indent is correct.

    -- TODO: future: popup a menu to select indent options.

    Fau_vim.functions.indent.set_indent()
    vim.api.nvim_command("retab!")
  end
}
