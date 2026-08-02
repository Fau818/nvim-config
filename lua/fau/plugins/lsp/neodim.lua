------@type LazyPluginSpec
---return {
---  ---@module "neodim"
---  -- "zbirenbaum/neodim",
---  "ALVAROPING1/neodim",
---  branch = "fix-nvim-0.11",
---
---  event = "LspAttach",
---
---  opts = {
---    alpha = 0.75,
---    blend_color = nil,
---
---    hide = { underline = true, virtual_text = true, signs = true },
---
---    -- NOTE: It also checks for diagnostic._tags.unnecessary
---    -- SEE: https://github.com/zbirenbaum/neodim/blob/1b8bda59a53b49ec2b59885e9fe78f8e90a1de76/lua/neodim/filter.lua#L52
---    regex = {
---      -- "[uU]nused",
---      -- "[nN]ever [rR]ead",
---      -- "[nN]ot [rR]ead",
---      lua = {},
---      python = { "[nN]ot [aA]ccessed" },
---    },
---
---    priority = 9999,  -- TEST: Set from 128 to 9999. Oct 14, 2025
---
---    disable = fvim.file.excluded_filetypes,
---  },
---}

---@type LazyPluginSpec
return {
  -- DESC: Fade unused code and inline suggestions, keeping their syntax colours.
  ---@module "fade"
  "fade.nvim",
  -- NOTE: Local checkout until it is published; swap for "Phoenix/fade.nvim" then.
  dir = vim.fn.expand("~/Documents/Fau/projects/fade.nvim"),

  -- `unused` needs a server attached, `ghost` needs insert mode.
  event = { "LspAttach", "InsertEnter" },

  ---@type fade.Config
  opts = {
    unused = {
      alpha = 0.75,

      -- NOTE: Hiding `underline` is what hands the fading over to the plugin -- it is also where
      -- Neovim applies its own flat `DiagnosticUnnecessary`.
      hide = { underline = true, virtual_text = true, signs = true },

      -- NOTE: basedpyright and ruff both send the LSP `unnecessary` tag, so no patterns needed.
      patterns = {},

      exclude = fvim.file.excluded_filetypes,
    },

    ghost = {
      alpha = 0.65,  -- A suggestion should sit further back than real code.
      providers = { copilot = true, blink = true },
    },
  },
}
