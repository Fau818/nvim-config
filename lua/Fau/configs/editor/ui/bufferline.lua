-- =============================================
-- ========== Plugin Configurations
-- =============================================
local bufferline = require("bufferline")

---@type bufferline.UserConfig
local config = {
  options = {
    mode = "buffers",  -- set to "tabs" to only show tabpages instead
    style_preset = bufferline.style_preset.default,
    themable = true,  -- allows highlight groups to be overriden i.e. sets highlights as default
    ---@type "none"|"ordinal"|"buffer_id"|"both"|function({ ordinal, id, lower, raise }): string
    numbers = "none",

    close_command        = Fau_vim.functions.utils.buf_remove,  -- can be a string | function, see "Mouse actions"
    right_mouse_command  = Fau_vim.functions.utils.buf_remove,  -- can be a string | function, see "Mouse actions"
    left_mouse_command   = "buffer %d",  -- can be a string | function, see "Mouse actions"
    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"

    indicator = {
      icon = Fau_vim.icons.ui.Indicator,  -- this should be omitted if indicator style is not 'icon'
      style = "none",  ---@type "icon"|"underline"|"none"
    },

    buffer_close_icon  = Fau_vim.icons.ui.Close,
    modified_icon      = Fau_vim.icons.ui.Modified,
    close_icon         = Fau_vim.icons.ui.CloseBold,
    left_trunc_marker  = Fau_vim.icons.ui.ExpandLeft,
    right_trunc_marker = Fau_vim.icons.ui.ExpandRight,

    always_show_bufferline = true,   -- whether or not to show the bufferline if only one tab
    auto_toggle_bufferline = true,
    enforce_regular_tabs   = false,  -- prevent beyond the tab size and all tabs will be the same length

    -- name_formatter = nil,

    tab_size          = 10,
    max_name_length   = 15,
    max_prefix_length = 12,    -- prefix used when a buffer is de-duplicated
    truncate_names    = true,  -- whether or not tab names should be truncated

    ---@diagnostic disable-next-line: unused-local
    custom_filter = function(buf_number, buf_numbers)
      ---@diagnostic disable-next-line: param-type-mismatch
      if vim.fn.bufname(buf_number) == "" or vim.bo[buf_number].filetype == "checkhealth" then return false end
      return true
    end,

    diagnostics = "nvim_lsp",  ---@type false|"nvim_lsp"|"coc"
    diagnostics_update_in_insert = false,
    -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local show = ""
      for diagnostics, cou in pairs(diagnostics_dict) do
        local icon = (diagnostics == "error" and Fau_vim.icons.diagnostics.Error) or (diagnostics == "warning" and Fau_vim.icons.diagnostics.Warning)
        if icon then show = ("%s%s %d "):format(show, icon, cou) end
      end
      return show
    end,

    offsets = {
      {
        filetype   = "NvimTree",
        text       = " Workspace",
        text_align = "center",  ---@type "left"|"center"|"right"
        separator  = true,
      },
    },

    color_icons = true,
    get_element_icon = nil,  -- Use default, provided by nvim-web-devicons.

    show_buffer_icons        = true,
    show_buffer_close_icons  = true,
    show_close_icon          = true,
    show_tab_indicators      = true,
    show_duplicate_prefix    = true,  -- whether to show duplicate buffer prefix
    duplicates_across_groups = true,  -- whether to consider duplicate paths in different groups as duplicates

    persist_buffer_sort = true,  -- whether or not custom sorted buffers should persist
    move_wraps_at_ends = false,  -- whether or not the move command "wraps" at the first or last position

    -- can also be a table containing 2 custom separators [focused and unfocused]. eg: { '|', '|' }
    ---@type "slant"|"padded_slant"|"thick"|"thin"|"slope"|"padded_slope"|{str1:string, str2:string}
    separator_style = { "▎", "▎" },

    hover = { enabled = true, delay = 100, reveal = { "close" } },
    ---@type "insert_at_end"|"insert_after_current"|"id"|"extension"|"relative_directory"|"directory"|"tabs"|function(buffer_a: Buffer, buffer_b: Buffer): boolean
    sort_by = "insert_after_current",

    pick = { alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890" },
  },

  highlights = {
    -- fill       = { bg = Fau_vim.colors.bufferline_bg },
    background = { bg = Fau_vim.colors.bufferline_bg },

    tab                    = { bg = Fau_vim.colors.bufferline_bg },
    tab_selected           = { bg = Fau_vim.colors.bufferline_bg },
    tab_separator          = { bg = Fau_vim.colors.bufferline_bg },
    tab_separator_selected = { bg = Fau_vim.colors.bufferline_bg },
    tab_close              = { bg = Fau_vim.colors.bufferline_bg },

    buffer_visible  = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.cobalt, bold = false, italic = true },
    buffer_selected = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.cobalt, bold = false, italic = true },

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
    -- BUG: Not worked, please set the indicator style in tokyonight theme.
    -- \    highlights["BufferLineIndicatorSelected"] = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.dark_purple, bold = true, italic = false }
    indicator_selected = { bg = Fau_vim.colors.bufferline_bg, fg = Fau_vim.colors.dark_purple, bold = true, italic = false },

    pick          = { bg = Fau_vim.colors.bufferline_bg },
    pick_visible  = { bg = Fau_vim.colors.bufferline_bg },
    pick_selected = { bg = Fau_vim.colors.bufferline_bg },

    offset_separator = { bg = Fau_vim.colors.bufferline_bg },
    trunc_marker     = { bg = Fau_vim.colors.bufferline_bg },
  },
}


bufferline.setup(config)



-- =============================================
-- ========== Keymaps
-- =============================================
local keys = {
  -- Cycle Buffers
  { "<A-h>", "<CMD>BufferLineCyclePrev<CR>", desc = "Buffer: Focus Shift Prev" },
  { "<A-l>", "<CMD>BufferLineCycleNext<CR>", desc = "Buffer: Focus Shift Next" },

  -- Swap Buffers
  { "<A-left>",  "<CMD>BufferLineMovePrev<CR>", desc = "Buffer: Move Buffer Prev" },
  { "<A-right>", "<CMD>BufferLineMoveNext<CR>", desc = "Buffer: Move Buffer Next" },

  -- By Meta Key
  { "<A-1>", "<CMD>BufferLineGoToBuffer 1<CR>",  desc = "which_key_ignore" },
  { "<A-2>", "<CMD>BufferLineGoToBuffer 2<CR>",  desc = "which_key_ignore" },
  { "<A-3>", "<CMD>BufferLineGoToBuffer 3<CR>",  desc = "which_key_ignore" },
  { "<A-4>", "<CMD>BufferLineGoToBuffer 4<CR>",  desc = "which_key_ignore" },
  { "<A-5>", "<CMD>BufferLineGoToBuffer 5<CR>",  desc = "which_key_ignore" },
  { "<A-6>", "<CMD>BufferLineGoToBuffer 6<CR>",  desc = "which_key_ignore" },
  { "<A-7>", "<CMD>BufferLineGoToBuffer 7<CR>",  desc = "which_key_ignore" },
  { "<A-8>", "<CMD>BufferLineGoToBuffer 8<CR>",  desc = "which_key_ignore" },
  { "<A-9>", "<CMD>BufferLineGoToBuffer 9<CR>",  desc = "which_key_ignore" },
  { "<A-0>", "<CMD>BufferLineGoToBuffer -1<CR>", desc = "Buffer: Focus on Last" },

  -- By Leader Key
  { "<LEADER>1", "<CMD>BufferLineGoToBuffer 1<CR>",  desc = "which_key_ignore" },
  { "<LEADER>2", "<CMD>BufferLineGoToBuffer 2<CR>",  desc = "which_key_ignore" },
  { "<LEADER>3", "<CMD>BufferLineGoToBuffer 3<CR>",  desc = "which_key_ignore" },
  { "<LEADER>4", "<CMD>BufferLineGoToBuffer 4<CR>",  desc = "which_key_ignore" },
  { "<LEADER>5", "<CMD>BufferLineGoToBuffer 5<CR>",  desc = "which_key_ignore" },
  { "<LEADER>6", "<CMD>BufferLineGoToBuffer 6<CR>",  desc = "which_key_ignore" },
  { "<LEADER>7", "<CMD>BufferLineGoToBuffer 7<CR>",  desc = "which_key_ignore" },
  { "<LEADER>8", "<CMD>BufferLineGoToBuffer 8<CR>",  desc = "which_key_ignore" },
  { "<LEADER>9", "<CMD>BufferLineGoToBuffer 9<CR>",  desc = "which_key_ignore" },
  { "<LEADER>0", "<CMD>BufferLineGoToBuffer -1<CR>", desc = "Buffer: Focus on Last" },

  -- -------- TEST (from lunarvim)
  { "<LEADER>bj", "<CMD>BufferLinePick<CR>",      desc = "BufferLine: Pick Buffer" },
  { "<LEADER>bt", "<CMD>BufferLineTogglePin<CR>", desc = "BufferLine: Toggle Pin" },
}

for _, key in pairs(keys) do vim.keymap.set("n", key[1], key[2], { silent = true, desc = key.desc }) end
