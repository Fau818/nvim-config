Fau_vim.functions.utils.set_colorscheme = function(colorscheme)
  -- Configuration
  colorscheme = colorscheme or Fau_vim.colorscheme or "habamax"
  pcall(require, ("Fau.plugins.editor.colorscheme.%s"):format(colorscheme))
  -- Loading
  local status_ok, _ = pcall(vim.api.nvim_command, ("colorscheme %s"):format(colorscheme))
  if not status_ok then Fau_vim.notify(("colorscheme [%s] not found!"):format(colorscheme), "error") return end
end


---@type LazySpec[]
return {
  {
    -- DESC: A snazzy colorscheme that can be customized.
    "folke/tokyonight.nvim",
    priority = 1000,
    -- tag = "stable",
    config = function()
      Fau_vim.colorscheme = "tokyonight"
      Fau_vim.functions.utils.set_colorscheme()
    end,
  },
}
