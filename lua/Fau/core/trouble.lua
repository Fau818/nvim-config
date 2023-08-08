-- =============================================
-- ========== Plugin Loading
-- =============================================
local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then Fau_vim.load_plugin_error("trouble") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type TroubleOptions
local config = {
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10,         -- height of the trouble list when position is top or bottom
  width = 50,          -- width of the list when position is left or right
  icons = true,        -- use devicons for filenames

  mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  severity = nil,    -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT

  fold_open = "",   -- icon used for open folds
  fold_closed = "", -- icon used for closed folds

  group = true,    -- group results by file
  padding = false, -- add an extra new line on top of the list
  cycle_results = false,  -- cycle item list when reaching beginning or end of list

  action_keys = { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping, for example:
    -- close = {},
    cancel = { "<ESC>" },         -- cancel the preview and get back to your last window / buffer / cursor
    close = { "q" },              -- close the list

    jump = { "<TAB>" },           -- jump to the diagnostic or open / close folds
    jump_close = { "<CR>" },      -- jump to the diagnostic and close the list

    refresh = "r",                -- manually refresh

    open_split  = { "<C-x>" },    -- open buffer in new split
    open_vsplit = { "<C-v>" },    -- open buffer in new vsplit
    open_tab    = { "<C-t>" },    -- open buffer in new tab

    toggle_mode = "m",            -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P",         -- toggle auto_preview

    hover = "<C-d>",              -- opens a small popup with the full multiline message
    preview = "p",                -- preview the diagnostic location

    close_folds = { "zM", "zm" }, -- close all folds
    open_folds  = { "zR", "zr" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file

    previous = "k",               -- previous item
    next = "j",                   -- next item

    help = "?", -- help menu
  },

  win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
  multiline = true, -- render multi-line messages
  indent_lines = true, -- add an indent guide below the fold icons

  auto_open = false,   -- automatically open the list when you have diagnostics
  auto_close = false,  -- automatically close the list when you have no diagnostics
  auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false,   -- automatically fold a file trouble list at creation
  auto_jump = {},      -- for the given modes, automatically jump if there is only a single result

  use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
  include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions"  }, -- for the given modes, include the declaration of the current symbol in the results

  -- signs = {
  --  -- icons / text used for a diagnostic
  --  error = "",
  --  warning = "",
  --  hint = "",
  --  information = "",
  --  other = "﫠"
  -- },
}


trouble.setup(config)
