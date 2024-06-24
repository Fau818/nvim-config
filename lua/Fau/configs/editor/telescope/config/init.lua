-- TODO: Let grep_string/live_grep like center (layout_strategy)
-- ==================== Telescope ====================
local telescope = require("telescope")

local config = {
  defaults   = require("Fau.configs.editor.telescope.config.defaults"),
  pickers    = require("Fau.configs.editor.telescope.config.pickers"),
  extensions = require("Fau.configs.editor.telescope.config.extensions")
}

telescope.setup(config)


-- ==================== Extensions ====================
telescope.load_extension("fzf")
