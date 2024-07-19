-- =============================================
-- ========== Plugin Configurations
-- =============================================
local trouble = require("trouble")

---@type TroubleOptions
local config = {
  position = "bottom",  -- position of the list can be: bottom, top, left, right
  height = 10,          -- height of the trouble list when position is top or bottom
  width = 50,           -- width of the list when position is left or right
  icons = true,         -- use devicons for filenames

  mode = "document_diagnostics",            -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  severity = nil,  -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT

  fold_open   = "",  -- icon used for open folds
  fold_closed = "",  -- icon used for closed folds

  group = true,           -- group results by file
  padding = false,        -- add an extra new line on top of the list
  cycle_results = false,  -- cycle item list when reaching beginning or end of list

  action_keys = {              -- key mappings for actions in the trouble list
    cancel     = { "<ESC>" },  -- cancel the preview and get back to your last window / buffer / cursor
    close      = { "q" },      -- close the list
    jump       = { "<TAB>" },  -- jump to the diagnostic or open / close folds
    jump_close = { "<CR>" },   -- jump to the diagnostic and close the list

    refresh = "r",  -- manually refresh

    open_split  = { "<C-x>" },  -- open buffer in new split
    open_vsplit = { "<C-v>" },  -- open buffer in new vsplit
    -- open_tab    = { "<C-t>" },  -- open buffer in new tab
    open_tab    = {},

    toggle_mode = "m",  -- toggle between "workspace" and "document" diagnostics mode

    preview        = "p",  -- preview the diagnostic location
    toggle_preview = "P",  -- toggle auto_preview

    hover = "<C-d>",  -- opens a small popup with the full multiline message

    close_folds = { "zM", "zm" },  -- close all folds
    open_folds  = { "zR", "zr" },  -- open all folds
    toggle_fold = { "zA", "za" },  -- toggle fold of current file

    previous = "k",  -- previous item
    next = "j",      -- next item

    help = "?",  -- help menu
  },

  multiline = true,                    -- render multi-line messages
  indent_lines = true,                 -- add an indent guide below the fold icons
  win_config = { border = "single" },  -- window configuration for floating windows. See |nvim_open_win()|.

  auto_open    = false,  -- automatically open the list when you have diagnostics
  auto_close   = false,  -- automatically close the list when you have no diagnostics
  auto_preview = true,   -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold    = false,  -- automatically fold a file trouble list at creation
  auto_jump    = {},     -- for the given modes, automatically jump if there is only a single result

  use_diagnostic_signs = true,                                                           -- enabling this will use the signs defined in your lsp client
  include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" },  -- for the given modes, include the declaration of the current symbol in the results

  signs = nil,  -- Use default.
}

trouble.setup(config)



-- =============================================
-- ========== Keymaps
-- =============================================
local keymap = vim.keymap.set
local function opts(desc) return { silent = true, desc = desc } end

keymap("n", "<LEADER>tt", "<CMD>Trouble<CR>",                       opts("Show Trouble"))
keymap("n", "gd",         "<CMD>Trouble lsp_definitions<CR>",       opts("Goto Definition"))
keymap("n", "gD",         "<CMD>Trouble lsp_declarations<CR>",      opts("Goto Declaration"))
keymap("n", "gt",         "<CMD>Trouble lsp_type_definitions<CR>",  opts("Goto Type Definition"))
keymap("n", "gI",         "<CMD>Trouble lsp_implementations<CR>",   opts("Goto Implementation"))
keymap("n", "gr",         "<CMD>Trouble lsp_references<CR>",        opts("Show References"))

keymap("n", "gi",         "<CMD>Trouble lsp_incoming_calls<CR>",    opts("Show Incoming Calls"))
keymap("n", "go",         "<CMD>Trouble lsp_outgoing_calls<CR>",    opts("Show Outgoing Calls"))

keymap("n", "<LEADER>ld", "<CMD>Trouble document_diagnostics<CR>",  opts("Buffer Diagnostics"))
keymap("n", "<LEADER>lD", "<CMD>Trouble workspace_diagnostics<CR>", opts("Workspace Diagnostics"))
