-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Icons
-- -----------------------------------

local signs = {
  { name = "DiagnosticSignError", text = Fau_vim.icons.diagnostics.BoldError,   line = "ErrorLine"   },
  { name = "DiagnosticSignWarn",  text = Fau_vim.icons.diagnostics.BoldWarning, line = "WarningLine" },
  { name = "DiagnosticSignHint",  text = Fau_vim.icons.diagnostics.BoldHint,    line = "HintLine"    },
  { name = "DiagnosticSignInfo",  text = Fau_vim.icons.diagnostics.BoldInfo,    line = "InfoLine"    },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, {
    texthl = sign.name,
    numhl  = sign.name,
    text   = sign.text,
    linehl = sign.line,
  })
end


-- -----------------------------------
-- -------- Diagnostics
-- -----------------------------------
local config = {
  virtual_text = {
    prefix="●", spacing = 4,

    ---@param diagnostic Diagnostic
    ---@return string|nil #Diagnostic message
    format = function(diagnostic)  -- for show the error code
      -- Remove Pyright diagnostics
      if diagnostic.source == "Pyright" or "Pylance" then return nil
      elseif diagnostic.source == "clang" then if diagnostic.message:sub(1, 6) == "Unused" then return nil end
      end

      return diagnostic.message
    end,
  },

  -- virtual_text = false,
  signs = true,

  underline = true,
  update_in_insert = true,

  severity_sort = true,
  float = {
    focusable = true,
    border = "rounded",

    scope = "line", -- values: cursor|line|buffer
    source = true,  -- values: boolean|if_many

    header = "",
    prefix = "",

    -- ---@param diagnostic Diagnostic
    -- ---@return string Diagnostic message
    -- format = function(diagnostic)  -- for show the error code
    --   local code = nil
    --   if string.sub(diagnostic.source, 1, 3) ~= "Lua" then
    --     code = diagnostic.code or (diagnostic.user_data and diagnostic.user_data.lsp.code)
    --   end
    --   if code then return string.format("%s [%s]", diagnostic.message, code) end
    --   return diagnostic.message
    -- end,
  },

}


vim.diagnostic.config(config)
