local M = {}


---Smart show diagnostic message.
---@param diagnostic vim.Diagnostic
function M.smart_format(diagnostic)
  local source, message, code = diagnostic.source, diagnostic.message, diagnostic.code
  if source and code then
    return ("%s: %s [%s]"):format(source, message, code)
  elseif source and not code then
    return ("%s: %s"):format(source, message)
  elseif not source and code then
    return ("%s [%s]"):format(message, code)
  else  -- not source and code
    return message
  end
end


---Virtual text options, kept outside `setup` so the toggle can restore them.
---@type vim.diagnostic.Opts.VirtualText
M.virtual_text_opts = {
  severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.WARN },
  current_line = nil,
  source = false,  -- NOTE: Set in `smart_format`.

  spacing = 4,
  prefix = "●", suffix = nil,
  hl_mode = nil,  -- Use default.

  virt_text = nil,  -- Use default.
  virt_text_pos = "eol",
  virt_text_win_col = nil,  -- Use default.
  virt_text_hide = false,

  format = M.smart_format,  -- Show the error code.
}


---Virtual lines options.
---@type vim.diagnostic.Opts.VirtualLines
M.virtual_lines_opts = {
  severity = vim.diagnostic.severity.ERROR,
  current_line = true,
  format = M.smart_format,
}


---Whether diagnostic virtual text is currently shown.
---@return boolean
function M.virtual_text_enabled()
  return vim.diagnostic.config().virtual_text ~= false
end


---Show or hide diagnostic virtual text.
---@param state boolean
function M.set_virtual_text(state)
  vim.diagnostic.config({ virtual_text = state and M.virtual_text_opts or false })
end


function M.setup()
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,

    underline = { severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.HINT } },

    virtual_text = M.virtual_text_opts,

    -- NOTE: `false` skips the handler entirely.
    virtual_lines = false,

    signs = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.HINT },
      priority = fvim.settings.priority.diagnostics,

      text = {
        [vim.diagnostic.severity.ERROR] = fvim.icons.diagnostics.BoldError,
        [vim.diagnostic.severity.WARN]  = fvim.icons.diagnostics.BoldWarn,
        [vim.diagnostic.severity.INFO]  = fvim.icons.diagnostics.BoldInfo,
        [vim.diagnostic.severity.HINT]  = fvim.icons.diagnostics.BoldHint,
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
        -- [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = "ErrorLine",
        [vim.diagnostic.severity.WARN]  = "WarnLine",
        -- [vim.diagnostic.severity.INFO]  = "InfoLine",
        -- [vim.diagnostic.severity.HINT]  = "HintLine",
      },
    },

    float = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.HINT },
      severity_sort = false,

      bufnr = nil,  -- Current buffer.
      namespace = nil,  -- Use default.
      scope = "line",
      pos = nil,  -- Use default (under cursor).
      border = "rounded",

      header = "",
      prefix = nil,  -- Use default (`N. `, only dropped for a lone `scope = "cursor"` diagnostic).
      suffix = nil,  -- Use default (` [code]`).
      source = true,
      focus_id = nil,  -- Use default.
    },

    jump = {
      on_jump = nil,  -- Use default.
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.WARN },
      wrap = true,
    }
  })


end


return M
