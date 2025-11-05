---@type LazySpec
return {
  -- DESC: Detect file indentation automatically.
  ---@module "guess-indent"
  "nmac427/guess-indent.nvim",
  cmd = "GuessIndent",
  event = "BufReadPre",

  ---@type GuessIndentConfig
  opts = {
    auto_cmd              = true,
    override_editorconfig = false,

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
