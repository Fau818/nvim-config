---Generate keyword patterns for both "keyword:" and "[keyword]" forms.
---@param keyword string
---@param hl_group string
---@param case_sensitive? boolean
---@return Todotag.Config.KeywordOptions[]
local function kw(keyword, hl_group, case_sensitive)
  return {
    { pattern = keyword .. ":", hl_part = keyword, hl_group = hl_group, case_sensitive = case_sensitive or false },
    { pattern = "[" .. keyword .. "]", hl_group = hl_group, case_sensitive = case_sensitive or false },
  }
end


---@type LazyPluginSpec
return {
  ---@module "todotag"
  "fau818/todotag.nvim",
  dependencies = "folke/todo-comments.nvim",
  -- dir = "~/Documents/Fau/projects/todotag.nvim",  -- For development.

  cmd = { "TodotagStart", "TodotagStop" },
  event = { "BufReadPost", "BufNewFile" },

  ---@type Todotag.Config
  opts = {
    keywords = vim.iter({
      kw("todo",  "TodoTag"),

      kw("test",  "InfoTag"),
      kw("note",  "InfoTag"),
      kw("hint",  "InfoTag"),
      kw("PS",    "InfoTag", true),

      kw("bug",   "FixTag"),
      kw("fix",   "FixTag"),
      kw("fixme", "FixTag"),
      kw("fixit", "FixTag"),
      kw("issue", "FixTag"),
    }):flatten():totable(),

    only_visible = true,

    priority = nil,    -- Use default.
    throttle = nil,    -- Use default.

    exclude_ft = fvim.file.excluded_filetypes,
    exclude_bt = fvim.file.excluded_buftypes,
  },

  config = function(_, opts)
    vim.api.nvim_set_hl(0, "TodoTag", { fg = fvim.colors.dark_green, bold = true, italic = true, default = true })
    vim.api.nvim_set_hl(0, "InfoTag", { fg = fvim.colors.cyan_blue, bold = true, italic = true, default = true })
    vim.api.nvim_set_hl(0, "FixTag",  { fg = fvim.colors.red1, bold = true, italic = true, default = true })

    require("todotag").setup(opts)
  end,
}
