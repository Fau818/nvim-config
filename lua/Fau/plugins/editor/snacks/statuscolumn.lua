-- NOTE: Not used since it breaks the priority of signs.
---@class snacks.statuscolumn.Config
return {
  enabled = false,

  -- left = { "mark", "sign" },
  left = { "sign", "git" },  -- priority of signs on the left (high to low)
  right = { "fold" },        -- priority of signs on the right (high to low)

  folds = { open = true, git_hl = false },

  git = { patterns = { "GitSign", "MiniDiffSign" } },

  refresh = Fau_vim.settings.debounce.statuscolumn,
}
