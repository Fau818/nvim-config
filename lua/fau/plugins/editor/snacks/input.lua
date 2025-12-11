---@class snacks.input.Config
return {
  enabled = not vim.g.vscode,

  icon    = nil,  -- Use default.
  icon_hl = nil,  -- Use default.

  icon_pos = "left",
  prompt_pos = "title",

  win = { style = "input" },
  expand = true,
}
