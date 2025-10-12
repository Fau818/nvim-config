return {
  ---Simulate pressing `keys` in `mode` mode.
  ---@param mode string
  ---@param keys string
  feedkeys = function(mode, keys)
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(keys, true, true, true),
      mode,
      false
    )
  end,


  ---Delete the specified buffer.
  ---@param bufnr integer Default is the current buffer.
  buf_remove = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- HACK: Special case for checkhealth buffer.
    -- NOTE: The `checkhealth` will open a new tab, but the `MiniBufremove.delete` function will not delete the tab.
    if vim.bo[bufnr].filetype == "checkhealth" then vim.api.nvim_command("bd " .. bufnr) return end

    -- BUG: Snacks.bufdelete delete function cannot delete the buffer in some cases. [Maybe Caused by the `satellite.nvim` plugin]
    -- local flag = pcall(require("mini.bufremove").delete, bufnr, true)
    local flag = pcall(Snacks.bufdelete.delete, bufnr)
    if not flag then vim.api.nvim_command("bd " .. bufnr) end
  end,


  ---Determine if the specified buffer is a large file.
  ---@param bufnr? integer Default is the current buffer.
  ---@return boolean flag True if the buffer is a large file, otherwise false.
  is_large_file = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()

    -- EXIT: Not a regular buffer.
    if vim.bo[bufnr].buftype ~= "" then return false end
    -- EXIT: `bigfile` filetype always a large file.
    if vim.bo[bufnr].filetype == "bigfile" then return true end
    -- EXIT: Use the cached result.
    if vim.b[bufnr].is_large_file ~= nil then return vim.b[bufnr].is_large_file end

    -- Get file status.
    local status_ok, file_status = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))

    -- HACK: Get the status of file error. => Not a large file
    if not status_ok or not file_status then vim.b[bufnr].is_large_file = false
    else vim.b[bufnr].is_large_file = file_status.size >= Fau_vim.file.large_file_size
    end

    return vim.b[bufnr].is_large_file
  end,


  -- TODO: to a new class
  exist_path = function(path)
    local file_info = vim.uv.fs_stat(path)
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

      if start_row == end_row then Fau_vim.functions.utils.feedkeys("x", "v") end
    end
  end,


  set_colorscheme = ...,  -- SEE: lua/Fau/plugins/editor/colorscheme/init.lua
}
