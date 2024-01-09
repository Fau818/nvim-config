-- =============================================
-- ========== Plugin Loading
-- =============================================
local chatgpt_ok, chatgpt = pcall(require, "chatgpt")
if not chatgpt_ok then Fau_vim.load_plugin_error("chatgpt") return end



-- =============================================
-- ========== Configuration
-- =============================================
local openai_model = "gpt-3.5-turbo-1106"

local config = {
  api_key_cmd = [[ zsh -c "$OPENAI_API_PATH/apikey" ]],
  yank_register = "+",

  edit_with_instructions = {
    diff = true,
    keymaps = {
      close               = "<C-c>",
      accept              = "<C-y>",

      toggle_diff         = "<C-d>",
      toggle_settings     = "<C-o>",
      toggle_help         = "g?",

      cycle_windows       = "<Tab>",
      use_output_as_input = "<C-i>",
    },
  },

  chat = {
    welcome_message = WELCOME_MESSAGE,
    loading_text = "Loading, please wait ...",

    question_sign     = "🙂",
    answer_sign       = "🤖",
    -- border_left_sign  = "",
    -- border_right_sign = "",

    max_line_length = 120,
    sessions_window = {
      -- active_sign = "  ",
      -- inactive_sign = "  ",
      -- current_line_sign = "",
      border = {
        style = "rounded",
        text = { top = " Sessions " },
      },
      win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder" },
    },

    keymaps = {
      close = "<C-c>",

      yank_last      = "<C-y>",
      yank_last_code = "<C-k>",

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
      toggle_help             = "g?",
      toggle_system_role_open = "<C-s>",

      stop_generating = "<C-x>",
    },
  },

  popup_layout = {
    relative = "center",
    center = {
      width  = "80%",
      height = "80%",
    },
    right = {
      width = "30%",
      width_settings_open = "50%",
    },
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
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
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
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
  },

  popup_input = {
    prompt = " " .. Fau_vim.icons.ui.Prompt .. " ",
    border = {
      highlight = "FloatBorder",
      style = "rounded",
      text = {
        top_align = "center",
        top = " Prompt ",
      },
    },
    win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder", },
    submit = { "<C-Enter>", "<Enter>" },
    submit_n = { "<C-Enter>", "<Enter>" },
    max_visible_lines = 20,
  },

  settings_window = {
    -- setting_sign = "  ",
    border = {
      style = "rounded",
      text = { top = " Settings " },
    },
    win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder", },
  },

  help_window = {
    -- setting_sign = "  ",
    border = {
      style = "rounded",
      text = { top = " Help ", },
    },
    win_options = { winhighlight = "Normal:Normal,FloatBorder:FloatBorder", },
  },

  openai_params = {
    model = openai_model,
    frequency_penalty = 0,
    presence_penalty = 0,
    max_tokens = 300,
    temperature = 0,
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

  use_openai_functions_for_edits = false,
  actions_paths = {},
  show_quickfixes_cmd = "Trouble quickfix",
  predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
  highlights = {
    help_key = "@symbol",
    help_description = "@comment",
  },
}


chatgpt.setup(config)
