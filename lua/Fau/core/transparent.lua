-- WARNING: This module is deprecated.

-- =============================================
-- ========== Plugin Loading
-- =============================================
local transparent_ok, transparent = pcall(require, "transparent")
if not transparent_ok then Fau_vim.load_plugin_error("transparent") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  enable = true,
  extra_groups = {
    "MsgArea",
    "VertSplit",

    "BufferLineFill",

    "BufferLineBuffer",
    "BufferLineBufferSelected",
    "BufferLineBufferVisible",

    "BufferLineCloseButtonSelected",

    "BufferLineDevIconLua",
    "BufferLineDevIconLuaSelected",
    "BufferLineDevIconLuaInactive",

    "BufferLineModified",
    "BufferLineModifiedVisible",
    "BufferLineModifiedSelected",

    "BufferLineSeparator",

    "NvimTreeNormal",
    "NvimTreeWinSeparator",

    "NormalFloat",
    "FloatBorder",

    "LspFloatWinNormal",

    "TelescopeNormal",
    "TelescopeBorder",

    "WhichKeyFloat",
  },
  exclude = {  -- the plugin will disable the following by default.
    -- "Normal",
    -- "NormalNC",
    "Comment",
    "Constant",
    "Special",
    "Identifier",
    "Statement",
    "PreProc",
    "Type",
    "Underlined",
    "Todo",
    "String",
    "Function",
    "Conditional",
    "Repeat",
    "Operator",
    "Structure",
    "LineNr",
    "NonText",
    -- "SignColumn",
    "CursorLineNr",
  },

  ---@type boolean don't clear a group that links to another group
  ignore_linked_group = true,
}


transparent.setup(config)
