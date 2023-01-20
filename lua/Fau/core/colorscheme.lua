local colorscheme = "tokyonight"  -- tokyonight-moon, darkplus, tokyonight-night

-- =============================================
-- ========== Configuration
-- =============================================
if string.sub(colorscheme, 1, 10) == "tokyonight" then
	local tokyonight = Fau_vim.load_plugin("tokyonight")
	if tokyonight == nil then return end


	local config = {
		style       = "moon",   -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
		light_style = "moon",   -- The theme is used when the background is set to light
		transparent = true,     -- Enable this to disable setting the background color
		terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
		styles = {
			comments  = { italic = false },
			keywords  = { italic = true },
			functions = {},
			variables = {},
			-- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = "transparent", -- style for sidebars, see below
			floats   = "transparent", -- style for floating windows
		},
		sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
		day_brightness = 0.2, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
		hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
		dim_inactive = true, -- dims inactive windows
		lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

		--- You can override specific color groups to use other groups or a hex color
		--- function will be called with a ColorScheme table
		---@param colors ColorScheme
		on_colors = function(colors)
			colors.comment = "#666688"
		end,

		-- --- You can override specific highlights to use other groups or a hex color
		-- --- function will be called with a Highlights and ColorScheme table
		-- ---@param highlights Highlights
		-- ---@param colors ColorScheme
		-- on_highlights = function(highlights, colors) end,
	}

	tokyonight.setup(config)
end



-- =============================================
-- ========== Colorscheme Applying
-- =============================================
---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	Fau_vim.notify("colorscheme [" .. colorscheme .. "] not found!", "error")
	return
end
