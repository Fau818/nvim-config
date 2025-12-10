---@type LazySpec
return {
  ---@module "neodim"
  "zbirenbaum/neodim",

  event = "LspAttach",

  opts = {
    alpha = 0.8,
    blend_color = nil,

    hide = { underline = true, virtual_text = true, signs = true },

    -- NOTE: It also checks for diagnostic._tags.unnecessary
    -- SEE: https://github.com/zbirenbaum/neodim/blob/1b8bda59a53b49ec2b59885e9fe78f8e90a1de76/lua/neodim/filter.lua#L52
    regex = {
      -- "[uU]nused",
      -- "[nN]ever [rR]ead",
      -- "[nN]ot [rR]ead",
      lua = {},
      python = { "[nN]ot [aA]ccessed" },
    },

    priority = 9999,  -- TEST: Set from 128 to 9999. Oct 14, 2025

    disable = fvim.file.excluded_filetypes,
  },
}
