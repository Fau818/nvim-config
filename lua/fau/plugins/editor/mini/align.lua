---@type LazySpec
return {
  -- DESC: Align text interactively.
  ---@module "mini.align"
  "echasnovski/mini.align",
  dependencies = "nvim-treesitter/nvim-treesitter",
  keys = { { "<LEADER>a", mode = "x", desc = "Edit: Align Text with Preview" }, { "<LEADER>A", mode = "x", desc = "Edit: Align Text" } },
  cond = true,

  opts = {
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      start              = "<LEADER>A",
      start_with_preview = "<LEADER>a",
    },
    -- Modifiers changing alignment steps and/or options
    modifiers = {
      ["-"] = function(steps, opts)
        opts.split_pattern = "%s+%-%-.*"
        table.insert(steps.pre_justify, MiniAlign.gen_step.trim())
        opts.merge_delimiter = "  "
      end,

      ["="] = function(steps, opts)
        -- opts.split_pattern = '%p*=+[<>~]*'
        opts.split_pattern = "%s+=%s+"
        table.insert(steps.pre_justify, MiniAlign.gen_step.trim())
        opts.merge_delimiter = " "
      end,

      -- ==================== Default ====================
      -- -- Main option modifiers
      -- ['s'] = --<function: enter split pattern>,
      -- ['j'] = --<function: choose justify side>,
      -- ['m'] = --<function: enter merge delimiter>,
      --
      -- -- Modifiers adding pre-steps
      -- ['f'] = --<function: filter parts by entering Lua expression>,
      -- ['i'] = --<function: ignore some split matches>,
      -- ['p'] = --<function: pair parts>,
      -- ['t'] = --<function: trim parts>,
      --
      -- -- Delete some last pre-step
      -- ['<BS>'] = --<function: delete some last pre-step>,
      --
      -- -- Special configurations for common splits
      -- ['='] = --<function: enhanced setup for '='>,
      -- [','] = --<function: enhanced setup for ','>,
      -- ['|'] = --<function: enhanced setup for '|'>,
      -- [' '] = --<function: enhanced setup for ' '>,
    },

    -- Default options controlling alignment process
    options = {
      split_pattern   = "",
      justify_side    = "left",
      merge_delimiter = "",
    },

    -- Default steps performing alignment (if `nil`, default is used)
    steps = {
      pre_split   = {},
      split       = nil,
      pre_justify = {},
      justify     = nil,
      pre_merge   = {},
      merge       = nil,
    },

    -- Whether to disable showing non-error feedback
    silent = false,
  }
}
