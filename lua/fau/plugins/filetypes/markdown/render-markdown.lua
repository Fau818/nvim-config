-- FIX: Markdown sign icons are over git signs.
---@type LazyPluginSpec
return {
  ---@module "render-markdown"
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = { "RenderMarkdown" },
  ft = { "markdown" },
  keys = {
    { "<C-r>", "<CMD>RenderMarkdown buf_toggle<CR>", desc = "Toggle Render Markdown", buffer = true, ft = "markdown" },
  },

  ---@type render.md.UserConfig
  opts = {
    enabled = true,
    render_modes = { "n", "c", "t", "i", "v", "V", "\22" },

    debounce = fvim.settings.debounce.highlight,

    preset = "none",  ---@type "obsidian" | "lazy" | "none"

    -- log_level = "error",
    -- log_runtime = false,

    file_types = { "markdown" },
    max_file_size = fvim.file.large_file_size / 1024 / 1024,  -- in MB
    ignore = function(buf) return vim.bo[buf].buftype ~= "" end,

    nested = true,
    -- change_events = {},  -- Use default.
    restart_highlighter = false,
    -- injections = nil,  -- Use default.
    -- patterns = nil,  -- Use default.

    anti_conceal = {
      enabled = true,
      disabled_modes = { "n" },
      above = 0,
      below = 0,
      ignore = {
        bullet = true,
        code_background = true,
        sign = true,
      },
    },

    padding = { highlight = "Normal" },

    latex = {
      enabled = true,
      render_modes = false,
      position = "center",
      -- TEST: Add pad, on March 2, 2026
      top_pad = 1,
      bottom_pad = 1,
    },

    -- on = {
    --   attach = function() end,
    --   initial = function() end,
    --   render = function() end,
    --   clear = function() end,
    -- },

    completions = { blink = { enabled = true }, coq = { enabled = false }, lsp = { enabled = false } },

    heading = {
      enabled = true,
      render_modes = false,

      atx = true,
      setext = true,
      sign = true,

      -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- signs = { "󰫎 " },

      position = "overlay",  ---@type "right" | "inline" | "overlay"
      width = "full",  ---@type "full" | "block"

      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,

      border = true,
      border_virtual = true,
      border_prefix = false,

      -- above = "▄",
      -- below = "▀",
      -- backgrounds = nil,  -- Use default.
      -- foregrounds = nil,  -- Use default.
      -- custom = {},
    },

    paragraph = { enabled = true, render_modes = false, left_margin = 0, indent = 0, min_width = 0 },

    code = {
      enabled = true,
      render_modes = false,

      sign = true,
      conceal_delimiters = true,
      language = true,
      position = "left",
      language_icon = true,
      language_name = true,
      language_info = true,
      language_pad = 0,

      -- disable_background = { "diff" },  -- Use default.
      width = "full",  ---@type "full" | "block"
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,

      border = "hide",  ---@type "none" | "thick" | "thin" | "hide"

      -- language_border = "█",  -- Use default.
      -- language_left = "",
      -- language_right = "",

      -- above = "▄",  -- Use default.
      -- below = "▀",  -- Use default.

      inline = true,
      -- inline_left = "",
      -- inline_right = "",
      inline_pad = 0,

      -- highlight = "RenderMarkdownCode",
      -- highlight_info = "RenderMarkdownCodeInfo",
      -- highlight_language = nil,
      -- highlight_border = "RenderMarkdownCodeBorder",
      -- highlight_fallback = "RenderMarkdownCodeFallback",
      -- highlight_inline = "RenderMarkdownCodeInline",

      style = "full",  ---@type "none" | "normal" | "language" | "full"
    },

    dash = { enabled = true, render_modes = false },

    document = { enabled = true, render_modes = false },

    bullet = { enabled = true, render_modes = false },

    checkbox = {
      enabled = true,
      render_modes = false,

      bullet = false,
      left_pad = 0,
      right_pad = 1,

      unchecked = nil,  -- Use default.
      checked = {
        -- Replaces '[x]' of 'task_list_marker_checked'.
        -- icon = "󰱒 ",
        -- highlight = "RenderMarkdownChecked",
        scope_highlight = nil,
      },
      custom    = {
        bookmark = { raw = "[b]", rendered = " ", highlight = "RenderMarkdownInfo", scope_highlight = nil },
        tilde = { raw = "[~]", rendered = "󰜥 ", highlight = "RenderMarkdownWarn", scope_highlight = nil },
      },

      scope_priority = nil,
    },

    quote = { enabled = true, render_modes = false, repeat_linebreak = false },

    pipe_table = {
      enabled = true,
      render_modes = false,

      preset = "heavy",  ---@type "heavy" | "double" | "round" | "none"
    },

    callout = nil,  -- Use default.

    link = { enabled = true, render_modes = false },

    sign = { enabled = true, priority = fvim.settings.sign_priority.markdown, },

    inline_highlight = {
      enabled = true,
      render_modes = false,
      -- highlight = "RenderMarkdownInlineHighlight",
      custom = {},
    },

    indent = { enabled = false },

    html = {
      enabled = true,
      render_modes = false,
      comment = { conceal = true, text = nil },
      tag = {},
    },

    win_options = {
      conceallevel = {
        default = vim.o.conceallevel,
        rendered = 2,
      },
      concealcursor = {
        default = vim.o.concealcursor,
        rendered = "nc",
      },
    },

    custom_handlers = {
      -- Mapping from treesitter language to user defined handlers.
      -- @see [Custom Handlers](doc/custom-handlers.md)
    },

    yaml = { enabled = true, render_modes = false },
  },
}
