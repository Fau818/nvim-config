-- =============================================
-- ========== Plugin Configurations
-- =============================================
local windows = require("windows")

local config = {
  autowidth = {
    enable = true,
    winwidth = 0.65,
    filetype = nil,
  },
  ignore = {
    buftype  = Fau_vim.file.excluded_buftypes,
    filetype = Fau_vim.file.excluded_filetypes,
  },
  animation = {
    enable = true,
    duration = 250,
    fps = 60,
    easing = "in_out_sine",
  }
}

windows.setup(config)
