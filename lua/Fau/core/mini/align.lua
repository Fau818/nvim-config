-- =============================================
-- ========== Plugin Loading
-- =============================================
local align_ok, align = pcall(require, "mini.align")
if not align_ok then Fau_vim.load_plugin_error("mini.align") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    start = "<LEADER>A",
    start_with_preview = "<LEADER>a",
  },
  -- Modifiers changing alignment steps and/or options
  modifiers = {
    ["-"] = function(steps, opts)
      opts.split_pattern = " %-%- "
      table.insert(steps.pre_justify, align.gen_step.trim())
      opts.merge_delimiter = " "
    end,

    ["="] = function(steps, opts)
      -- opts.split_pattern = '%p*=+[<>~]*'
      opts.split_pattern = " = "
      table.insert(steps.pre_justify, align.gen_step.trim())
      opts.merge_delimiter = " "
    end,

    -- -----------------------------------
    -- -------- Default
    -- -----------------------------------
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
    -- [' '] = --<function: enhanced setup for ' '>,
  },

  -- Default options controlling alignment process
  options = {
    split_pattern = '',
    justify_side = 'left',
    merge_delimiter = '',
  },

  -- Whether to disable showing non-error feedback
  silent = false,
}


align.setup(config)
-- TODO: A PR or issue to toggle pre-step
