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
    theme = "auto", -- lualine theme

    component_separators = { left = Fau_vim.icons.ui.DividerLeft,     right = Fau_vim.icons.ui.DividerRight },
    section_separators   = { left = Fau_vim.icons.ui.BoldDividerLeft, right = Fau_vim.icons.ui.BoldDividerRight },

    disabled_filetypes = {  -- Filetypes to disable lualine for.
      statusline = { "alpha" }, -- only ignores the ft for statusline.
      winbar     = Fau_vim.disabled_filetypes, -- only ignores the ft for winbar.
    },

    ignore_focus = {
      "help", "Trouble", "NvimTree", "aerial", "DiffviewFiles",
      "dap-repl", "dapui_watches", "dapui_stacks", "dapui_breakpoints", "dapui_scopes", "dapui_console",
    }, -- show as inactive

    always_divide_middle = true,
    globalstatus = true,

    refresh = {          -- sets how often lualine should refreash it's contents (in ms)
      statusline = 1000, -- The refresh option sets minimum time that lualine tries
      tabline = 1000,    -- to maintain between refresh. It's not guarantied if situation
      winbar = 1000      -- arises that lualine needs to refresh itself before this time
    }
  },
  sections = {
    lualine_a = { component.mode, component.lazy },
    lualine_b = { component.branch, component.diff },
    lualine_c = { component.diagnostics, component.python_env },
    lualine_x = { component.lsp, component.treesitter },
    lualine_y = { component.filetype, component.indent, component.encoding, component.fileformat },
    lualine_z = { component.progress, component.location }
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
