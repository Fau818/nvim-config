-- =============================================
-- ========== Plugin Configurations
-- =============================================
local colorizer = require("colorizer")

local config = {
  filetypes = { "*", "!c", "!cpp", "!lazy", notify = { RGB = false } },
  user_default_options = {
    RGB    = true,  -- #RGB hex codes
    RRGGBB = true,  -- #RRGGBB hex codes

    names = false,  -- "Name" codes like Blue or blue

    RRGGBBAA = true,  -- #RRGGBBAA hex codes
    AARRGGBB = true,  -- 0xAARRGGBB hex codes

    rgb_fn = true,  -- CSS rgb() and rgba() functions
    hsl_fn = true,  -- CSS hsl() and hsla() functions

    css    = true,  -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true,  -- Enable all CSS *functions*: rgb_fn, hsl_fn

    mode     = "background",  ---@type "foreground" | "background" | "virtualtext"
    tailwind = true,  ---@type  false | true | "normal" | "lsp" | "both"

    -- parsers can contain values used in |user_default_options|
    sass = nil,  -- Use default.

    virtualtext = "■",
    virtualtext_inline = true,

    -- update color values even if buffer is not focused
    -- example use: cmp_menu, cmp_docs
    always_update = true,
  },

  -- all the sub-options of filetypes apply to buftypes
  buftypes = nil,
}

colorizer.setup(config)
