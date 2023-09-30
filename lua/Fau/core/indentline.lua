-- =============================================
-- ========== Plugin Loading
-- =============================================
local indent_blankline_ok, indent_blankline = pcall(require, "ibl")
if not indent_blankline_ok then Fau_vim.load_plugin_error("indent_blankline") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  enabled = true,
  debounce = 200,

  indent = {
    char = Fau_vim.icons.ui.IndentLine,
    smart_indent_cap = true,
  },

  -- viewport_buffer = {},
  whitespace = {},
  scope = {},

  exclude = { filetype = Fau_vim.disabled_filetypes },
}


indent_blankline.setup(config)


-- TEST: Disabled in Sep 29, 2023.
-- -- BUG: The indentline will disappear when scroll vertically.
-- -- A temporary solution:
-- vim.api.nvim_create_augroup("IndentBlankLineFix", {})
-- vim.api.nvim_create_autocmd("WinScrolled", {
--   group = "IndentBlankLineFix",
--   callback = function()
--     if vim.v.event.all.leftcol ~= 0 then
--       vim.cmd("silent! IndentBlanklineRefresh")
--     end
--   end,
-- })
