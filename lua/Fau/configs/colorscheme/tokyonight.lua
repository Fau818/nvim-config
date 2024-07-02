-- =============================================
-- ========== Plugin Configurations
-- =============================================
local tokyonight = require("tokyonight")
Fau_vim.colors.tokyonight = require("tokyonight.colors.moon")


local function _comment_style()
  local term_type = os.getenv("TERM")
  if term_type == "xterm-kitty" or os.getenv("KITTY_PID") then
    return { italic = true, bold = true }
  end
  return { italic = true }
end


local config = {
  style           = "moon",  ---@type "moon" | "storm" | "night"
  light_style     = "day",
  transparent     = true,
  terminal_colors = true,

  styles = {
    comments  = _comment_style(),
    keywords  = { italic = true },
    functions = {},
    variables = {},
    sidebars  = "transparent",  ---@type "dark" | "transparent" | "normal"
    floats    = "transparent",  ---@type "dark" | "transparent" | "normal"
  },

  day_brightness = 0.3,  -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  dim_inactive = true,   -- dims inactive windows
  lualine_bold = false,  -- When `true`, section headers in the lualine theme will be bold

  use_background = true,
  cache = true,
  plugin = nil,  -- Use default.

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors)
    colors.comment        = Fau_vim.colors.gray
    colors.terminal_black = Fau_vim.colors.gray
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights tokyonight.Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    -- -----------------------------------
    -- -------- General
    -- -----------------------------------
    highlights["Bold"]   = { bold   = true }
    highlights["Italic"] = { italic = true }


    -- -----------------------------------
    -- -------- Lazy
    -- -----------------------------------
    highlights["LazyCommitType"]  = { fg = Fau_vim.colors.tokyonight.blue, italic = true }
    highlights["LazyCommitScope"] = { bold = true, italic = true }

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
    -- -------- Diagnostics
    -- -----------------------------------
    highlights["ErrorLine"]   = { bg = "#2C1418" }
    highlights["WarningLine"] = { bg = "#362716" }
    -- highlights["InfoLine"]    = { bg = "#182A3A" }
    -- highlights["HintLine"]    = { bg = "#1B251D" }

    highlights["DiagnosticFloatingError"] = { link = "DiagnosticError" }
    highlights["DiagnosticFloatingWarn"]  = { link = "DiagnosticWarn" }
    highlights["DiagnosticFloatingInfo"]  = { link = "DiagnosticInfo" }
    highlights["DiagnosticFloatingHint"]  = { link = "DiagnosticHint" }


    -- -----------------------------------
    -- -------- Editor UI
    -- -----------------------------------
    highlights["FloatBorder"]  = { fg = Fau_vim.colors.cobalt }
    highlights["WinSeparator"] = { fg = Fau_vim.colors.light_blue }


    -- -----------------------------------
    -- -------- Mini Library
    -- -----------------------------------
    highlights["MiniTrailspace"]        = { link = "DiagnosticUnderlineWarn" }
    highlights["MiniIndentscopeSymbol"] = { fg = Fau_vim.colors.yellow }


    -- -----------------------------------
    -- -------- Lspconfig
    -- -----------------------------------
    highlights["LspInfoBorder"] = { fg = Fau_vim.colors.cobalt }
    highlights["LspInlayHint"]  = { fg = colors.dark3 }


    -- -----------------------------------
    -- -------- Bufferline
    -- -----------------------------------
    highlights["BufferLineIndicatorSelected"] = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.dark_purple, bold = true, italic = false }


    -- -----------------------------------
    -- -------- Telescope
    -- -----------------------------------
    highlights["TelescopeBorder"]       = { fg = Fau_vim.colors.cobalt }
    highlights["TelescopePromptTitle"]  = { fg = Fau_vim.colors.cobalt }
    highlights["TelescopePromptPrefix"] = { fg = Fau_vim.colors.purple_blue }
    highlights["TelescopePromptBorder"] = { fg = Fau_vim.colors.cobalt }


    -- -----------------------------------
    -- -------- Nvim-cmp
    -- -----------------------------------
    highlights["CmpItemKindCopilot"]  = { fg = Fau_vim.colors.cobalt }
    highlights["CmpItemKindVariable"] = { fg = Fau_vim.colors.purple }
    highlights["CmpItemKindText"]     = { fg = Fau_vim.colors.light_blue }


    -- -----------------------------------
    -- -------- ChatGPT
    -- -----------------------------------
    highlights["ChatGPTQuestion"] = { fg = "#b4befe", bold = true }


    -- -----------------------------------
    -- -------- Gitcommit
    -- -----------------------------------
    -- TEST: WIP
    highlights["gitcommitFirstLine"] = { link = "Title" }
    highlights["gitcommitSummary"]   = { link = "Title" }
  end,
}


tokyonight.setup(config)
