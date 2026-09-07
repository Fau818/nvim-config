---@type LazyPluginSpec
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

    should_attach = function(bufnr, _) return not fvim.utils.is_large_file(bufnr) end,

    server = {
      type = "nodejs",  ---@type "nodejs" | "binary"
      custom_server_filepath = nil,
    },
    -- SEE: Follow https://github.com/neovim/nvim-lspconfig/blob/master/lsp/copilot.lua
    server_opts_overrides = {
      init_options = {
        editorPluginInfo = { name = "Neovim", version = tostring(vim.version()) },
      },
    },

    -- auth_provider_url = nil,  -- URL to authentication provider, if not "https://github.com/"
    -- logger = nil,                -- Use default
    -- copilot_node_command = nil,  -- Use default
    -- workspace_folders = nil,     -- Use default
    -- root_dir = nil,              -- Use default
  },

  config = function(_, opts)
    -- CASE1: copilot.lua already installed copilot server, so just use it.
    local installer = require("copilot.lsp.installer")
    local target = installer.resolve_target(opts.server.type)
    if target and installer.get_entrypoint(target) then require("copilot").setup(opts) return end

    -- CASE2: copilot.lua didn't install copilot server, so use mason.nvim to manage it.
    fvim.lsp.mason.mason_install("copilot-language-server", nil, function(success)
      if success then
        local mason_root = require("mason.settings").current.install_root_dir
        opts.server.custom_server_filepath = vim.fs.joinpath(mason_root, "bin", "copilot-language-server")
      end
      require("copilot").setup(opts)
    end)
  end,
}
