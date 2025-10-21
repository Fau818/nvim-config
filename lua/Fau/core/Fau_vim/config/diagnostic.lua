local M = {}

M.virtual_text = true
M.virtual_lines = false

function M._setup()
  vim.diagnostic.config({
    update_in_insert = true,
    severity_sort = true,

    underline = { severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.HINT } },

    virtual_text = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.WARN },
      current_line = false,
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
        if not Fau_vim.diagnostic.virtual_text then return nil end

        local message = ("%s: %s [%s]"):format(diagnostic.source, diagnostic.message, diagnostic.code)
        -- Remove Pyright diagnostics
        -- TEMP: If not used in the future, remove this code. Oct 21, 2025.
        -- if diagnostic.source == "Pyright" or "Pylance" then return nil
        -- elseif diagnostic.source == "clang" then if diagnostic.message:sub(1, 6) == "Unused" then return nil end
        -- end
        return message
      end,
    },

    virtual_lines = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.WARN },
      current_line = true,
      format = function(diagnostic)
        if not Fau_vim.diagnostic.virtual_lines then return nil end
        return ("%s [%s]"):format(diagnostic.message, diagnostic.code)
      end,
    },

    signs = {
      severity = { max = vim.diagnostic.severity.ERROR, min = vim.diagnostic.severity.HINT },
      priority = Fau_vim.settings.sign_priority.diagnostics,

      text = {
        [vim.diagnostic.severity.ERROR] = Fau_vim.icons.diagnostics.BoldError,
        [vim.diagnostic.severity.WARN]  = Fau_vim.icons.diagnostics.BoldWarn,
        [vim.diagnostic.severity.INFO]  = Fau_vim.icons.diagnostics.BoldInfo,
        [vim.diagnostic.severity.HINT]  = Fau_vim.icons.diagnostics.BoldHint,
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignHint",
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignInfo",
      },
      linehl = {
        [vim.diagnostic.severity.ERROR] = "ErrorLine",
        [vim.diagnostic.severity.WARN]  = "WarnLine",
        [vim.diagnostic.severity.INFO]  = "HintLine",
        [vim.diagnostic.severity.HINT]  = "InfoLine",
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

M._setup()


return M
