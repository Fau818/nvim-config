---@type LazySpec
return {
  -- DESC: Github copilot supporter.
  ---@module "copilot"
  "zbirenbaum/copilot.lua",
  dependencies = {
    ---@module "copilot-lsp"
    "copilotlsp-nvim/copilot-lsp",
    -- enabled = false,
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = fvim.file.excluded_filetypes,
        callback = function() vim.b.copilot_nes_debounce = 9999999999999999999999 end,
      })

      vim.g.copilot_nes_debounce = 500
      vim.keymap.set({ "n", "i" }, "<C-y>", function()
        local nes = require("copilot-lsp.nes")
        local bufnr = vim.api.nvim_get_current_buf()
        local state = vim.b[bufnr].nes_state
        if state then
          -- local _ = nes.walk_cursor_start_edit() or (nes.apply_pending_nes() and nes.walk_cursor_end_edit())
          local _ = nes.apply_pending_nes(bufnr) and nes.walk_cursor_end_edit(bufnr)
          return nil
        else
          fvim.notify("Requested Copilot NES suggestion ...")
          nes.request_nes("copilot")
          return nil
        end
      end, { desc = "Accept Copilot NES suggestion or Requested", expr = true })
    end,

    ---@type copilotlsp.config
    opts = {}
  },
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
    filetypes = { gitcommit = true, yaml = true },

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
