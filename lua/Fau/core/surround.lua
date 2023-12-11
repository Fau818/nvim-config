-- =============================================
-- ========== Plugin Loading
-- =============================================
local surround_ok, surround = pcall(require, "nvim-surround")
if not surround_ok then Fau_vim.load_plugin_error("nvim-surround") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type user_options
local config = {
  keymaps = {
    insert = false,
    insert_line = false,
    normal = "s",
    normal_cur = "ss",
    normal_line = false,
    normal_cur_line = "S",
    visual = "s",
    visual_line = "S",
    delete = "ds",
    change = "cs",
    change_line = "cS",
  },

  aliases = {
    ["a"] = ">",
    ["b"] = ")",
    ["B"] = "{",
    ["r"] = "]",
    ["q"] = { '"', "'", "`" },
    ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
  },
}


surround.setup(config)
