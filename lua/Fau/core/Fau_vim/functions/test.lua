return {
  ---@param force boolean Whether to use guess-indent to detect indent.
  toggle_indent_width = function(force)
    vim.bo.softtabstop = -1
    vim.bo.shiftwidth = 0

    local indent_type = vim.bo.expandtab and "space" or "tab"
    local indent_width = vim.bo.tabstop
    local new_width = indent_width == 2 and indent_type == "space" and 4 or 2

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
      vim.bo.expandtab = false
      vim.api.nvim_command("retab!")
    end

    vim.bo.tabstop = new_width
    vim.bo.expandtab = true
    vim.api.nvim_command("retab")
  end,


}
