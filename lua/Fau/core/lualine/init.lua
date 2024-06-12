-- =============================================
-- ========== Plugin Loading
-- =============================================
local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then Fau_vim.load_plugin_error("lualine") return end



-- =============================================
-- ========== Configuration
-- =============================================
local component = require("Fau.core.lualine.component")
local config = {
  options = {
    icons_enabled = true,
    theme = "auto",

    component_separators = { left = Fau_vim.icons.ui.DividerLeft,     right = Fau_vim.icons.ui.DividerRight },
    section_separators   = { left = Fau_vim.icons.ui.BoldDividerLeft, right = Fau_vim.icons.ui.BoldDividerRight },

    disabled_filetypes = {  -- Filetypes to disable lualine for.
      statusline = { "alpha" }, -- only ignores the ft for statusline.
      winbar     = { }, -- only ignores the ft for winbar.
    },

    ignore_focus = {  -- show as inactive
      "help", "trouble", "NvimTree", "aerial", "DiffviewFiles", "yazi",
    },

    always_divide_middle = true,
    globalstatus = true,

    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 }
  },
  sections = {
    lualine_a = { component.mode, component.lazy },
    lualine_b = { component.branch, component.diff },
    lualine_c = { component.diagnostics, component.python_env },
    lualine_x = { component.lsp, component.treesitter },
    lualine_y = { component.filetype, component.indent, component.encoding, component.fileformat },
    lualine_z = { component.progress, component.location, component.selectioncount }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { component.filetype },
    lualine_x = { component.location },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


lualine.setup(config)



-- =============================================
-- ========== Highlight Group
-- =============================================
-- vim.api.nvim_command("highlight lualine_c_normal guibg=none")
-- vim.api.nvim_command("highlight lualine_c_inactive guibg=none")
