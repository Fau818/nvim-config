local M = {}

-- ==================== Trim Blank Lines and Spaces ====================
M._trim_text_source = "default"


function M.__trim_text()
  local save_cursor = vim.fn.getpos(".")
  vim.api.nvim_command([[silent! %s#\($\n\s*\)\+\%$##]])
  vim.api.nvim_command([[silent! %s/\s\+$//e]])
  vim.fn.setpos(".", save_cursor)
end

M.trim_text = function()
  if M._trim_text_source == "default" then M.__trim_text()
  elseif M._trim_text_source == "mini" then
    local trailspace = require("mini.trailspace")
    trailspace.trim_last_lines(); trailspace.trim()
  else
    fvim.notify(("Unknown trim text source: %s. Back to default."):format(M._trim_text_source), vim.log.levels.WARN)
    M.__trim_text()
  end
end


-- ==================== Smart Format ====================
-- DESC: Smart indent a file or range.
function M.auto_indent()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    fvim.utils.feedkeys("x", "=")
  else  -- indent all buffer
    local save_cursor = vim.fn.getpos(".")
    vim.api.nvim_command("normal! gg=G")
    vim.fn.setpos(".", save_cursor)
  end
  M.trim_text()
  vim.api.nvim_command("nohlsearch")
  fvim.notify("not found formatter, use auto indent!", vim.log.levels.INFO, { render = "minimal" })
end


-- DESC: Smart format (if no lsp formatter: use auto_indent)
function M.smart_format()
  local filetype = vim.bo.filetype

  -- NOTE: Special treamtment for some filetypes.
  -- if filetype == "python" then return M.auto_indent()  -- TEST: Use ruff for python formatting. Nov 7, 2025.
  if filetype == "c" or filetype == "cpp" then return M.auto_indent() end

  -- By lsp capability
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  clients = vim.tbl_filter(function(client) return client.supports_method("textDocument/formatting") end, clients)
  if #clients == 0 then return M.auto_indent()
  else return vim.lsp.buf.format()
  end
end


return M
