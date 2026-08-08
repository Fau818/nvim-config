---@type LazyPluginSpec
return {
  -- DESC: Fade unused code and inline suggestions, keeping their syntax colours.
  ---@module "fade"
  "Fau818/fade.nvim",

  -- `unused` needs a server attached, `ghost` needs insert mode.
  event = { "LspAttach", "InsertEnter" },

  ---@type fade.Config
  opts = {
    unused = {
      alpha = 0.75,
      min_contrast = 3.0,
      ignore = {},
      hide = { underline = true, virtual_text = true, signs = true },
      patterns = {},
      exclude = fvim.file.excluded_filetypes,
    },

    ghost = {
      alpha = 0.65,  -- A suggestion should sit further back than real code.
      min_contrast = 3.0,
      ignore = { "@comment" },
      providers = { copilot = true, blink = true },
    },
  },
}
