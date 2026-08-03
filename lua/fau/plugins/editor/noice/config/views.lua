---@module "noice"
---@type table<string, NoiceViewOptions>
local views = {
  -- ══════════════════ Preset Modification ═══════════════════

  notify = { replace = true, merge = true },

  hover = {
    size = { max_width = 100 },
    border = { style = "rounded", padding = { 0, 1 } },
    position = { row = 2, col = 2 },
  },

  cmdline_popup = { size = { width = 60 } },

  -- NOTE: basedpyright emits progress every ~100ms; longer timeouts stack stale lines
  -- because mini ignores `replace`/`merge`. Keep this at one pass' lifetime.
  mini = { timeout = 100 },


  -- ═════════════════════════ Custom ═════════════════════════

  cmdline_popup_top = { view = "cmdline_popup", position = { row = 3, col = "50%" } },
}


return views
