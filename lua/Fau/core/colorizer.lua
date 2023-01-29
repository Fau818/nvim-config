-- =============================================
-- ========== Plugin Loading
-- =============================================
local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then Fau_vim.load_plugin_error("colorizer") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	filetypes = { "*" },
	user_default_options = {
		RGB    = true, -- #RGB hex codes
		RRGGBB = true, -- #RRGGBB hex codes

		names = false, -- "Name" codes like Blue or blue

		RRGGBBAA = true, -- #RRGGBBAA hex codes
		AARRGGBB = true, -- 0xAARRGGBB hex codes

		rgb_fn = true, -- CSS rgb() and rgba() functions
		hsl_fn = true, -- CSS hsl() and hsla() functions

		css    = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
		css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

		mode = "background", -- values: foreground|background|virtualtext
		-- Available methods are false / true / "normal" / "lsp" / "both"
		-- True is same as normal

		tailwind = false, -- Enable tailwind colors

		-- parsers can contain values used in |user_default_options|
		-- sass = { enable = false, parsers = { css }, }, -- Enable sass colors
		virtualtext = "■",
	},
	-- all the sub-options of filetypes apply to buftypes
	buftypes = { "*" },
}


colorizer.setup(config)
