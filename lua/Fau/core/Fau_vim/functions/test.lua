return {
  buf_remove = function(buf_id) MiniBufremove.delete(buf_id) end,

  toggle_indent_width = function()
    vim.bo.softtabstop = -1
    vim.bo.shiftwidth = 0

    local indent_type = vim.bo.expandtab and "space" or "tab"
    local indent_width = vim.bo.tabstop
    local new_width = indent_width == 2 and indent_type == "space" and 4 or 2

    if indent_type == "space" then
      vim.bo.expandtab = false
      vim.api.nvim_command("retab!")
    end

    vim.bo.tabstop = new_width
    vim.bo.expandtab = true
    vim.api.nvim_command("retab")
  end,

  is_large_file = function(buffer)
    buffer = buffer or vim.api.nvim_get_current_buf()
    local status_ok, file_status = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buffer))
    if not status_ok or not file_status then return end

    if file_status.size <= Fau_vim.large_file_size then return false end
    return true
  end,

}
