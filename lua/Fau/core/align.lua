-- =============================================
-- ========== Plugin Loading
-- =============================================
local align_ok, align = pcall(require, "mini.align")
if not align_ok then Fau_vim.load_plugin_error("mini.align") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  mappings = {
    start = "<LEADER>A",
    start_with_preview = "<LEADER>a",
  },
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
  },
}

align.setup(config)
