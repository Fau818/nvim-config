---@type LazySpec
return {
  -- DESC: Github copilot supporter.
  "zbirenbaum/copilot.lua",
  commit = "f693e2169df70b0a166ac2cc09ed6c1cb94ac897",  -- FIXME: Keymaps logic changed in later versions.
  enabled = Fau_vim.plugin.copilot.enable,

  event = "InsertEnter",
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
      debounce = 50,
      trigger_on_accept = true,
      keymap = {
        accept = "<TAB>",
        accept_word = "<C-w>",
        accept_line = "<C-e>",
        next = "<A-l>",
        prev = "<A-h>",
        dismiss = "<C-c>",
      },
    },

    -- copilot_model = "",
    disable_limit_reached_message = true,  -- Set to `true` to suppress completion limit reached popup

    -- NOTE: Overwrite `internal_filetypes`
    filetypes = { gitcommit = true },
    should_attach = function(_, _) return not Fau_vim.functions.utils.is_large_file() end,

    server = {
      type = "nodejs",  ---@type "nodejs" | "binary"
      custom_server_filepath = nil,
    },
    server_opts_overrides = {},

    -- auth_provider_url = nil,  -- URL to authentication provider, if not "https://github.com/"
    -- TODO: Try NES
    -- nes = nil,                   -- Use default
    -- logger = nil,                -- Use default
    -- copilot_node_command = nil,  -- Use default
    -- workspace_folders = nil,     -- Use default
    -- root_dir = nil,              -- Use default
  },
}
