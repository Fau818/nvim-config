-- =============================================
-- ========== Plugin Loading
-- =============================================
local flit_ok, flit = pcall(require, "flit")
if not flit_ok then Fau_vim.load_plugin_error("flit") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  keys = { f = "f", F = "F", t = "t", T = "T" },
  -- A string like "nv", "nvo", "o", etc.
  labeled_modes = "nvo",
  multiline = false,
  -- Like `leap`s similar argument (call-specific overrides).
  -- E.g.: opts = { equivalence_classes = {} }
  opts = {}
}


flit.setup(config)
