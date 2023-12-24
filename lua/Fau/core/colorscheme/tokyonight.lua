-- =============================================
-- ========== Plugin Loading
-- =============================================
local tokyonight_ok, tokyonight = pcall(require, "tokyonight")
if not tokyonight_ok then Fau_vim.load_plugin_error("tokyonight") return end
Fau_vim.colors.tokyonight = require("tokyonight.colors").moon()


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
    colors.comment        = Fau_vim.colors.gray
    colors.terminal_black = Fau_vim.colors.gray
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    -- -----------------------------------
    -- -------- Syntax
    -- -----------------------------------
    highlights["Define"] = { fg = Fau_vim.colors.gray, italic = true }
    highlights["Statement"] = { fg = colors.magenta, italic = true }
    highlights["@constant.builtin"] = { fg = Fau_vim.colors.light_blue, italic = true }

    highlights["Number"]  = { fg = Fau_vim.colors.light_blue }
    highlights["String"]  = { fg = Fau_vim.colors.light_green }
    highlights["Boolean"] = { fg = colors.orange, italic = true }

    highlights["@keyword"] = { fg = colors.purple, italic = true, nocombine = true }
    highlights["@keyword.function"] = { fg = Fau_vim.colors.purple, italic = true }
    highlights["@keyword.operator"] = { fg = colors.blue5, italic = true }

    highlights["MatchParen"] = { fg = Fau_vim.colors.yellow, bold = true }

    highlights["@function.builtin"] = { fg = Fau_vim.colors.purple_blue, italic = true }

    highlights["@string.documentation"] = { fg = Fau_vim.colors.cyan_gray }

    highlights["PaintSeparator"] = { fg = "#483D8B" }


    -- -----------------------------------
    -- -------- Custom
    -- -----------------------------------
    highlights["NvimTreeWinSeparator"] = { fg = Fau_vim.colors.light_blue }
    highlights["MiniTrailspace"] = { link = "DiagnosticUnderlineWarn" }
    highlights["MiniIndentscopeSymbol"] = { fg = Fau_vim.colors.yellow }

    highlights["FloatBorder"]   = { fg = Fau_vim.colors.cobalt }
    highlights["LspInfoBorder"] = { fg = Fau_vim.colors.cobalt }
    highlights["LspInlayHint"] = { fg = colors.dark3 }

    highlights["TelescopeBorder"]       = { fg = Fau_vim.colors.cobalt }
    highlights["TelescopePromptPrefix"] = { fg = Fau_vim.colors.purple_blue }

    highlights["CmpItemKindCopilot"] = { fg = Fau_vim.colors.light_blue }

    highlights["WinSeparator"] = { fg = Fau_vim.colors.light_blue }


    -- -----------------------------------
    -- -------- Cover BufferLine
    -- -----------------------------------
    highlights["BufferLineIndicatorSelected"] = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.dark_purple, bold = true, italic = false }


    -- -----------------------------------
    -- -------- Diagnostics
    -- -----------------------------------
    highlights["ErrorLine"]   = { bg = "#2c1418" }
    highlights["WarningLine"] = { bg = "#362716" }
    -- highlights["InfoLine"]    = { bg = "#182a3a" }
    -- highlights["HintLine"]    = { bg = "#1b251d" }

    highlights["DiagnosticFloatingError"] = { link = "DiagnosticError" }
    highlights["DiagnosticFloatingWarn"]  = { link = "DiagnosticWarn" }
    highlights["DiagnosticFloatingInfo"]  = { link = "DiagnosticInfo" }
    highlights["DiagnosticFloatingHint"]  = { link = "DiagnosticHint" }

  end,
}


tokyonight.setup(config)
