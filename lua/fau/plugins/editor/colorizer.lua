---@type LazySpec
return {
  -- DESC: Colorizer for showing color.
  ---@module "colorizer"
  "catgoose/nvim-colorizer.lua",
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    -- NOTE: Exclusion Only makes sense if '*' is specified first!
    filetypes = { "*", "!c", "!cpp", "!lazy", "!sidekick_terminal", notify = { RGB = false } },
    buftypes = fvim.file.excluded_buftypes,  -- Use default.
    user_commands = true,  ---@type boolean | table Enable all or some usercommands
    lazy_load = false,  -- NOTE: If true, cmp_menu will not show colors.

    user_default_options = {
      names = false,         -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
      names_opts = {         -- options for mutating/filtering names.
        lowercase = true,    -- name:lower(), highlight `blue` and `red`
        camelcase = true,    -- name, highlight `Blue` and `Red`
        uppercase = false,   -- name:upper(), highlight `BLUE` and `RED`
        strip_digits = false,  -- ignore names with digits, highlight `blue` and `red`, but not `blue3` and `red4`
      },
      names_custom = false, -- Custom names to be highlighted: table|function|false

      RGB      = true,  -- #RGB hex codes
      RRGGBB   = true,  -- #RRGGBB hex codes
      RRGGBBAA = true,  -- #RRGGBBAA hex codes
      AARRGGBB = true,  -- 0xAARRGGBB hex codes

      rgb_fn = true,  -- CSS rgb() and rgba() functions
      hsl_fn = true,  -- CSS hsl() and hsla() functions

      css    = true,  -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true,  -- Enable all CSS *functions*: rgb_fn, hsl_fn

      tailwind      = true,  ---@type boolean | "normal" | "lsp" | "both"
      tailwind_opts = { update_names = false },

      sass = { enable = true, parsers = { "css" } },

      xterm = false,  -- NOTE: Huge performance hit.

      mode = "background",  ---@type "foreground" | "background" | "virtualtext"

      virtualtext = "■",
      virtualtext_inline = true,
      virtualtext_mode = "foreground",  ---@type "background" | "foreground"

      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = true,

      hooks = {
        -- called before line parsing.  Accepts boolean or function that returns boolean
        do_lines_parse = false,
      },
    }
  }
}
