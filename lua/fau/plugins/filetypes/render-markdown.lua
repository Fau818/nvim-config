---@type LazySpec
return {
  ---@module "render-markdown"
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  cmd = { "RenderMarkdown" },
  ft = { "markdown" },

  ---@type render.md.UserConfig
  opts = {
    enabled = true,
    render_modes = { "n", "c", "t" },
    debounce = fvim.settings.debounce.highlight,

    preset = "none",

    -- log_level = "error",
    -- log_runtime = false,

    file_types = { "markdown" },
    max_file_size = fvim.file.large_file_size / 1024 / 1024,  -- in MB
    ignore = function(buf) return vim.bo[buf].buftype ~= "" end,

    nested = true,
    -- change_events = {},  -- Use default.
    restart_highlighter = false,
    injections = nil,  -- Use default.
    patterns = nil,  -- Use default.

    anti_conceal = {
      enabled = true,
      disabled_modes = false,
      above = 0,
      below = 0,
      ignore = {
        code_background = true,
        indent = true,
        sign = true,
        virtual_lines = true,
        table_border = true,
      },
    },

    padding = { highlight = "Normal" },

    latex = {
      enabled = true,
      render_modes = false,

      -- converter = { "utftex", "latex2text" },
      -- highlight = "RenderMarkdownMath",
      position = "center",
      top_pad = 0,
      bottom_pad = 0,
    },

    -- on = {
    --   attach = function() end,
    --   initial = function() end,
    --   render = function() end,
    --   clear = function() end,
    -- },

    completions = {
      blink = { enabled = true },
      coq = { enabled = false },
      lsp = { enabled = true },
      -- filter = {
      --   callout = function() return true end,
      --   checkbox = function() return true end,
      -- },
    },

    heading = {
      enabled = true,
      render_modes = false,
      atx = true,
      setext = true,
      sign = true,
      -- icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      position = "overlay",
      -- signs = { "󰫎 " },
      width = "full",
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

    paragraph = {
      enabled = true,
      render_modes = false,
      left_margin = 0,
      indent = 0,
      min_width = 0,
    },

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
      width = "full",
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,

      border = "hide",
      -- language_border = "█",  -- Use default.
      language_left = "",
      language_right = "",
      -- above = "▄",  -- Use default.
      -- below = "▀",  -- Use default.

      inline = true,
      inline_left = "",
      inline_right = "",
      inline_pad = 0,
      -- highlight = "RenderMarkdownCode",
      -- highlight_info = "RenderMarkdownCodeInfo",
      -- highlight_language = nil,
      -- highlight_border = "RenderMarkdownCodeBorder",
      -- highlight_fallback = "RenderMarkdownCodeFallback",
      -- highlight_inline = "RenderMarkdownCodeInline",
      style = "full",
    },

    dash = {
      enabled = true,
      render_modes = false,

      -- icon = "─",
      width = "full",
      left_margin = 0,
      -- highlight = "RenderMarkdownDash",
    },

    document = {
      enabled = true,
      render_modes = false,
      -- conceal = {
      --   char_patterns = {},
      --   line_patterns = {},
      -- },
    },

    bullet = {
      enabled = true,
      render_modes = false,

      icons = { "●", "○", "◆", "◇" },
      ordered_icons = nil,  -- Use default.
      left_pad = 0,
      right_pad = 0,
      -- highlight = "RenderMarkdownBullet",
      -- scope_highlight = {},
      -- scope_priority = nil,
    },

    checkbox = {
      enabled = true,
      render_modes = false,

      bullet = false,
      left_pad = 0,
      right_pad = 1,

      unchecked = nil,  -- Use default.
      checked   = nil,  -- Use default.
      custom    = nil,  -- Use default.

      scope_priority = nil,
    },

    quote = {
      enabled = true,
      render_modes = false,
      -- icon = "▋",  -- Use default.
      repeat_linebreak = false,
      -- highlight = nil,  -- Use default.
    },

    pipe_table = {
      enabled = true,
      render_modes = false,

      preset = "heavy",
      cell = "padded",
      cell_offset = function() return 0 end,
      padding = 1,
      min_width = 0,

      -- border = nil,  -- Use default.
      border_enabled = true,
      border_virtual = false,
      -- alignment_indicator = "━",
      -- head = "RenderMarkdownTableHead",
      -- row = "RenderMarkdownTableRow",
      -- filler = "RenderMarkdownTableFill",
      style = "full",
    },

    callout = nil,  -- Use default.

    link = {
      enabled = true,
      render_modes = false,

      footnote = {
        enabled = true,
        -- icon = "󰯔 ",
        superscript = true,
        prefix = "",
        suffix = "",
      },
      -- image = "󰥶 ",
      -- email = "󰀓 ",
      -- hyperlink = "󰌹 ",
      -- highlight = "RenderMarkdownLink",
      wiki = nil,  -- Use default.
      custom = nil,  -- Use default.
    },

    sign = {
      enabled = true,
      -- highlight = "RenderMarkdownSign",
    },

    inline_highlight = {
      enabled = true,
      render_modes = false,
      -- highlight = "RenderMarkdownInlineHighlight",
      custom = {},
    },

    indent = {
      enabled = false,
      render_modes = false,

      per_level = 2,
      skip_level = 1,
      skip_heading = false,
      -- icon = "▎",
      priority = 0,
      -- highlight = "RenderMarkdownIndent",
    },

    html = {
      enabled = true,
      render_modes = false,
      comment = {
        conceal = true,
        text = nil,
        -- highlight = "RenderMarkdownHtmlComment",
      },
      tag = {},
    },

    win_options = {
      conceallevel = {
        default = vim.o.conceallevel,
        rendered = 3,
      },
      concealcursor = {
        default = vim.o.concealcursor,
        rendered = "",
      },
    },

    -- overrides = {
    --   buflisted = {},
    --   buftype = {
    --     nofile = {
    --       render_modes = true,
    --       padding = { highlight = "NormalFloat" },
    --       sign = { enabled = false },
    --     },
    --   },
    --   filetype = {},
    --   preview = { render_modes = true },
    -- },

    custom_handlers = {
      -- Mapping from treesitter language to user defined handlers.
      -- @see [Custom Handlers](doc/custom-handlers.md)
    },

    yaml = { enabled = true, render_modes = false },
  },
}
