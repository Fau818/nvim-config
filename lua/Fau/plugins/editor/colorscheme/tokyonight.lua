-- =============================================
-- ========== Plugin Configurations
-- =============================================
local tokyonight = require("tokyonight")
Fau_vim.colors.tokyonight = require("tokyonight.colors.moon")


local function comment_style()
  local term_type = os.getenv("TERM")
  if term_type == "xterm-kitty" or os.getenv("KITTY_PID") then return { italic = true, bold = true } end
  return { italic = true }
end

---@module "tokyonight"
---@type tokyonight.Config
local config = {
  style           = "moon",  ---@type "moon" | "storm" | "night"
  light_style     = "day",
  transparent     = true,
  terminal_colors = true,

  styles = {
    comments  = comment_style(),
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

  ---You can override specific color groups to use other groups or a hex color
  ---function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors)
    colors.comment        = Fau_vim.colors.gray
    colors.terminal_black = Fau_vim.colors.gray
  end,

  ---You can override specific highlights to use other groups or a hex color
  ---function will be called with a Highlights and ColorScheme table
  ---@param highlights tokyonight.Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors)
    -- ==================== General ====================
    -- ---------- Basic
    highlights["Bold"]       = { bold = true }
    highlights["Italic"]     = { italic = true }
    highlights["MatchParen"] = { fg = Fau_vim.colors.yellow, bold = true }
    highlights["Todo"]       = { bg = colors.bg_highlight, nocombine = true }

    -- ---------- Type
    highlights["Statement"] = { fg = Fau_vim.colors.tokyonight.magenta, italic = true }
    highlights["Boolean"]   = { fg = Fau_vim.colors.tokyonight.orange, italic = true, force = true }
    highlights["Number"]    = { fg = Fau_vim.colors.light_blue }

    -- ---------- Editor UI
    highlights["FloatBorder"]  = { fg = Fau_vim.colors.cobalt }
    highlights["WinSeparator"] = { fg = Fau_vim.colors.light_blue }

    -- ---------- TodoSign
    -- SEE: `@comment` will be linked to `Comment` for trouble and telescope previewer.
    highlights["@comment"] = { bold = true, italic = true }
    highlights["TodoSign"] = { fg = Fau_vim.colors.dark_green, bold = true, italic = true }
    highlights["InfoSign"] = { fg = Fau_vim.colors.tokyonight.blue2, bold = true, italic = true }
    highlights["FixSign"]  = { fg = Fau_vim.colors.tokyonight.red1, bold = true, italic = true }


    -- ==================== Syntax ====================
    -- ---------- General
    highlights["@function.builtin"] = { fg = Fau_vim.colors.purple_blue, italic = true }
    highlights["@keyword.function"] = { fg = Fau_vim.colors.tokyonight.magenta, italic = true }
    highlights["@string.documentation"] = { fg = Fau_vim.colors.cyan_gray }
    highlights["@lsp.type.macro"] = { italic = true }

    -- ---------- Gitcommit
    highlights["@keyword.gitcommit"] = { fg = Fau_vim.colors.tokyonight.purple, italic = true, nocombine = true }
    highlights["@variable.parameter.gitcommit"] = { fg = Fau_vim.colors.tokyonight.yellow, italic = true, bold = true, nocombine = true }
    highlights["@punctuation.delimiter.gitcommit"] = { fg = Fau_vim.colors.tokyonight.cyan, nocombine = true }
    highlights["@markup.heading.gitcommit"] = { fg = Fau_vim.colors.tokyonight.blue, bold = false, italic = false, nocombine = true }
    -- highlights["gitcommitSummary"] = { fg = Fau_vim.colors.tokyonight.blue, bold = false, italic = false, nocombine = true }


    -- ==================== Diagnostics ====================
    highlights["ErrorLine"]   = { bg = Fau_vim.colors.diagnostic.error }
    highlights["WarningLine"] = { bg = Fau_vim.colors.diagnostic.warn }
    -- highlights["InfoLine"]    = { bg = Fau_vim.colors.diagnostic.info }
    -- highlights["HintLine"]    = { bg = Fau_vim.colors.diagnostic.hint }


    -- ==================== Plugins ====================
    -- ---------- Blink Cmp
    highlights["BlinkCmpLabelMatch"] = { bold = true }

    -- ---------- Bufferline
    highlights["BufferLineIndicatorSelected"] = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.dark_purple, bold = true }

    -- ---------- ChatGPT
    -- highlights["ChatGPTQuestion"] = { fg = "#b4befe", bold = true }

    -- ---------- Lazy
    highlights["LazyReasonKeys"] = { fg = Fau_vim.colors.tokyonight.magenta }
    highlights["LazyReasonCmd"]  = { fg = Fau_vim.colors.tokyonight.blue5, nocombine = true }

    -- ---------- Lspconfig
    highlights["LspInfoBorder"] = { fg = Fau_vim.colors.cobalt }
    highlights["LspInlayHint"]  = { fg = colors.dark3 }

    -- ---------- Mini Library
    highlights["MiniTrailspace"]        = { link = "DiagnosticUnderlineWarn" }
    highlights["MiniIndentscopeSymbol"] = { fg = Fau_vim.colors.cobalt }

    -- ---------- Nvim-tree
    highlights["NvimTreeWinSeparator"] = { link = "WinSeparator" }
    highlights["NvimTreeSpecialFile"] = { fg = Fau_vim.colors.tokyonight.purple }
    highlights["NvimTreeDiagnosticErrorFileHL"] = { link = "DiagnosticError" }
    highlights["NvimTreeDiagnosticWarnFileHL"]  = { link = "DiagnosticWarn" }

    -- ---------- Snacks
    highlights["SnacksIndentScope"] = { fg = Fau_vim.colors.cobalt }

    -- ---------- Telescope
    highlights["TelescopeBorder"]         = { fg = Fau_vim.colors.cobalt }
    highlights["TelescopePromptTitle"]    = { fg = Fau_vim.colors.cobalt }
    highlights["TelescopePromptPrefix"]   = { fg = Fau_vim.colors.purple_blue }
    highlights["TelescopePromptBorder"]   = { fg = Fau_vim.colors.cobalt }
    highlights["TelescopeSelectionCaret"] = { fg = Fau_vim.colors.cobalt, bg = "#2D3F76" }

    highlights["@module.python"] = { fg = Fau_vim.colors.tokyonight.fg }
  end,
}


tokyonight.setup(config)
