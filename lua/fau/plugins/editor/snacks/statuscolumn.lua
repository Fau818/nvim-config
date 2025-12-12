-- NOTE: Not used since it breaks the priority of signs.
---@class snacks.statuscolumn.Config
return {
  enabled = false,

  -- left = { "mark", "sign" },
  left = { "sign" },          -- priority of signs on the left (high to low)
  right = { "fold", "git" },  -- priority of signs on the right (high to low)

  folds = { open = false, git_hl = true },

  git = { patterns = { "GitSign", "MiniDiffSign" } },

  refresh = fvim.settings.debounce.statuscolumn,
}
