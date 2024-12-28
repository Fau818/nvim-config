-- ==================== Telescope ====================
local telescope = require("telescope")

local config = {
  defaults   = require("Fau.configs.editor.ui.telescope.config.defaults"),
  pickers    = require("Fau.configs.editor.ui.telescope.config.pickers"),
  extensions = require("Fau.configs.editor.ui.telescope.config.extensions")
}

telescope.setup(config)


-- ==================== Extensions ====================
telescope.load_extension("fzf")
