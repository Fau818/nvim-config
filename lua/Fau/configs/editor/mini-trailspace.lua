-- =============================================
-- ========== Plugin Configurations
-- =============================================
local trailspace = require("mini.trailspace")

local config = {
  -- Highlight only in normal buffers (ones with empty 'buftype'). This is
  -- useful to not show trailing whitespace where it usually doesn't matter.
  only_in_normal_buffers = true,
}

trailspace.setup(config)



-- =============================================
-- ========== Override
-- =============================================
Fau_vim.functions.format.remove_blank_lines_and_spaces = function()
  trailspace.trim_last_lines(); trailspace.trim()
end



-- =============================================
-- ========== Autocmd
-- =============================================
-- Disable trailspace in some filetype
-- TODO: format autocmd like this params order
vim.api.nvim_create_autocmd("FileType", {
  pattern = Fau_vim.file.excluded_filetypes,
  group = "Fau_vim",
  desc = "Disable trailspace in some filetypes.",
  callback = function() vim.b.minitrailspace_disable = true end,
})
