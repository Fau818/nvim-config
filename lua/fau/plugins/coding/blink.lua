---@type LazySpec
return {
  ---@module "blink.cmp"
  "saghen/blink.cmp",
  version = "1.*",
  -- build = "cargo build --release",
  dependencies = {
    ---@module "nvim-autopairs"
    "windwp/nvim-autopairs" ,
    ---@module "nvim-ts-autotag"
    "windwp/nvim-ts-autotag",

    ---@module "colorful-menu"
    "xzbdmw/colorful-menu.nvim",

    "disrupted/blink-cmp-conventional-commits",

    ---@module "blink-cmp-env"
    "bydlw98/blink-cmp-env",

    { "Kaiser-Yang/blink-cmp-dictionary", dependencies = "nvim-lua/plenary.nvim" },

    -- {
    --   ---@module "blink-copilot"
    --   "fang2hou/blink-copilot",
    --   dependencies = "zbirenbaum/copilot.lua",
    --   enabled = false,
    --   ---@type Config
    --   opts = { max_completions = 2, max_attempts = 2 },
    -- },
  },

  event = { "InsertEnter", "CmdlineEnter", "LspAttach" },

  ---@type blink.cmp.Config
  opts = {
    enabled = function() return vim.bo.filetype ~= "copilot-chat" and not fvim.utils.is_large_file() end,

    keymap = {
      preset = "none",
      -- ["<TAB>"] = { "accept", "snippet_forward", "fallback" },
      ["<TAB>"] = {
        function(cmp)
          ---Accept the copilot suggestion if it's visible
          ---@return boolean
          local function copilot_is_visible()
            local copilot_ok, copilot = pcall(require, "copilot.suggestion")
            return copilot_ok and copilot.is_visible() ~= nil
          end

          if cmp.is_menu_visible() then return cmp.accept()
          elseif cmp.snippet_active() then return cmp.snippet_forward()
          elseif copilot_is_visible() then return pcall(function() require("copilot.suggestion").accept() end)
          else
            local tabout_ok, tabout = pcall(require, "tabout")
            vim.schedule(function() pcall(function() tabout.tabout() end) end)
            return tabout_ok
          end
        end,
        "fallback"
      },
      ["<S-TAB>"] = { "select_prev", "fallback" },
      ["<CR>"]    = { "snippet_forward", "fallback" },

      ["<Up>"]   = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<ESC>"] = { "hide", "fallback" },
      ["<C-c>"] = { "cancel", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide" },

      ["<C-p>"] = { "show_signature", "hide_signature", "fallback" },

      ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
    },

    completion = {
      keyword = { range = "prefix" },
      trigger =  nil,  -- Use default.
      list = { selection = { preselect = true, auto_insert = false } },
      accept = nil,  -- Use default.

      menu = {
        auto_show = true,
        -- BUG: If set `auto_show_delay_ms`, Neovim may crash when typing. !!!
        -- auto_show_delay_ms = 250,
        border = "rounded",
        draw = {
          padding = { 1, 1 },
          columns = { { "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "source_name" } },
          components = {
            source_name = { text = function(ctx) return "[" .. ctx.source_name .. "]" end, highlight = "BlinkCmpKindDefault" },
            label = {
              text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
              highlight = function(ctx) return require("colorful-menu").blink_components_highlight(ctx) end,
            },
          },
        },
      },

      documentation = { auto_show = true, window = { border = "rounded" } },

      ghost_text = { enabled = true, show_with_selection = true, show_without_selection = false, show_with_menu = true, show_without_menu = false },
    },

    signature = { enabled = true, window = { border = "single" } },
    -- TODO: Configure it.
    snippet = nil,  -- Use default.

    appearance = { kind_icons = fvim.icons.kinds },
    fuzzy = nil,  -- Use default.

    sources = {
      default = {
        -- "copilot",
        "lsp",
        "snippets",
        "env", "path",
        "buffer", "dictionary",
      },
      per_filetype = {
        lua       = { inherit_defaults = true, "lazydev" },
        gitcommit = { inherit_defaults = true, "commits" },
      },
      providers = {
        commits = { name = "Git", module = "blink-cmp-conventional-commits", score_offset = 15, async = true },
        snippets = { score_offset = 10 },

        copilot = { name = "Copilot", module = "blink-copilot", score_offset = 9, async = true },

        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 8 },
        lsp = { score_offset = 8 },
        env = { name = "Env", module = "blink-cmp-env", score_offset = 8, async = true },

        buffer = { score_offset = 3 },
        dictionary = {
          name = "Dict", module = "blink-cmp-dictionary",
          min_keyword_length = 2, max_items = 15, score_offset = -5,
          opts = { dictionary_files = { fvim.nvim_config_path .. "/spell/mydict.txt", fvim.nvim_config_path .. "/spell/dictionary.txt" } },
        },
      },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "hide" },

        ["<TAB>"]   = { "show_and_insert", "select_next", "fallback" },
        ["<S-TAB>"] = { "show_and_insert", "select_prev", "fallback" },
        ["<Up>"]    = { "select_prev", "fallback" },
        ["<Down>"]  = { "select_next", "fallback" },

        -- ["<ESC>"] = { "hide", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
      },

      completion = {
        trigger = nil,  -- Use default.
        menu = { auto_show = true },
        list = { selection = { preselect = false, auto_insert = true } },
        ghost_text = nil,  -- Use default.
      },

      sources = { "cmdline", "buffer" },
    },

    term = { enabled = false },
  },

  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- ==================== Copilot Auto Hide ====================
    if require("blink.cmp.config").completion.ghost_text.enabled then
      local copilot_status, _ = pcall(require, "copilot")
      if not copilot_status then return end

      local suggestion = require("copilot.suggestion")
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          vim.b.copilot_suggestion_hidden = true
          suggestion.dismiss()
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
          vim.defer_fn(function() suggestion.update_preview() end, fvim.settings.debounce.copilot)
        end,
      })
    end
  end,
}
