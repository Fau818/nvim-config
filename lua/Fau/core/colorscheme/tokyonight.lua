-- =============================================
-- ========== Plugin Loading
-- =============================================
local tokyonight_ok, tokyonight = pcall(require, "tokyonight")
if not tokyonight_ok then Fau_vim.load_plugin_error("tokyonight") return end



-- =============================================
-- ========== Configuration
-- =============================================
local function comment_style()
  local term_type = os.getenv("TERM")
  if term_type == "xterm-kitty" or os.getenv("KITTY_PID") then
    return { italic = true, bold = true }
  end
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
    sidebars = "transparent", -- style for sidebars
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
    colors.comment = Fau_vim.colors.gray
    colors.terminal_black = Fau_vim.colors.gray

    -- vim.g.terminal_color_0  = "#000000"
    -- vim.g.terminal_color_8  = "#666666"
    -- vim.g.terminal_color_1  = "#C91B00"
    -- vim.g.terminal_color_9  = "#E50000"
    -- vim.g.terminal_color_2  = "#00C800"
    -- vim.g.terminal_color_10 = "#00DC00"
    -- vim.g.terminal_color_3  = "#DBDB22"
    -- vim.g.terminal_color_11 = "#EEEE55"
    -- vim.g.terminal_color_4  = "#007DFF"
    -- vim.g.terminal_color_12 = "#0096FF"
    -- vim.g.terminal_color_5  = "#AD83E9"
    -- vim.g.terminal_color_13 = "#BA99FA"
    -- vim.g.terminal_color_6  = "#10C5EA"
    -- vim.g.terminal_color_14 = "#30E1FD"
    -- vim.g.terminal_color_7  = "#C7C7C7"
    -- vim.g.terminal_color_15 = "#FFFFFF"
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    -- highlights["Include"]   = { fg = Fau_vim.colors.blue, italic=true }
    highlights["Define"] = { fg = Fau_vim.colors.gray, italic = true }
    highlights["Statement"] = { fg = colors.magenta, italic = true }
    highlights["@constant.builtin"] = { fg = Fau_vim.colors.light_blue, italic = true }

    highlights["Number"]  = { fg = Fau_vim.colors.light_blue }
    highlights["String"]  = { fg = Fau_vim.colors.light_green }
    highlights["Boolean"] = { fg = colors.orange, italic = true }

    highlights["@keyword.function"] = { fg = Fau_vim.colors.purple, italic = true }
    highlights["@keyword.operator"] = { fg = colors.blue5, italic = true }

    highlights["MatchParen"] = { fg = Fau_vim.colors.yellow, bold = true }

    highlights["@function.builtin"] = { fg = Fau_vim.colors.purple_blue, italic = true }

    highlights["@string.documentation"] = { fg = Fau_vim.colors.cyan_gray }


    -- -----------------------------------
    -- -------- Plugin
    -- -----------------------------------
    highlights["NvimTreeWinSeparator"] = { fg = "#589ed7" }
    highlights["MiniTrailspace"] = { link = "DiagnosticUnderlineWarn" }
    highlights["MiniIndentscopeSymbol"] = { fg = Fau_vim.colors.yellow }

    highlights["FloatBorder"]   = { fg = Fau_vim.colors.cobalt }
    highlights["LspInfoBorder"] = { fg = Fau_vim.colors.cobalt }

    highlights["TelescopeBorder"]       = { fg = Fau_vim.colors.cobalt }
    highlights["TelescopePromptPrefix"] = { fg = Fau_vim.colors.purple_blue }

    -- -----------------------------------
    -- -------- test
    -- -----------------------------------
    highlights["CmpItemKindCopilot"] = { fg = Fau_vim.colors.light_blue }
    highlights["LspInlayHint"] = { fg = colors.dark3 }
    highlights["@keyword"] = { fg = colors.purple, italic = true, nocombine = true }
  end,
}


tokyonight.setup(config)
