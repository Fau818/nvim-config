-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Icons
-- -----------------------------------
local signs = {
  { name = "DiagnosticSignError", text = Fau_vim.icons.diagnostics.BoldError },
  { name = "DiagnosticSignWarn",  text = Fau_vim.icons.diagnostics.BoldWarning },
  { name = "DiagnosticSignHint",  text = Fau_vim.icons.diagnostics.BoldHint },
  { name = "DiagnosticSignInfo",  text = Fau_vim.icons.diagnostics.BoldInformation },
}
for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, numhl = sign.name, text = sign.text })
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
      -- Remove `xxx is not accessed` in Pyright
      if diagnostic.source == "Pyright" then
        local pattern = "accessed"
        if string.sub(diagnostic.message, -string.len(pattern)) == pattern then return nil end
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
