-- =============================================
-- ========== Plugin Configurations
-- =============================================
local surround = require("nvim-surround")

---@type user_options
local config = {
  keymaps = {
    insert      = false,
    insert_line = false,

    normal          = "s",
    normal_cur      = "ss",
    normal_line     = false,
    normal_cur_line = "S",

    visual      = "s",
    visual_line = "S",

    delete = "ds",

    change      = "cs",
    change_line = "cS",
  },

  aliases = {
    ["B"] = "{",
    ["q"] = { '"', "'", "`" },
    ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
  },

  move_cursor = "sticky",
}

surround.setup(config)
