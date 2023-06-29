-- =============================================
-- ========== Plugin Loading
-- =============================================
local statuscol_ok, statuscol = pcall(require, "statuscol")
if not statuscol_ok then Fau_vim.load_plugin_error("statuscol") return end



-- =============================================
-- ========== Configuration
-- =============================================
local builtin = require("statuscol.builtin")

local function foldfunc(args)
  local fold_string = builtin.foldfunc(args)
  if type(fold_string) == "string" and fold_string:len() > 0 then fold_string = fold_string .. " " end
  return fold_string
end

local function empty_gitsigns_and_diagnostics()
  ---@diagnostic disable-next-line: undefined-field
  if vim.b.gitsigns_status == nil or vim.b.gitsigns_status == "" then
    if vim.diagnostic.get_next_pos() == false then return true end
  end
  return false
end

local config = {
  -- Builtin 'statuscolumn' options
  setopt = true, -- whether to set the 'statuscolumn', providing builtin click actions

  -- Builtin line number string options for ScLn() segment
  thousands   = false, -- or line number thousands separator string ("." / ",")
  relculright = true,  -- whether to right-align the cursor line number with 'relativenumber' set

  ft_ignore = Fau_vim.disabled_filetypes,  -- lua table with filetypes for which 'statuscolumn' will be unset
  bf_ignore = nil,

  segments = {
    {
      text = { "  " },
      condition = { empty_gitsigns_and_diagnostics },
    },

    {  -- git signs
      click = "v:lua.ScSa",
      sign = {
        name = { "GitSign" },
        maxwidth = 1,
        colwidth = 2,
        auto = true,
      }
    },

    {  -- diagnostics
      click = "v:lua.ScSa",
      sign = {
        name = { "Diagnostic" },
        maxwidth = 1,
        colwidth = 2,
        auto = true,
      }
    },

    {  -- line number
      text = { builtin.lnumfunc, " " },
      -- NOTE: `builtin.not_empty` works like always be true
      -- condition = { true, builtin.not_empty },
      click = "v:lua.ScLa",
    },

    {
      text = { foldfunc },
      click = "v:lua.ScFa",
      sign = { auto = true },
    },
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
