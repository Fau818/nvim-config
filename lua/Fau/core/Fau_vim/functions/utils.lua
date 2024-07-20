return {
  buf_remove = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- HACK: Special case for checkhealth buffer.
    -- NOTE: The `checkhealth` will open a new tab, but the `MiniBufremove.delete` function will not delete the tab.
    if vim.bo[bufnr].filetype == "checkhealth" then vim.api.nvim_command("bd " .. bufnr) return end

    local flag = pcall(require("mini.bufremove").delete, bufnr)
    if not flag then vim.api.nvim_command("bd " .. bufnr) end
  end,


  is_large_file = function(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()

    -- EXIT: Use the cached result.
    if vim.b[buffer].is_large_file ~= nil then return vim.b[buffer].is_large_file end

    -- Get file status.
    local status_ok, file_status = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))

    -- SPEC: Get the status of file error. => Not a large file
    if not status_ok or not file_status then vim.b[buffer].is_large_file = false
    else vim.b[buffer].is_large_file = file_status.size >= Fau_vim.file.large_file_size
    end

    return vim.b[buffer].is_large_file
  end,


  -- TODO: to a new class
  exist_path = function(path)
    local file_info = vim.loop.fs_stat(path)
    return file_info ~= nil
  end,


  reveal_in_system = function(path)
    if path == nil then path = vim.fn.expand('%') end
    return string.format("<CMD>silent !open -R '%s'<CR>", path)
  end,


  ---If there is no line crossing when selecting in Visual-Block mode, switch to Visual mode.
  ---This is useful to trim trailing line break when yanking some text in Visual-Block mode.
  smart_visual_mode = function()
    local mode = vim.fn.mode()

    if mode == "" then
      local start_row, end_row = vim.fn.getpos("v")[2], vim.fn.getpos(".")[2]
      -- vim.notify(string.format("mode: %s start_row: %d, end_row: %d", mode, start_row, end_row))

      if start_row == end_row then
        -- Switch to Visual mode
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("v", true, true, true), "x", false)
      end
    end
  end,


  set_colorscheme = function(colorscheme)
    -- Configuration
    colorscheme = colorscheme or Fau_vim.colorscheme
    pcall(require, "Fau.configs.colorscheme." .. colorscheme)
    -- Loading
    local status_ok, _ = pcall(vim.api.nvim_command, "colorscheme " .. colorscheme)
    if not status_ok then Fau_vim.notify("colorscheme [" .. colorscheme .. "] not found!", "error") return end
  end,
}
