-- =============================================
-- ========== Plugin Configurations
-- =============================================
local lualine = require("lualine")
local component = require("Fau.configs.editor.lualine.components")

local config = {
  options = {
    icons_enabled = true,
    theme = "auto",

    component_separators = { left = Fau_vim.icons.ui.DividerLeft, right = Fau_vim.icons.ui.DividerRight },
    section_separators   = { left = Fau_vim.icons.ui.BoldDividerLeft, right = Fau_vim.icons.ui.BoldDividerRight },

    disabled_filetypes = {
      statusline = { "alpha", "yazi" },
      winbar     = {},
    },

    -- NOTE: If set `globalstatus = true`, the ft in `ignore_focus` might hide the statusline.
    ignore_focus = { "help", "trouble", "NvimTree", "aerial", "DiffviewFiles" },

    always_divide_middle = true,
    globalstatus = true,

    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
  },
  sections = {
    lualine_a = { component.mode, component.lazy },
    lualine_b = { component.branch, component.diff },
    lualine_c = { component.diagnostics, component.python_env },
    lualine_x = { component.lsp, component.treesitter },
    lualine_y = { component.filetype, component.indent, component.encoding, component.fileformat },
    lualine_z = { component.progress, component.location, component.selectioncount },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { component.filetype },
    lualine_x = { component.location },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

lualine.setup(config)
