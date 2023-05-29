-- =============================================
-- ========== Plugin Loading
-- =============================================
local treesj_ok, treesj = pcall(require, "treesj")
if not treesj_ok then Fau_vim.load_plugin_error("treesj") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  -- Use default keymaps
  -- (<space>m - toggle, <space>j - join, <space>s - split)
  use_default_keymaps = false,

  -- Node with syntax error will not be formatted
  check_syntax_error = true,

  -- If line after join will be longer than max value,
  -- node will not be formatted
  max_join_length = 150,

  -- hold|start|end:
  -- hold - cursor follows the node/place on which it was called
  -- start - cursor jumps to the first symbol of the node being formatted
  -- end - cursor jumps to the last symbol of the node being formatted

  cursor_behavior = "hold",
  -- Notify about possible problems or not

  notify = true,

  -- Use `dot` for repeat action
  dot_repeat = true,
}


treesj.setup(config)
