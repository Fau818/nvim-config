-- ==================== Setup ====================
Fau_vim.functions.colorscheme.setup = function(colorscheme)
  -- Configuration
  colorscheme = colorscheme or Fau_vim.colorscheme or "habamax"
  pcall(require, ("Fau.plugins.editor.colorscheme.%s"):format(colorscheme))
  -- Loading
  local status_ok, _ = pcall(vim.api.nvim_command, ("colorscheme %s"):format(colorscheme))
  if not status_ok then Fau_vim.notify(("colorscheme [%s] not found!"):format(colorscheme), "error") return end
end


-- ==================== TodoSign Highlights Namespace ====================
local todo_sign_hl_ns_id = vim.api.nvim_create_namespace("todo_signs_hl")
vim.api.nvim_set_hl(todo_sign_hl_ns_id, "@comment", { bold = true, italic = true })

---@param win_id? number -- Window ID, default: 0 (current window)
Fau_vim.functions.colorscheme.set_todo_sign_hl_ns = function(win_id)
  win_id = win_id or 0
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.api.nvim_win_set_hl_ns(win_id, todo_sign_hl_ns_id)
end


---@type LazySpec[]
return {
  {
    -- DESC: A snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    priority = 1000,
    -- tag = "stable",

    init = function() Fau_vim.colorscheme = "tokyonight" end,

    config = function() Fau_vim.functions.colorscheme.setup("tokyonight") end,
  },
}
