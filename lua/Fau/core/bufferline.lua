-- =============================================
-- ========== Plugin Loading
-- =============================================
local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then Fau_vim.load_plugin_error("bufferline") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type bufferline.UserConfig
local config = {
  options = {
    mode = "buffers", -- set to "tabs" to only show tabpages instead
    style_preset = bufferline.style_preset.minimal,
    themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default

    numbers = "none", -- values: "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string

    close_command        = Fau_vim.functions.utils.buf_remove, -- can be a string | function, see "Mouse actions"
    right_mouse_command  = Fau_vim.functions.utils.buf_remove, -- can be a string | function, see "Mouse actions"
    left_mouse_command   = "buffer %d",  -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"

    indicator = {
      icon = Fau_vim.icons.ui.Indicator,     -- this should be omitted if indicator style is not 'icon'
      style = "icon", -- values: 'icon' | 'underline' | 'none'
    },

    buffer_close_icon = Fau_vim.icons.ui.Close,
    modified_icon     = Fau_vim.icons.ui.Modified,
    close_icon        = Fau_vim.icons.ui.CloseBold,

    left_trunc_marker  = Fau_vim.icons.ui.ExpandLeft,
    right_trunc_marker = Fau_vim.icons.ui.ExpandRight,

    always_show_bufferline = true,  -- whether or not to show the bufferline if only one tab
    enforce_regular_tabs   = false, -- prevent beyond the tab size and all tabs will be the same length

    -- name_formatter = function(buf)  -- buf contains:
    --   -- name                | str        | the basename of the active file
    --   -- path                | str        | the full path of the active file
    --   -- bufnr (buffer only) | int        | the number of the active buffer
    --   -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
    --   -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
    -- end,

    tab_size              = 10,    -- the tab length
    max_name_length       = 15,
    max_prefix_length     = 12,    -- prefix used when a buffer is de-duplicated
    show_duplicate_prefix = true,  -- whether to show duplicate buffer prefix
    truncate_names        = true,  -- whether or not tab names should be truncated

    ---@diagnostic disable-next-line: unused-local
    custom_filter = function(buf_number, buf_numbers)
      if vim.fn.bufname(buf_number) ~= "" then return true end
      return false
    end,

    diagnostics = "nvim_lsp", -- values: false | "nvim_lsp" | "coc"
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      --- count is an integer representing total count of errors
      --- level is a string "error" | "warning"
      --- this should return a string
      --- Don't get too fancy as this function will be executed a lot
      local show = ""
      for diagnostics, cou in pairs(diagnostics_dict) do
        local icon = (diagnostics == "error" and Fau_vim.icons.diagnostics.Error) or
            (diagnostics == "warning" and Fau_vim.icons.diagnostics.Warning)
        if icon then show = show .. icon .. " " .. cou .. " " end
      end
      return show
    end,

    offsets = {
      {
        filetype   = "NvimTree",
        text       = " Workspace",
        text_align = "center",  -- values: "left" | "center" | "right"
        separator  = true
      }
    },

    color_icons = true,
    get_element_icon = function(element)
      -- element consists of {filetype: string, path: string, extension: string, directory: string}
      -- This can be used to change how bufferline fetches the icon for an element e.g. a buffer or a tab.
      local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
      return icon, hl
    end,

    show_buffer_icons       = true,
    show_buffer_close_icons = true,
    show_close_icon         = true,
    show_tab_indicators     = true,

    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position

    -- can also be a table containing 2 custom separators [focused and unfocused]. eg: { '|', '|' }
    separator_style = { "▎", "▎" }, -- "slant" | "padded_slant" | "thick" | "thin" | "slope" | "padded_slope" | { 'any', 'any' },

    hover = { enabled = true, delay = 50, reveal = { "close" } },
    sort_by = "insert_after_current", -- values: 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b) return buffer_a.modified > buffer_b.modified end
  },

  highlights = {
    -- fill       = { bg = Fau_vim.colors.bufferline_bg },
    background = { bg = Fau_vim.colors.bufferline_bg },

    tab                    = { bg = Fau_vim.colors.bufferline_bg },
    tab_selected           = { bg = Fau_vim.colors.bufferline_bg },
    tab_separator          = { bg = Fau_vim.colors.bufferline_bg },
    tab_separator_selected = { bg = Fau_vim.colors.bufferline_bg },
    tab_close              = { bg = Fau_vim.colors.bufferline_bg },

    buffer_visible   = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.cobalt, bold = false, italic = true },
    buffer_selected  = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.cobalt, bold = false, italic = true },

    hint                     = { bg = Fau_vim.colors.bufferline_bg },
    hint_visible             = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.teal, bold = false, italic = true },
    hint_selected            = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.teal, bold = false, italic = true },
    hint_diagnostic          = { bg = Fau_vim.colors.bufferline_bg },
    hint_diagnostic_visible  = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.teal, bold = false, italic = false },
    hint_diagnostic_selected = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.teal, bold = false, italic = false },

    info                     = { bg = Fau_vim.colors.bufferline_bg },
    info_visible             = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.blue2, bold = false, italic = true },
    info_selected            = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.blue2, bold = false, italic = true },
    info_diagnostic          = { bg = Fau_vim.colors.bufferline_bg },
    info_diagnostic_visible  = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.blue2, bold = false, italic = false },
    info_diagnostic_selected = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.blue2, bold = false, italic = false },

    warning                     = { bg = Fau_vim.colors.bufferline_bg },
    warning_visible             = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.yellow, bold = false, italic = true },
    warning_selected            = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.yellow, bold = false, italic = true },
    warning_diagnostic          = { bg = Fau_vim.colors.bufferline_bg },
    warning_diagnostic_visible  = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.yellow, bold = false, italic = false },
    warning_diagnostic_selected = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.yellow, bold = false, italic = false },

    error                     = { bg = Fau_vim.colors.bufferline_bg },
    error_visible             = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.red1, bold = false, italic = true },
    error_selected            = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.red1, bold = false, italic = true },
    error_diagnostic          = { bg = Fau_vim.colors.bufferline_bg },
    error_diagnostic_visible  = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.red1, bold = false, italic = false },
    error_diagnostic_selected = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.tokyonight.red1, bold = false, italic = false },

    -- the path name in italic
    duplicate          = { bg = Fau_vim.colors.bufferline_bg, bold = true, italic = true },
    duplicate_visible  = { bg = Fau_vim.colors.bufferline_bg, bold = true, italic = true },
    duplicate_selected = { bg = Fau_vim.colors.bufferline_bg, bold = false, italic = true },

    modified          = { bg = Fau_vim.colors.bufferline_bg },
    modified_visible  = { bg = Fau_vim.colors.bufferline_bg },
    modified_selected = { bg = Fau_vim.colors.bufferline_bg },

    close_button          = { bg = Fau_vim.colors.bufferline_bg },
    close_button_visible  = { bg = Fau_vim.colors.bufferline_bg },
    close_button_selected = { bg = Fau_vim.colors.bufferline_bg },

    separator          = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.cyan_gray },
    separator_visible  = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.cyan_gray },
    separator_selected = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.cyan_gray },

    indicator_visible = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.dark_purple, bold = true, italic = false },
    -- indicator_selected = { },  -- Controlled by tokyonight,

    pick          = { bg = Fau_vim.colors.bufferline_bg },
    pick_visible  = { bg = Fau_vim.colors.bufferline_bg },
    pick_selected = { bg = Fau_vim.colors.bufferline_bg },

    offset_separator = { bg = Fau_vim.colors.bufferline_bg },
    trunc_marker     = { bg = Fau_vim.colors.bufferline_bg }
  }
}


bufferline.setup(config)
