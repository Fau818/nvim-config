local openai_model = "gpt-5-mini"


---@type LazySpec
return {
  ---@module "chatgpt"
  "jackMort/ChatGPT.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "folke/trouble.nvim", { "nvim-telescope/telescope.nvim", lazy = true } },

  cmd = { "ChatGPT", "ChatGPTRun", "ChatGPTActAs", "ChatGPTCompleteCode", "ChatGPTEditWithInstructions" },
  keys = {
    { "<LEADER>c", "<NOP>", mode = { "n", "x" }, desc = "+ChatGPT" },
    { "<LEADER>cc", "<CMD>ChatGPT<CR>",                     mode = { "n", "x" }, desc = "ChatGPT" },
    { "<LEADER>ci", "<CMD>ChatGPTEditWithInstructions<CR>", mode = { "n", "x" }, desc = "ChatGPTEditWithInstructions" },
    { "<LEADER>ca", "<CMD>ChatGPTActAs<CR>",                mode = { "n", "x" }, desc = "ChatGPTActAs" },
    { "<LEADER>cr", ":ChatGPTRun ",                         mode = { "n", "x" }, desc = "ChatGPTRun" },
  },

  opts = {
    api_key_cmd  = ([[zsh -c "%s"]]):format(fvim.settings.openai.api_path),
    api_host_cmd = ([[zsh -c "%s"]]):format(fvim.settings.openai.host_path),

    yank_register     = "+",
    extra_curl_params = nil,
    show_line_numbers = true,

    edit_with_instructions = {
      diff = true,
      keymaps = {
        close  = "<C-c>",
        accept = "<C-y>",
        yank   = "<C-g>",

        toggle_diff     = "<C-d>",
        toggle_settings = "<C-o>",
        toggle_help     = "<C-h>",

        cycle_windows       = "<Tab>",
        use_output_as_input = "<C-i>",
      },
    },

    chat = {
      welcome_message = nil,  -- Use default.
      loading_text    = nil,  -- Use default.

      question_sign     = "🙂",
      answer_sign       = "🤖",
      border_left_sign  = nil,  -- Use default.
      border_right_sign = nil,  -- Use default.

      max_line_length = 120,

      sessions_window = {
        active_sign       = nil,  -- Use default.
        inactive_sign     = nil,  -- Use default.
        current_line_sign = nil,  -- Use default.

        border = {
          style = "rounded",
          text = { top = " Sessions " },
        },

        win_options = nil,  -- Use default.
      },

      keymaps = {
        close = "<C-c>",

        yank_last      = "<C-y>",
        yank_last_code = "<C-g>",

        scroll_up   = "<C-b>",
        scroll_down = "<C-f>",

        new_session = "<C-n>",

        cycle_windows = "<Tab>",
        cycle_modes   = "<C-m>",

        next_message = "<Down>",
        prev_message = "<Up>",

        select_session = "<Space>",
        rename_session = "r",
        delete_session = "d",

        draft_message  = "<C-d>",
        edit_message   = "e",
        delete_message = "d",

        toggle_settings         = "<C-o>",
        toggle_sessions         = "<C-p>",
        toggle_message_role     = "<C-r>",
        toggle_help             = "<C-h>",
        toggle_system_role_open = "<C-s>",

        stop_generating = "<C-x>",
      },
    },

    popup_layout = {
      relative = "center",
      center = { width = "85%", height = "85%" },
      right = { width = "30%", width_settings_open = "50%" },
    },

    popup_window = {
      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = { top = " ChatGPT " },
      },

      win_options = {
        wrap = true,
        linebreak = true,
        foldcolumn = "1",
        winhighlight = nil,  -- Use default.
      },

      buf_options = { filetype = "markdown" },

      system_window = {
        border = {
          highlight = "FloatBorder",
          style = "rounded",
          text = { top = " SYSTEM " },
        },

        win_options = {
          wrap = true,
          linebreak = true,
          foldcolumn = "2",
          winhighlight = nil,  -- Use default.
        },
      },
    },

    popup_input = {
      prompt = nil,  -- Use default icon.

      border = {
        highlight = "FloatBorder",
        style = "rounded",
        text = { top_align = "center", top = " Prompt " },
      },

      win_options = nil,  -- Use default.

      submit   = { "<C-Enter>", "<Enter>" },
      submit_n = { "<C-Enter>", "<Enter>" },

      max_visible_lines = 20,
    },

    settings_window = {
      setting_sign = nil,  -- Use default icon.

      border = {
        style = "rounded",
        text = { top = " Settings " },
      },

      win_options = nil,  -- Use default.
    },

    help_window = {
      setting_sign = nil,  -- Use default icon.
      border = {
        style = "rounded",
        text = { top = " Help " },
      },
      win_options = nil,  -- Use default.
    },

    openai_params = {
      model = openai_model,
      frequency_penalty = 0,
      presence_penalty = 0,
      max_tokens = 4096,
      temperature = 1,
      top_p = 1,
      n = 1,
    },

    openai_edit_params = {
      model = openai_model,
      frequency_penalty = 0,
      presence_penalty = 0,
      temperature = 0,
      top_p = 1,
      n = 1,
    },

    use_openai_functions_for_edits = true,

    actions_paths = nil,
    show_quickfixes_cmd = "Trouble quickfix",
    predefined_chat_gpt_prompts = nil,  -- Use default.

    highlights = nil,  -- Use default.
  },
}
