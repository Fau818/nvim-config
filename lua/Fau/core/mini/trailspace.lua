-- =============================================
-- ========== Plugin Loading
-- =============================================
local trailspace_ok, trailspace = pcall(require, "mini.trailspace")
if not trailspace_ok then Fau_vim.load_plugin_error("mini.trailspace") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  -- Highlight only in normal buffers (ones with empty 'buftype'). This is
  -- useful to not show trailing whitespace where it usually doesn't matter.
  only_in_normal_buffers = true,
}


trailspace.setup(config)


-- Overwrite function
Fau_vim.functions.format.remove_blank_lines_and_spaces = function()
  trailspace.trim_last_lines(); trailspace.trim()
end



-- =============================================
-- ========== Autocmd
-- =============================================
-- Disable trailspace in some filetype
vim.api.nvim_create_autocmd("FileType", {
  group = "Fau_vim",
  desc = "Disable trailspace in some filetypes.",
  pattern = Fau_vim.disabled_filetypes,
  callback = function() vim.b.minitrailspace_disable = true end,
})
