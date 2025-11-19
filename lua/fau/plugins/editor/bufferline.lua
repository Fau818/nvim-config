---@type LazySpec
return {
  -- DESC: A snazzy bufferline for Neovim.
  ---@module "bufferline"
  "akinsho/bufferline.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "UIEnter",

  config = function()
    -- ==================== Configuration ====================
    local bufferline = require("bufferline")

    ---@type bufferline.UserConfig
    local config = {
      options = {
        mode = "buffers",  -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.default,
        themable = true,  -- allows highlight groups to be overriden i.e. sets highlights as default
        ---@type "none"|"ordinal"|"buffer_id"|"both"|function({ ordinal, id, lower, raise }): string
        numbers = "none",

        close_command        = fvim.utils.buf_remove,  -- can be a string | function, see "Mouse actions"
        right_mouse_command  = fvim.utils.buf_remove,  -- can be a string | function, see "Mouse actions"
        left_mouse_command   = "buffer %d",  -- can be a string | function, see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"

        indicator = {
          icon = fvim.icons.ui.Indicator,  -- this should be omitted if indicator style is not 'icon'
          style = "none",  ---@type "icon"|"underline"|"none"
        },

        buffer_close_icon  = fvim.icons.ui.Close,
        modified_icon      = fvim.icons.ui.Modified,
        close_icon         = fvim.icons.ui.CloseBold,
        left_trunc_marker  = fvim.icons.ui.ExpandLeft,
        right_trunc_marker = fvim.icons.ui.ExpandRight,

        always_show_bufferline = true,   -- whether or not to show the bufferline if only one tab
        auto_toggle_bufferline = true,
        enforce_regular_tabs   = false,  -- prevent beyond the tab size and all tabs will be the same length

        -- name_formatter = nil,

        tab_size          = 10,
        max_name_length   = 15,
        max_prefix_length = 12,    -- prefix used when a buffer is de-duplicated
        truncate_names    = true,  -- whether or not tab names should be truncated

        custom_filter = function(bufnr, buf_numbers)
          ---@diagnostic disable-next-line: param-type-mismatch
          local buf_name = vim.fn.bufname(bufnr)
          if buf_name == "" or buf_name == "copilot-chat" then return false end
          return true
        end,

        diagnostics = "nvim_lsp",  ---@type false|"nvim_lsp"|"coc"
        diagnostics_update_in_insert = false,
        diagnostics_update_on_event = true,  -- use nvim's diagnostic handler
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        ---@diagnostic disable-next-line: unused-local
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local show = ""
          for diagnostics, cou in pairs(diagnostics_dict) do
            local icon = (diagnostics == "error" and fvim.icons.diagnostics.Error) or
            (diagnostics == "warning" and fvim.icons.diagnostics.Warn)
            if icon then show = ("%s %d "):format(icon, cou) end
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
        get_element_icon = nil,  -- Use default.

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

        pick = nil,  -- Use default.
      },

      highlights = {
        -- fill       = { bg = fvim.colors.bufferline_bg },
        background = { bg = fvim.colors.bufferline_bg },

        tab                    = { bg = fvim.colors.bufferline_bg },
        tab_selected           = { bg = fvim.colors.bufferline_bg },
        tab_separator          = { bg = fvim.colors.bufferline_bg },
        tab_separator_selected = { bg = fvim.colors.bufferline_bg },
        tab_close              = { bg = fvim.colors.bufferline_bg },

        buffer_visible  = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cobalt, bold = false, italic = true },
        buffer_selected = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cobalt, bold = false, italic = true },

        hint                     = { bg = fvim.colors.bufferline_bg },
        hint_visible             = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.light_cyan, bold = false, italic = true },
        hint_selected            = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.light_cyan, bold = false, italic = true },
        hint_diagnostic          = { bg = fvim.colors.bufferline_bg },
        hint_diagnostic_visible  = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.light_cyan, bold = false, italic = false },
        hint_diagnostic_selected = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.light_cyan, bold = false, italic = false },

        info                     = { bg = fvim.colors.bufferline_bg },
        info_visible             = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cyan_blue, bold = false, italic = true },
        info_selected            = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cyan_blue, bold = false, italic = true },
        info_diagnostic          = { bg = fvim.colors.bufferline_bg },
        info_diagnostic_visible  = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cyan_blue, bold = false, italic = false },
        info_diagnostic_selected = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cyan_blue, bold = false, italic = false },

        warning                     = { bg = fvim.colors.bufferline_bg },
        warning_visible             = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.yellow_orange, bold = false, italic = true },
        warning_selected            = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.yellow_orange, bold = false, italic = true },
        warning_diagnostic          = { bg = fvim.colors.bufferline_bg },
        warning_diagnostic_visible  = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.yellow_orange, bold = false, italic = false },
        warning_diagnostic_selected = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.yellow_orange, bold = false, italic = false },

        error                     = { bg = fvim.colors.bufferline_bg },
        error_visible             = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.red1, bold = false, italic = true },
        error_selected            = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.red1, bold = false, italic = true },
        error_diagnostic          = { bg = fvim.colors.bufferline_bg },
        error_diagnostic_visible  = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.red1, bold = false, italic = false },
        error_diagnostic_selected = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.red1, bold = false, italic = false },

        -- the path name in italic
        duplicate          = { bg = fvim.colors.bufferline_bg, bold = true, italic = true },
        duplicate_visible  = { bg = fvim.colors.bufferline_bg, bold = true, italic = true },
        duplicate_selected = { bg = fvim.colors.bufferline_bg, bold = false, italic = true },

        modified          = { bg = fvim.colors.bufferline_bg },
        modified_visible  = { bg = fvim.colors.bufferline_bg },
        modified_selected = { bg = fvim.colors.bufferline_bg },

        close_button          = { bg = fvim.colors.bufferline_bg },
        close_button_visible  = { bg = fvim.colors.bufferline_bg },
        close_button_selected = { bg = fvim.colors.bufferline_bg },

        separator          = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cyan_gray },
        separator_visible  = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cyan_gray },
        separator_selected = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.cyan_gray },

        indicator_visible = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.dark_purple, bold = true, italic = false },
        -- BUG: Not worked, please set the indicator style in tokyonight theme.
        -- \    highlights["BufferLineIndicatorSelected"] = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.dark_purple, bold = true, italic = false }
        -- HACK: Now we don't use the indicator, so never mind. Oct 13, 2025
        indicator_selected = { bg = fvim.colors.bufferline_bg, fg = fvim.colors.dark_purple, bold = true, italic = false },

        pick          = { bg = fvim.colors.bufferline_bg },
        pick_visible  = { bg = fvim.colors.bufferline_bg },
        pick_selected = { bg = fvim.colors.bufferline_bg },

        offset_separator = { bg = fvim.colors.bufferline_bg },
        trunc_marker     = { bg = fvim.colors.bufferline_bg },
      },
    }


    bufferline.setup(config)


    -- ==================== Keymaps ====================
    -- Cycle Buffers
    vim.keymap.set("n", "<A-h>", "<CMD>BufferLineCyclePrev<CR>", { desc = "Buffer: Focus Shift Prev" })
    vim.keymap.set("n", "<A-l>", "<CMD>BufferLineCycleNext<CR>", { desc = "Buffer: Focus Shift Next" })

    -- Swap Buffers
    vim.keymap.set("n", "<A-left>",  "<CMD>BufferLineMovePrev<CR>", { desc = "Buffer: Move Buffer Prev" })
    vim.keymap.set("n", "<A-right>", "<CMD>BufferLineMoveNext<CR>", { desc = "Buffer: Move Buffer Next" })

    -- By Meta Key
    vim.keymap.set("n", "<A-1>", "<CMD>BufferLineGoToBuffer 1<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-2>", "<CMD>BufferLineGoToBuffer 2<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-3>", "<CMD>BufferLineGoToBuffer 3<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-4>", "<CMD>BufferLineGoToBuffer 4<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-5>", "<CMD>BufferLineGoToBuffer 5<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-6>", "<CMD>BufferLineGoToBuffer 6<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-7>", "<CMD>BufferLineGoToBuffer 7<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-8>", "<CMD>BufferLineGoToBuffer 8<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-9>", "<CMD>BufferLineGoToBuffer 9<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<A-0>", "<CMD>BufferLineGoToBuffer -1<CR>", { desc = "Buffer: Focus on Last" })

    -- By Leader Key
    vim.keymap.set("n", "<leader>1", "<CMD>BufferLineGoToBuffer 1<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>2", "<CMD>BufferLineGoToBuffer 2<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>3", "<CMD>BufferLineGoToBuffer 3<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>4", "<CMD>BufferLineGoToBuffer 4<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>5", "<CMD>BufferLineGoToBuffer 5<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>6", "<CMD>BufferLineGoToBuffer 6<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>7", "<CMD>BufferLineGoToBuffer 7<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>8", "<CMD>BufferLineGoToBuffer 8<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>9", "<CMD>BufferLineGoToBuffer 9<CR>",  { desc = "which_key_ignore" })
    vim.keymap.set("n", "<leader>0", "<CMD>BufferLineGoToBuffer -1<CR>", { desc = "Buffer: Focus on Last" })

    -- TEST: Extra (from lunarvim)
    vim.keymap.set("n", "<leader>bj", "<CMD>BufferLinePick<CR>",      { desc = "BufferLine: Pick Buffer" })
    vim.keymap.set("n", "<leader>bt", "<CMD>BufferLineTogglePin<CR>", { desc = "BufferLine: Toggle Pin" })
  end,
}
