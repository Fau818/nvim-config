-- =============================================
-- ========== Plugin Loading
-- =============================================
local statuscol_ok, statuscol = pcall(require, "statuscol")
if not statuscol_ok then Fau_vim.load_plugin_error("statuscol") return end



-- =============================================
-- ========== Configuration
-- =============================================
local builtin = require("statuscol.builtin")

local config = {
  -- Builtin line number string options for ScLn() segment
  thousands   = false, -- or line number thousands separator string ("." / ",")
  relculright = true,  -- whether to right-align the cursor line number with 'relativenumber' set

  -- Builtin 'statuscolumn' options
  setopt = true,         -- whether to set the 'statuscolumn', providing builtin click actions
  ft_ignore = nil,       -- lua table with filetypes for which 'statuscolumn' will be unset
  bf_ignore = nil,

  segments = {
    { text = { "%s" }, click = "v:lua.ScSa" },

    {
      text = { builtin.lnumfunc, " " },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScLa",
    },

    { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
  },

  clickmod = "c",  -- "a" for Alt, "c" for Ctrl and "m" for Meta.

  clickhandlers = {
    Lnum                   = builtin.lnum_click,
    FoldClose              = builtin.foldclose_click,
    FoldOpen               = builtin.foldopen_click,
    FoldOther              = builtin.foldother_click,
    DapBreakpointRejected  = builtin.toggle_breakpoint,
    DapBreakpoint          = builtin.toggle_breakpoint,
    DapBreakpointCondition = builtin.toggle_breakpoint,
    DiagnosticSignError    = builtin.diagnostic_click,
    DiagnosticSignHint     = builtin.diagnostic_click,
    DiagnosticSignInfo     = builtin.diagnostic_click,
    DiagnosticSignWarn     = builtin.diagnostic_click,
    GitSignsTopdelete      = builtin.gitsigns_click,
    GitSignsUntracked      = builtin.gitsigns_click,
    GitSignsAdd            = builtin.gitsigns_click,
    GitSignsChange         = builtin.gitsigns_click,
    GitSignsChangedelete   = builtin.gitsigns_click,
    GitSignsDelete         = builtin.gitsigns_click,
  }
}


statuscol.setup(config)
