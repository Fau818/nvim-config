-- =============================================
-- ========== Plugin Loading
-- =============================================
local dropbar_ok, dropbar = pcall(require, "dropbar")
if not dropbar_ok then Fau_vim.load_plugin_error("dropbar") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  general = {
    ---@type boolean|fun(buf: integer, win: integer): boolean
    enable = function(buf, win)
      return not vim.api.nvim_win_get_config(win).zindex
          and vim.bo[buf].buftype == ""
          and vim.api.nvim_buf_get_name(buf) ~= ""
          and not vim.wo[win].diff
          and not Fau_vim.functions.utils.is_large_file(buf)
    end,
    update_interval = 50,
    -- opts.general.update_events = ...,
  },

  icons = {
    enable = true,
    -- TODO: Update icons
    kinds = {
      use_devicons = true,
      symbols = {
        Array = "󰅪 ",
        Boolean = " ",
        BreakStatement = "󰙧 ",
        Call = "󰃷 ",
        CaseStatement = "󱃙 ",
        Class = " ",
        Color = "󰏘 ",
        Constant = "󰏿 ",
        Constructor = " ",
        ContinueStatement = "→ ",
        Copilot = " ",
        Declaration = "󰙠 ",
        Delete = "󰩺 ",
        DoStatement = "󰑖 ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = "󰈔 ",
        Folder = "󰉋 ",
        ForStatement = "󰑖 ",
        Function = "󰊕 ",
        Identifier = "󰀫 ",
        IfStatement = "󰇉 ",
        Interface = " ",
        Keyword = "󰌋 ",
        List = "󰅪 ",
        Log = "󰦪 ",
        Lsp = " ",
        Macro = "󰁌 ",
        MarkdownH1 = "󰉫 ",
        MarkdownH2 = "󰉬 ",
        MarkdownH3 = "󰉭 ",
        MarkdownH4 = "󰉮 ",
        MarkdownH5 = "󰉯 ",
        MarkdownH6 = "󰉰 ",
        Method = "󰆧 ",
        Module = "󰏗 ",
        Namespace = "󰅩 ",
        Null = "󰢤 ",
        Number = "󰎠 ",
        Object = "󰅩 ",
        Operator = "󰆕 ",
        Package = "󰆦 ",
        Property = " ",
        Reference = "󰦾 ",
        Regex = " ",
        Repeat = "󰑖 ",
        Scope = "󰅩 ",
        Snippet = "󰩫 ",
        Specifier = "󰦪 ",
        Statement = "󰅩 ",
        String = "󰉾 ",
        Struct = " ",
        SwitchStatement = "󰺟 ",
        Text = " ",
        Type = " ",
        TypeParameter = "󰆩 ",
        Unit = " ",
        Value = "󰎠 ",
        Variable = "󰀫 ",
        WhileStatement = "󰑖 ",
      },
    },
    ui = {
      bar = {
        separator = "  ",
        extends = "…",
      },
      menu = {
        separator = " ",
        indicator = "  ",
      },
    },
  },
  -- symbol = ...,
  -- bar = ...,
  menu = {
    -- When on, preview the symbol under the cursor on CursorMoved
    preview = true,
    -- When on, automatically set the cursor to the closest previous/next
    -- clickable component in the direction of cursor movement on CursorMoved
    quick_navigation = true,
    entry = {
      padding = { left = 1, right = 1 },
    },
  },
  sources = {
    lsp = {
      request = {
        -- Times to retry a request before giving up
        ttl_init = 60,
        interval = 1000,       -- in ms
      },
    },
    markdown = {
      parse = {
        -- Number of lines to update when cursor moves out of the parsed range
        look_ahead = 200,
      },
    },
  },
}


dropbar.setup(config)
