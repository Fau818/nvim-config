-- WARNING: This plugin has been archived.
---@type LazySpec
return {
  -- DESC: a powerful breadcrumb plugin based on navic.
  ---@module "barbecue"
  "utilyre/barbecue.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    {
      -- DESC: a fancy winbar plugin combining with LSP.
      ---@module "nvim-navic"
      "SmiteshP/nvim-navic",

      ---@type Options
      opts = {
        lsp = { auto_attach = false, preference = nil },

        icons = fvim.icons.kinds,
        highlight = true,

        separator = (" %s "):format(fvim.icons.ui.Separator),

        depth_limit = 0,
        depth_limit_indicator = fvim.icons.ui.Ellipsis,

        safe_output = true,
        lazy_update_context = false,  -- If true, it won't update on CursorMoved event.

        click = true,
        -- format_text = function(text) return text end,  -- Use default.
      },
    },
  },

  cmd = "Barbecue",
  event = "LspAttach",

  ---@type barbecue.Config
  opts = {
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
    exclude_filetypes = fvim.file.excluded_filetypes,

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
    lead_custom_section = function() return fvim.icons.ui.BoldBread .. " " end,

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
      modified = fvim.icons.ui.Modified,

      ---Truncation indicator.
      ---@type string
      ellipsis = fvim.icons.ui.Ellipsis,

      ---Entry separator.
      ---@type string
      separator = fvim.icons.ui.Separator,
    },

    ---Icons for different context entry kinds.
    ---@type barbecue.Config.kinds
    kinds = fvim.icons.kinds,
  }
}
