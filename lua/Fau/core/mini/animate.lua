-- =============================================
-- ========== Plugin Loading
-- =============================================
local animate_ok, animate = pcall(require, "mini.animate")
if not animate_ok then Fau_vim.load_plugin_error("mini.animate") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  cursor = {
    enable = true,
    timing = animate.gen_timing.cubic({ duration = 120, unit = "total" }),
    -- path = animate.gen_path.line(),
  },
  scroll = { enable = false },
  resize = { enable = false },
  open   = { enable = false },
  close  = { enable = false },
}


animate.setup(config)
