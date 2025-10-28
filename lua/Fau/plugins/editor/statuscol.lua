return {
  -- DESC: Statusline enhancer.
  ---@module "statuscol"
  "luukvbaal/statuscol.nvim",
  enabled = false,  -- TEST: Use `Snacks.statuscolumn` instead.
  event = "UIEnter",

  config = function()
    local statuscol = require("statuscol")
    local builtin   = require("statuscol.builtin")

    local config = {
      setopt      = true,
      thousands   = false,  -- or line number thousands separator string ("." / ",")
      relculright = true,  -- whether to right-align the cursor line number with 'relativenumber' set

      ft_ignore = vim.list_slice(Fau_vim.file.excluded_filetypes, 2),  -- NOTE: Filtered filetype `""`
      bt_ignore = vim.list_slice(Fau_vim.file.excluded_buftypes, 2),   -- NOTE: Filtered buftype `"nofile"`

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
  end,
}
