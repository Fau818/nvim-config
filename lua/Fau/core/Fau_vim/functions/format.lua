-- =============================================
-- ========== Functions: Format
-- =============================================
return {
  -- -----------------------------------
  -- -------- Trim Blank Lines and Spaces
  -- -----------------------------------
  -- NOTE: `mini.trailspace` will overwrite this function.
  remove_blank_lines_and_spaces = function()
    local save_cursor = vim.fn.getpos(".")
    vim.api.nvim_command([[silent! %s#\($\n\s*\)\+\%$##]])
    vim.api.nvim_command([[silent! %s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,


  -- -----------------------------------
  -- -------- Smart Format
  -- -----------------------------------
  -- Smart indent a file or range.
  __auto_indent = function()
    local mode = vim.api.nvim_get_mode()["mode"]
    if mode == "v" or mode == "V" then -- indent selected
      vim.api.nvim_input("gv=")
    else -- indent all buffer
      local save_cursor = vim.fn.getpos(".")
      vim.api.nvim_command("normal! gg=G")
      vim.fn.setpos(".", save_cursor)
    end
    Fau_vim.functions.format.remove_blank_lines_and_spaces()
    vim.api.nvim_command("nohlsearch")
    Fau_vim.notify("not found formatter, use auto indent!", vim.log.levels.INFO, { render = "minimal" })
  end,

  -- Smart format (if no lsp formatter: use auto_indent)
  smart_format = function()
    local filetype = vim.bo.filetype

    -- SPEC: Special treamtment for some filetypes.
    if filetype == "python" then return Fau_vim.functions.format.__auto_indent()
    elseif filetype == "c" or filetype == "cpp" then return Fau_vim.functions.format.__auto_indent()
    end

    -- By lsp capability
    local clients = vim.lsp.get_clients({ bufnr=0 })
    clients = vim.tbl_filter(function(client) return client.supports_method("textDocument/formatting") end, clients)
    if #clients == 0 then return Fau_vim.functions.format.__auto_indent()
    else return vim.lsp.buf.format()
    end
  end,
}
