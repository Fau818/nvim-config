return {
  -- DESC: Statusline enhancer.
  ---@module "statuscol"
  "luukvbaal/statuscol.nvim",
  enabled = vim.fn.has("nvim-0.10") == 1,
  event = { "BufReadPre", "BufNewFile" },

  opts = function()
    local builtin   = require("statuscol.builtin")
    return {
      setopt      = true,
      thousands   = false,  -- or line number thousands separator string ("." / ",")
      relculright = true,  -- whether to right-align the cursor line number with 'relativenumber' set

      ft_ignore = vim.tbl_filter(function(ft) return ft ~= "" end, fvim.file.excluded_filetypes),       -- NOTE: Filtered filetype `""`
      bt_ignore = vim.tbl_filter(function(bt) return bt ~= "nofile" end, fvim.file.excluded_buftypes),  -- NOTE: Filtered buftype `"nofile"`

      segments = {
        -- ─── Sign (Default statuscolumn) ────────────────────
        {
          text = { "%s" },
          click = "v:lua.ScSa",
          sign = { auto = true },
        },


        -- ─── Line Number ────────────────────────────────────
        {
          text = { builtin.lnumfunc, " " },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },


        -- ─── Fold ───────────────────────────────────────────
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
  end,
}
