-- ==================== Telescope ====================
local telescope = require("telescope")

local config = {
  defaults   = require("Fau.ui.telescope.config.defaults"),
  pickers    = require("Fau.ui.telescope.config.pickers"),
  extensions = require("Fau.ui.telescope.config.extensions")
}

telescope.setup(config)


-- ==================== Extensions ====================
telescope.load_extension("fzf")
