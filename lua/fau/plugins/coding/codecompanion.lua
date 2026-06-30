local function edit_with_instructions()
  vim.ui.input({ prompt = "Edit With Instructions" }, function(input)
    if not input or vim.trim(input) == "" then return end
    require("codecompanion").inline({ args = input, range = 2 })
  end)
end


---@type LazyPluginSpec
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "zbirenbaum/copilot.lua",
  },
  cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionCLI", "CodeCompanionActions" },
  keys = {
    { "<LEADER>ci", edit_with_instructions, mode = "x", desc = "CodeCompanion: Interact" },
    { "<LEADER>cc", "<CMD>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion: Chat" },
  },

  init = function()
    -- ==================== Spinner ====================
    local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local spinner_index = 0
    local function next_spinner_frame()
      spinner_index = spinner_index % #spinner_frames + 1
      return spinner_frames[spinner_index]
    end

    local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = { "CodeCompanionRequestStarted", "CodeCompanionRequestFinished" },
      group = group,
      callback = function(args)
        local started = args.match == "CodeCompanionRequestStarted"
        if not started then spinner_index = 0 end

        vim.notify(started and "Request started" or "Request finished", vim.log.levels.INFO, {
          id = "codecompanion_status",
          title = "CodeCompanion Status",
          timeout = started and 30000 or 1000,  -- started: 30s hard cap; finished: close 1s after
          opts = function(notif) notif.icon = started and next_spinner_frame() or " " end,
        })
      end,
    })
  end,

  opts = {
    -- ==================== Adapters ====================
    adapters = {
      http = {
        -- OpenAI-compatible adapter for CodeCompanion
        chatanywhere = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "chatanywhere",
            formatted_name = "ChatAnywhere",
            env = {
              api_key = ([[cmd:zsh -c "%s"]]):format(fvim.settings.openai.api_path),
              url     = ([[cmd:zsh -c "%s"]]):format(fvim.settings.openai.host_path),
              chat_url = "/v1/chat/completions",
            },
            schema = { model = { default = "gpt-5.6-luna", choices = {} } },
          })
        end,

        chatanywhere_cost = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            name = "chatanywhere_cost",
            formatted_name = "ChatAnywhere Cost",
            env = {
              api_key = ([[cmd:zsh -c "%s_cost"]]):format(fvim.settings.openai.api_path),
              url     = ([[cmd:zsh -c "%s"]]):format(fvim.settings.openai.host_path),
              chat_url = "/v1/chat/completions",
            },
            schema = { model = { default = "gpt-5.6-luna", choices = {} } },
          })
        end,

        extend = { copilot = { schema = { model = { default = "" } } } },

        opts = {
          allow_insecure = false,     -- Allow insecure connections?
          cache_models_for = 1800,    -- Cache adapter models for this long (seconds)
          proxy = nil,                -- [protocol://]host[:port] e.g. socks5://127.0.0.1:9999
          show_presets = true,        -- Show preset adapters
          show_model_choices = true,  -- Show model choices when changing adapter
        },
      },

      acp = {
        extend = nil,
        opts = { show_presets = true },
      },
    },

    -- ==================== Interactions ====================
    interactions = {
      background = { adapter = "copilot" },  -- { adapter = { name = "copilot", model = "" } }
      chat = { adapter = "copilot_acp" },
      inline = { adapter = "copilot" },
      cmd = { adapter = "copilot" },
      shared = {
        keymaps = {
          accept_change = { modes = { n = "<C-y>" } },
          reject_change = { modes = { n = "<C-n>" } },
          always_accept = { modes = { n = "<C-a>" } },
        },
      },
    },

    opts = { log_level = "ERROR", language = "English" },
  },
}
