-- =============================================
-- ========== Plugin Configurations
-- =============================================
local indent_blankline = require("ibl")

---@type ibl.config
local config = {
  enabled = true,
  debounce = 200,

  -- viewport_buffer = nil,

  indent = {
    char = Fau_vim.icons.ui.IndentLine,
    smart_indent_cap = true,
  },

  whitespace = {},
  scope = { enabled = false },

  exclude = {
    filetypes = Fau_vim.file.excluded_filetypes,
    buftypes  = Fau_vim.file.excluded_buftypes,
  },

}

indent_blankline.setup(config)



-- =============================================
-- ========== Hooks
-- =============================================
-- local hooks = require("ibl.hooks")

---Disabled in large file.
-- hooks.register(
--   hooks.type.ACTIVE,
--   function(bufnr) return not Fau_vim.functions.utils.is_large_file(bufnr) end
-- )
