---@type LazySpec
return {
  -- DESC: Github copilot supporter.
  ---@module "copilot"
  "zbirenbaum/copilot.lua",
  enabled = fvim.settings.copilot.enable,

  event = { "InsertEnter", "CmdlineEnter", "LspAttach" },
  cmd   = "Copilot",

  ---@type CopilotConfig
  opts = {
    panel = {
      enabled = false,
      auto_refresh = true,
      keymap = {
        jump_prev = "[[",
        jump_next = "]]",
        accept = "<CR>",
        refresh = "gr",
        open = "<A-CR>"
      },
      layout = {
        position = "bottom",  ---@type "bottom"|"top"|"left"|"right"
        ratio = 0.35
      },
    },

    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      debounce = fvim.settings.debounce.copilot,
      trigger_on_accept = true,
      keymap = {
        accept = "<TAB>",
        accept_word = "<A-w>",
        accept_line = "<A-e>",
        next = "<A-l>",
        prev = "<A-h>",
        dismiss = "<C-c>",
      },
    },

    nes = {
      enabled = false,
      auto_trigger = true,
      keymap = {
        accept = false,
        accept_and_goto = false,
        dismiss = "<ESC>",
      }
    },

    -- copilot_model = "",
    disable_limit_reached_message = false,  -- Set to `true` to suppress completion limit reached popup

    -- NOTE: Overwrite `internal_filetypes`
    filetypes = {
      markdown = true,
      gitcommit = true,
      yaml = true,

      ["grug-far"] = false,
      ["grug-far-history"] = false,
      ["grug-far-help"] = false,
    },

    should_attach = function(_, _) return not fvim.utils.is_large_file() end,

    server = {
      type = "nodejs",  ---@type "nodejs" | "binary"
      custom_server_filepath = nil,
    },
    server_opts_overrides = {},

    -- auth_provider_url = nil,  -- URL to authentication provider, if not "https://github.com/"
    -- logger = nil,                -- Use default
    -- copilot_node_command = nil,  -- Use default
    -- workspace_folders = nil,     -- Use default
    -- root_dir = nil,              -- Use default
  },
}
