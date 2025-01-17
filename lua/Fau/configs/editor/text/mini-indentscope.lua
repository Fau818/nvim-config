-- =============================================
-- ========== Plugin Configurations
-- =============================================
local indentscope = require("mini.indentscope")

local config = {
  draw = {
    delay = 100,
    animation = nil,  -- Use default.
    predicate = nil,  -- Use default.
    priority = 2,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Textobjects
    object_scope             = "ii",
    object_scope_with_border = "ai",

    -- Motions (jump to respective border line; if not present - body line)
    goto_top    = "[i",
    goto_bottom = "]i",
  },

  -- Options which control scope computation
  options = {
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border           = "both",
    indent_at_cursor = true,
    try_as_border    = true,
  },
  symbol = Fau_vim.icons.ui.IndentLine,
}

indentscope.setup(config)



-- =============================================
-- ========== Autocmd
-- =============================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  group = "Fau_vim",
  desc = "Config mini.indentscope for python.",
  callback = function() vim.b.miniindentscope_config = { options = { border = "top" } } end
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = Fau_vim.file.excluded_filetypes,
  group = "Fau_vim",
  desc = "Disable indentscope in excluded filetypes.",
  callback = function() vim.b.miniindentscope_disable = true end,
})
