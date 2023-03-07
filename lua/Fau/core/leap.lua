-- =============================================
-- ========== Plugin Loading
-- =============================================
local leap_ok, leap = pcall(require, "leap")
if not leap_ok then
  Fau_vim.load_plugin_error("leap")
  return
end



-- =============================================
-- ========== Configuration
-- =============================================
vim.keymap.set(
  { "n", "x", "o" }, "<LEADER>s",
  function()
    local focusable_windows_on_tabpage = vim.tbl_filter(
      function(win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
    require("leap").leap { target_windows = focusable_windows_on_tabpage }
  end,
  { desc = "Leap Anywhere" }
)
