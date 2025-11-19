---@type LazySpec
return {
  ---@module "todotag"
  "fau818/todotag.nvim",
  dependencies = "folke/todo-comments.nvim",

  cmd = { "TodotagStart", "TodotagStop" },
  event = { "BufReadPost", "BufNewFile" },

  ---@type Todotag.Config
  opts = {
    keywords = {
      todo = { hl_group = "TodoTag", case_sensitive = false },

      test = { hl_group = "InfoTag", case_sensitive = false },
      note = { hl_group = "InfoTag", case_sensitive = false },
      hint = { hl_group = "InfoTag", case_sensitive = false },
      PS   = { hl_group = "InfoTag", case_sensitive = true },

      bug   = { hl_group = "FixTag", case_sensitive = false },
      fix   = { hl_group = "FixTag", case_sensitive = false },
      fixme = { hl_group = "FixTag", case_sensitive = false },
      fixit = { hl_group = "FixTag", case_sensitive = false },
      issue = { hl_group = "FixTag", case_sensitive = false },
    },

    only_visible = true,

    priority = nil,    -- Use default.
    throttle = nil,    -- Use default.

    exclude_ft = fvim.file.excluded_filetypes,
    exclude_bt = fvim.file.excluded_buftypes,
  },
}
