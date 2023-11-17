return {
  buf_remove = function(buf_id) MiniBufremove.delete(buf_id) end,


  is_large_file = function(buffer)
    -- TODO: large buffers can be cached in a table to avoid duplicated invoking.
    buffer = buffer or vim.api.nvim_get_current_buf()
    local status_ok, file_status = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))
    if not status_ok or not file_status then return end

    if file_status.size < Fau_vim.large_file_size then return false end
    return true
  end,


  -- TODO: to a new class
  exist_path = function(path)
    local file_info = vim.loop.fs_stat(path)
    return file_info ~= nil
  end,

  reveal_in_finder = function(path)
    if path == nil then path = vim.fn.expand('%') end
    return string.format("<CMD>!open -R '%s'<CR>", path)
  end,
}
