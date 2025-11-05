---@type LazySpec
return {
  ---@module "nvim-ts-autotag"
  "windwp/nvim-ts-autotag",
  lazy = true,  -- Loaded by blink.cmp

  ---@type nvim-ts-autotag.PluginSetup
  opts = {
    opts = {
      enable_close          = true,  -- Auto close tags
      enable_rename         = true,  -- Auto rename pairs of tags
      enable_close_on_slash = true,  -- Auto close on trailing </
    },

    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = nil,
  },
}
