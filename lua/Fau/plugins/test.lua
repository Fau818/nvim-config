-- NOTE: This module is for testing new plugins.

---@type LazySpec[]
local test = {
  {
    -- DESC: a LSP signature hinter.
    -- WARNING: This plugin is disabled.
    "ray-x/lsp_signature.nvim",
    config = function() require("Fau.core.lsp.lsp_signature") end,
    enabled = false,
    -- cond = false
  },

  {
    -- DESC: an incremental LSP rename supporter, which has a preview feature.
    -- WARNING: This plugin is disabled.
    -- Doesn't support input mode switch.
    "smjonas/inc-rename.nvim",
    config = function() require("Fau.core.inc_rename") end,
    enabled = Fau_vim.inc_rename.enable,
  },


  -- {
  --   -- DESC: Maybe in the future.
  --   -- mini.doc
  -- },


  {
    "nosduco/remote-sshfs.nvim",
    config = function()
      local config = {
        connections = {
          ssh_configs = { -- which ssh configs to parse for hosts list
            vim.fn.expand "$HOME" .. "/.ssh/config",
            -- "/etc/ssh/ssh_config",
            -- "/path/to/custom/ssh_config"
          },
          sshfs_args = { -- arguments to pass to the sshfs command
            "-o reconnect",
            "-o ConnectTimeout=5",
          },
        },
        mounts = {
          base_dir = vim.fn.expand "$HOME" .. "/.sshfs/", -- base directory for mount points
          unmount_on_exit = true,                     -- run sshfs as foreground, will unmount on vim exit
        },
        handlers = {
          on_connect = {
            change_dir = true, -- when connected change vim working directory to mount point
          },
          on_disconnect = {
            clean_mount_folders = false, -- remove mount point folder on disconnect/unmount
          },
          on_edit = {},              -- not yet implemented
        },
        ui = {
          select_prompts = false, -- not yet implemented
          confirm = {
            connect = true,   -- prompt y/n when host is selected to connect to
            change_dir = false, -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
          },
        },
        log = {
          enable = false, -- enable logging
          truncate = false, -- truncate logs
          types = {     -- enabled log types
            all = false,
            util = false,
            handler = false,
            sshfs = false,
          },
        },
      }
      require("remote-sshfs").setup(config)
    end,

    enabled = false
  },


  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function() require("Fau.core.dropbar") end,
    enabled = false,
  },



}


return test
