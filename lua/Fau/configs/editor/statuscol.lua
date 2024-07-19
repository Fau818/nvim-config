-- =============================================
-- ========== Plugin Configurations
-- =============================================
local statuscol = require("statuscol")
local builtin   = require("statuscol.builtin")

local config = {
  setopt      = true,
  thousands   = false,  -- or line number thousands separator string ("." / ",")
  relculright = true,   -- whether to right-align the cursor line number with 'relativenumber' set

  -- BUG: `checkhealth` is not working properly.
  -- \    It seems the `filetype` is empty first, then it is set to `checkhealth`.
  -- \    So the `ft_ignore` and `bt_ignore` are disabled.
  -- ft_ignore = Fau_vim.file.excluded_filetypes,
  -- bt_ignore = Fau_vim.file.excluded_buftypes,

  segments = {
    -- Sign (Default statuscolumn)
    {
      text = { "%s" },
      click = "v:lua.ScSa",
      sign = { auto = true },
    },

    -- Line number
    {
      text = { builtin.lnumfunc, " " },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScLa",
    },

    -- Fold
    {
      text = { builtin.foldfunc, " " },
      condition = { true, builtin.not_empty },
      click = "v:lua.ScFa",
      sign = { auto = true },
    },
  },

  clickmod = "c",  -- "a" for Alt, "c" for Ctrl and "m" for Meta.
  clickhandlers = nil,  -- Use default.
}

statuscol.setup(config)
