---@type LazyPluginSpec
return {
  -- DESC: Detect file indentation automatically.
  ---@module "guess-indent"
  "nmac427/guess-indent.nvim",
  event = "BufReadPre",

  cmd = "GuessIndent",
  keys = { { "<LEADER><LEADER>I", "<CMD>GuessIndent<CR>", desc = "Detect Indentation" } },

  ---@type GuessIndentConfig
  opts = {
    auto_cmd              = true,
    override_editorconfig = true,

    filetype_exclude = vim.list_extend({ "gitcommit" }, fvim.file.excluded_filetypes),
    buftype_exclude  = fvim.file.excluded_buftypes,

    on_tab_options   = { ["expandtab"] = false },
    on_space_options = {
      ["expandtab"]   = true,
      ["tabstop"]     = "detected",
      ["softtabstop"] = -1,
      ["shiftwidth"]  = 0,
    },
  },
}
