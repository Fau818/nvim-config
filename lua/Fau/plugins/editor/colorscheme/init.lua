-- ==================== Setup ====================
Fau_vim.functions.colorscheme.setup = function(colorscheme)
  -- Configuration
  colorscheme = colorscheme or Fau_vim.colorscheme or "habamax"
  pcall(require, ("Fau.plugins.editor.colorscheme.%s"):format(colorscheme))
  -- Loading
  local status_ok, _ = pcall(vim.api.nvim_command, ("colorscheme %s"):format(colorscheme))
  if not status_ok then Fau_vim.notify(("colorscheme [%s] not found!"):format(colorscheme), "error") return end
end


-- ==================== Recover Comment Highlight ====================
local fix_comment_hl_ns_id = vim.api.nvim_create_namespace("fix_comment_hl")
vim.api.nvim_set_hl(fix_comment_hl_ns_id, "@comment", { link = "Comment" })

---@param win_id? integer -- Window ID, default: 0 (current window)
Fau_vim.functions.colorscheme.fix_comment_hl = function(win_id)
  win_id = win_id or 0
  vim.api.nvim_win_set_hl_ns(win_id, fix_comment_hl_ns_id)
end


---@type LazySpec[]
return {
  {
    -- DESC: A snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    priority = 1000,
    -- tag = "stable",

    init = function()
      Fau_vim.colorscheme = "tokyonight"
      vim.api.nvim_create_autocmd("User", {
        pattern = { "TelescopePreviewerLoaded", "DiffviewDiffBufWinEnter" },
        group = "Fau_vim",
        callback = function() Fau_vim.functions.colorscheme.fix_comment_hl() end,
      })
    end,

    config = function() Fau_vim.functions.colorscheme.setup("tokyonight") end,
  },
}
