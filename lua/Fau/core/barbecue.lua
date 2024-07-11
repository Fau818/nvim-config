-- =============================================
-- ========== Plugin Loading
-- =============================================
local barbecue_ok, barbecue = pcall(require, "barbecue")
if not barbecue_ok then Fau_vim.load_plugin_error("barbecue") return end



-- =============================================
-- ========== Configuration
-- =============================================
---@type barbecue.Config
local config = {
  ---Whether to attach navic to language servers automatically.
  ---@type boolean
  attach_navic = true,

  ---Whether to create winbar updater autocmd.
  ---@type boolean
  create_autocmd = true,

  ---Buftypes to enable winbar in.
  ---@type string[]
  include_buftypes = { "" },

  ---Filetypes not to enable winbar in.
  ---@type string[]
  exclude_filetypes = Fau_vim.file.excluded_filetypes,

  modifiers = {
    ---Filename modifiers applied to dirname.
    ---See: `:help filename-modifiers`
    ---@type string
    dirname = ":~:.",

    ---Filename modifiers applied to basename.
    ---See: `:help filename-modifiers`
    ---@type string
    basename = "",
  },

  ---Whether to display path to file.
  ---@type boolean
  show_dirname = true,

  ---Whether to display file name.
  ---@type boolean
  show_basename = true,

  ---Whether to replace file icon with the modified symbol when buffer is
  ---modified.
  ---@type boolean
  show_modified = false,

  ---Get modified status of file.
  ---NOTE: This can be used to get file modified status from SCM (e.g. git)
  ---@type fun(bufnr: number): boolean
  modified = function(bufnr) return vim.bo[bufnr].modified end,

  ---Whether to show/use navic in the winbar.
  ---@type boolean
  show_navic = true,

  ---Get leading custom section contents.
  ---NOTE: This function shouldn't do any expensive actions as it is run on each render.
  ---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
  lead_custom_section = function() return Fau_vim.icons.ui.BoldBread .. " " end,

  ---Get custom section contents.
  ---NOTE: This function shouldn't do any expensive actions as it is run on each render.
  ---@type fun(bufnr: number, winnr: number): barbecue.Config.custom_section
  custom_section = function() return " " end,

  ---Theme to be used for generating highlight groups dynamically.
  ---@type barbecue.Config.theme
  theme = "auto",

  ---Whether context text should follow its icon's color.
  ---@type boolean
  context_follow_icon_color = false,

  symbols = {
    ---Modification indicator.
    ---@type string
    modified = Fau_vim.icons.ui.Modified,

    ---Truncation indicator.
    ---@type string
    ellipsis = Fau_vim.icons.ui.Ellipsis,

    ---Entry separator.
    ---@type string
    separator = Fau_vim.icons.ui.Separator,
  },

  ---Icons for different context entry kinds.
  ---@type barbecue.Config.kinds
  kinds = Fau_vim.icons.kind,
}


barbecue.setup(config)
