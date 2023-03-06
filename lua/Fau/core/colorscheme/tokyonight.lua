-- =============================================
-- ========== Plugin Loading
-- =============================================
local tokyonight_ok, tokyonight = pcall(require, "tokyonight")
if not tokyonight_ok then Fau_vim.load_plugin_error("tokyonight") return end



-- =============================================
-- ========== Configuration
-- =============================================
local function comment_style()
  local terminal = os.getenv("TERM")
  if terminal == "xterm-kitty" then return { italic = true, bold = true } end
  return { italic = true }
end


---@type Config
local config = {
  style       = "moon",   -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "moon",   -- The theme is used when the background is set to light
  transparent = true,     -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    comments  = comment_style(),
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
    colors.comment = "#636D8E"
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    highlights["MiniTrailspace"] = { link = "DiagnosticUnderlineWarn" }
    highlights["MiniIndentscopeSymbol"] = { fg = "#FFFF00", }

    highlights["FloatBorder"] = { fg = "#9999FF" }
    highlights["LspInfoBorder"] = { fg = "#9999FF" }

    highlights["TelescopeBorder"] = { fg = "#9999FF" }
    highlights["TelescopePromptPrefix"] = { fg = "#FFFF00" }
    -- highlights["TelescopeMatching"] = { fg = "#9999FF" }

    highlights["Include"] = {
      fg = colors.cyan,
      style = { italic = true }
    }
    highlights["Define"] = {
      fg = colors.cyan,
      style = { italic = true }
    }

    highlights["@keyword.function"] = {
      fg = colors.magenta,
      style = { italic = true }
    }
    highlights["@keyword.operator"] = {
      fg = colors.blue5,
      style = { italic = true }
    }

    highlights["Statement"] = {
      fg = colors.magenta,
      style = { italic = true }
    }

    -- highlights["@type.builtin"] = {
    --  fg = colors.blue1,
    --  style = { italic = true }
    -- }
    --
    -- highlights["@type.qualifier"] = {
    --  fg = colors.blue1,
    --  style = { italic = true }
    -- }


  end,
}


tokyonight.setup(config)
