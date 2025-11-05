---@class snacks.dashboard.Config
return {
  enabled = true,

  width    = 60,
  row      = nil,  -- dashboard position. nil for center
  col      = nil,  -- dashboard position. nil for center
  pane_gap = 4,    -- empty columns between vertical panes

  autokeys = nil,  -- Use default.

  preset = {
    -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
    ---@type fun(cmd:string, opts:table)|nil
    -- pick = nil,  -- Use default.

    ---@type snacks.dashboard.Item[]
    keys = {
      { icon = " ", key = "n", desc = "New File", action = ":enew" },

      { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      -- { icon = " ", key = "t", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },

      { icon = " ", key = "c", desc = "Config", action = ":FauvimConfig" },

      -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      { icon = " ", key = "l", desc = "Restore Session",      action = function() require("persistence").load() end },
      { icon = " ", key = "L", desc = "Restore Last Session", action = function() require("persistence").load({ last=true }) end },
      { icon = " ", key = "S", desc = "Session List",         action = function() require("persistence").select() end },

      { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },

    -- header = nil,  -- Use default.
  },

  -- item field formatters
  -- formats = nil,  -- Use default.

  sections = {
    { section = "header" },
    { section = "keys", gap = 1, padding = 2 },
    -- { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
    { icon = " ", title = "Projects\n", section = "projects", indent = 2, padding = 0 },
    { section = "startup", padding = { 0, 2 } },
  },
}
