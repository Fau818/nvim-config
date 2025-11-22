---@type LazySpec
return {
  -- DESC: A snazzy colorscheme that can be customized.
  ---@module "tokyonight"
  "folke/tokyonight.nvim",
  priority = 1000,

  ---@type tokyonight.Config
  opts = {
    style           = "moon",  ---@type "moon" | "storm" | "night"
    light_style     = "day",
    transparent     = true,
    terminal_colors = true,

    styles = {
      comments  = fvim.kitty.is_enabled and { italic = true, bold = true } or { italic = true },
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
      colors.comment        = fvim.colors.gray
      colors.terminal_black = fvim.colors.gray
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
      highlights["MatchParen"] = { fg = fvim.colors.yellow, bold = true }
      highlights["Todo"]       = { bg = colors.bg_highlight, nocombine = true }

      -- ---------- Type
      highlights["Statement"] = { fg = colors.magenta, italic = true }
      highlights["Boolean"]   = { fg = colors.orange, italic = true, force = true }
      highlights["Number"]    = { fg = fvim.colors.light_blue }

      -- ---------- Editor UI
      highlights["FloatBorder"]  = { fg = fvim.colors.cobalt }
      highlights["WinSeparator"] = { fg = fvim.colors.light_blue }

      -- ---------- TodoTag
      highlights["TodoTag"] = { fg = fvim.colors.dark_green, bold = true, italic = true }
      highlights["InfoTag"] = { fg = colors.blue2, bold = true, italic = true }
      highlights["FixTag"]  = { fg = colors.red1, bold = true, italic = true }


      -- ==================== Syntax ====================
      -- ---------- General
      highlights["@markup.italic"] = { bold = true, italic = true }
      highlights["@function.builtin"] = { fg = fvim.colors.purple_blue, italic = true }
      highlights["@keyword.function"] = { fg = colors.magenta, italic = true }
      highlights["@string.documentation"] = { fg = fvim.colors.cyan_gray }

      -- ---------- Cpp
      highlights["cBlock"]     = { fg = colors.blue5, italic = true, bold = true }
      highlights["cPreCondit"] = { fg = colors.blue5, italic = true, bold = true }

      highlights["@keyword.import.cpp"]           = { fg = colors.dark5, italic = false, bold = false }
      highlights["@keyword.directive.define.cpp"] = { fg = colors.dark5, italic = false, bold = false }
      highlights["@keyword.directive.cpp"]        = { fg = colors.dark5, italic = true, bold  = true }

      highlights["@lsp.typemod.macro.declaration.cpp"] = { fg = colors.yellow, italic = true, bold = false }
      highlights["@lsp.type.macro.cpp"]                = { fg = colors.yellow, italic = true, bold = false }

      -- ---------- Gitcommit
      highlights["@keyword.gitcommit"] = { fg = colors.purple, italic = true, nocombine = true }
      highlights["@variable.parameter.gitcommit"] = { fg = colors.yellow, italic = true, bold = true, nocombine = true }
      highlights["@punctuation.delimiter.gitcommit"] = { fg = colors.cyan, nocombine = true }
      highlights["@markup.heading.gitcommit"] = { fg = colors.blue, bold = false, italic = false, nocombine = true }
      -- highlights["gitcommitSummary"] = { fg = fvim.colors.tokyonight.blue, bold = false, italic = false, nocombine = true }


      -- ==================== Diagnostics ====================
      highlights["ErrorLine"] = { bg = fvim.colors.diagnostic.error }
      -- highlights["WarnLine"]  = { bg = fvim.colors.diagnostic.warn }
      -- highlights["InfoLine"]  = { bg = fvim.colors.diagnostic.info }
      -- highlights["HintLine"]  = { bg = fvim.colors.diagnostic.hint }


      -- ==================== Plugins ====================
      -- ---------- Blink Cmp
      highlights["BlinkCmpLabelMatch"] = { bold = true, nocombine = true }

      -- ---------- Bufferline
      highlights["BufferLineIndicatorSelected"] = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.dark_purple, bold = true }

      -- ---------- ChatGPT
      -- highlights["ChatGPTQuestion"] = { fg = "#b4befe", bold = true }

      -- ---------- Lazy
      highlights["LazyReasonKeys"] = { fg = colors.magenta }
      highlights["LazyReasonCmd"]  = { fg = colors.blue5, nocombine = true }

      -- ---------- Lspconfig
      highlights["LspInfoBorder"] = { fg = fvim.colors.cobalt }
      highlights["LspInlayHint"]  = { fg = colors.dark3 }

      -- ---------- Mini Library
      highlights["MiniTrailspace"]        = { link = "DiagnosticUnderlineWarn" }
      highlights["MiniIndentscopeSymbol"] = { fg = fvim.colors.cobalt }

      -- ---------- Nvim-tree
      highlights["NvimTreeWinSeparator"] = { link = "WinSeparator" }
      highlights["NvimTreeSpecialFile"] = { fg = colors.purple }
      highlights["NvimTreeDiagnosticErrorFileHL"] = { link = "DiagnosticError" }
      highlights["NvimTreeDiagnosticWarnFileHL"]  = { link = "DiagnosticWarn" }

      -- ---------- Snacks
      highlights["SnacksIndentScope"] = { fg = fvim.colors.cobalt }

      -- ---------- Telescope
      highlights["TelescopeBorder"]         = { fg = fvim.colors.cobalt }
      highlights["TelescopePromptTitle"]    = { fg = fvim.colors.cobalt }
      highlights["TelescopePromptPrefix"]   = { fg = fvim.colors.purple_blue }
      highlights["TelescopePromptBorder"]   = { fg = fvim.colors.cobalt }
      highlights["TelescopeSelectionCaret"] = { fg = fvim.colors.cobalt, bg = "#2D3F76" }

      highlights["@module.python"] = { fg = colors.fg }
    end,
  },

  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.api.nvim_command([[colorscheme tokyonight]])
    fvim.colors.tokyonight = require("tokyonight.colors.moon")
  end,
}
