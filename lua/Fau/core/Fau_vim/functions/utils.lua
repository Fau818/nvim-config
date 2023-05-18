return {
  buf_remove = function(buf_id) MiniBufremove.delete(buf_id) end,


  is_large_file = function(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()
    local status_ok, file_status = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))
    if not status_ok or not file_status then return end

    if file_status.size <= Fau_vim.large_file_size then return false end
    return true
  end,
}
