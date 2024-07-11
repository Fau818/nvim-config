-- =============================================
-- ========== Plugin Loading
-- =============================================
local indentscope_ok, indentscope = pcall(require, "mini.indentscope")
if not indentscope_ok then Fau_vim.load_plugin_error("mini.indentscope") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  draw = {
    delay = 100,
    -- animation = require("mini.indentscope").gen_animation.quadratic({ easing="in-out", duration=20, unit="step" })
    priority = 2,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Textobjects
    object_scope = "ii",
    object_scope_with_border = "ai",

    -- Motions (jump to respective border line; if not present - body line)
    goto_top = "[i",
    goto_bottom = "]i",
  },

  -- Options which control scope computation
  options = {
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border = "both",
    indent_at_cursor = true,
    try_as_border = true,
  },
  symbol = Fau_vim.icons.ui.IndentLine,
}



-- =============================================
-- ========== Autocmd
-- =============================================
-- Special for python
vim.api.nvim_create_autocmd("FileType", {
  desc = "Config indentscope plugin for python.",
  pattern = "python",
  callback = function() vim.b.miniindentscope_config = { options = { border = "top" } } end
})


-- Disable indentscope in some filetype
vim.api.nvim_create_autocmd("FileType", {
  desc = "Disabled indentscope in some filetypes.",
  pattern = Fau_vim.file.excluded_filetypes,
  callback = function() vim.b.miniindentscope_disable = true end,
})


indentscope.setup(config)
