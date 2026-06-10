-- TODO: Configure obsidian.nvim more thoroughly.
---@type LazyPluginSpec
return {
  ---@module "obsidian"
  "obsidian-nvim/obsidian.nvim",
  -- version = "*",  -- recommended, use latest release instead of latest commit
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },

  ---@type obsidian.config
  opts = {
    ui = { enabled = false },

    legacy_commands = false,  -- this will be removed in the next major release
    workspaces = {
      {
        name = "personal",
        path = vim.env.IOBSIDIAN or "",
      },
    },
    attachments = {
      folder = "/Attachments/images/",
    },

    -- see below for full list of options 👇
    footer = { enabled = true }
  },

  config = function(_, opts)
    require("obsidian").setup(opts)

    _G.fvim_obsidian_image_resolver = function(path, src)
      if require("obsidian.api").path_is_note(path) then
        return require("obsidian.api").resolve_image_path(src)
      end
    end
  end,
}
