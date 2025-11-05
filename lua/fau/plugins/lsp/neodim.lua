---@type LazySpec
return {
  ---@module "neodim"
  -- "zbirenbaum/neodim",
  -- TEMP: Use a forked version to fix the issue with Neovim 0.11
  "ALVAROPING1/neodim",
  branch = "fix-nvim-0.11",

  event = "LspAttach",

  opts = {
    alpha = 0.85,
    blend_color = nil,
    hide = { underline = true, virtual_text = true, signs = true },
    regex = { "[uU]nused", "[nN]ever [rR]ead", "[nN]ot [rR]ead", "[nN]ot [aA]ccessed" },
    priority = 9999,  -- TEST: Set from 128 to 9999. Oct 14, 2025
    disable = fvim.file.excluded_filetypes
  },
}
