local M = {}

M.virtual_text = true
M.virtual_lines = false


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
  else  -- not source and not code
    return message
  end
end


function M.setup()
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,

    underline = { severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.HINT } },

    virtual_text = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.WARN },
      current_line = nil,
      source = false,  -- NOTE: Set in format function below.

      spacing = 4,
      prefix = "●", suffix = nil,
      hl_mode = nil,  -- Use default.

      virt_text = nil,  -- Use default.
      virt_text_pos = "eol",
      virt_text_win_col = nil,  -- Use default.
      virt_text_hide = false,

      -- format = nil,  -- Use default format.
      format = function(diagnostic)  -- for show the error code
        -- EXIT: Virtual text is disabled.
        if not M.virtual_text then return nil end
        return M.smart_format(diagnostic)
      end,
    },

    virtual_lines = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.WARN },
      current_line = true,
      format = function(diagnostic)
        if not M.virtual_lines then return nil end
        return ("%s [%s]"):format(diagnostic.message, diagnostic.code or "N/A")
      end,
    },

    signs = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.HINT },
      priority = fvim.settings.sign_priority.diagnostics,

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
      prefix = nil,  -- Use default ([code]).
      suffix = nil,  -- Use default (No.).
      source = true,
      focus_id = nil,  -- Use default.

      -- format = function(diagnostic) return ("%s: %s [%s]"):format(diagnostic.source, diagnostic.message, diagnostic.code) end,
    },

    jump = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.WARN },
      float = false,
      wrap = true,
    }
  })


end


return M
