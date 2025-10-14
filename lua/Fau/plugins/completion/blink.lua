---@type LazySpec
return {
  "saghen/blink.cmp",
  version = "1.*",
  -- build = "cargo build --release",
  dependencies = {
    { "disrupted/blink-cmp-conventional-commits" },
    { "xzbdmw/colorful-menu.nvim", config = true },
    -- TODO: Move to `coding`?
    { "windwp/nvim-autopairs", config = function() require("Fau.configs.completion.autopairs") end },
    { "windwp/nvim-ts-autotag", config = function() require("Fau.configs.completion.autotag") end },
    { "RRethy/nvim-treesitter-endwise", dependencies = "nvim-treesitter/nvim-treesitter", ft = { "Ruby", "Lua", "Vimscript", "Bash", "Elixir", "Fish", "Julia" } },
  },
  event = { "InsertEnter", "CmdlineEnter" },

  -- init = function()
  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = "BlinkCmpMenuOpen",
  --     callback = function()
  --       require("copilot.suggestion").dismiss()
  --       vim.b.copilot_suggestion_hidden = true
  --     end,
  --   })

  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = "BlinkCmpMenuClose",
  --     callback = function()
  --       vim.b.copilot_suggestion_hidden = false
  --     end,
  --   })
  -- end,

  ---@module "blink.cmp"
  ---@type blink.cmp.Config
  opts = {
    enabled = function() return not Fau_vim.functions.utils.is_large_file() end,

    keymap = {
      preset = "none",
      -- ["<TAB>"] = { "accept", "snippet_forward", "fallback" },
      ["<TAB>"] = { function(cmp)
        ---Accept the copilot suggestion if it's visible
        ---@return boolean
        local function copilot_is_visable()
          if not Fau_vim.plugin.copilot.enable then return false end
          local copilot_ok, copilot = pcall(require, "copilot.suggestion")
          if not copilot_ok then return false end
          return copilot.is_visible() ~= nil
        end

        if cmp.is_menu_visible() then return cmp.accept()
        elseif cmp.snippet_active() then return cmp.snippet_forward()
        elseif copilot_is_visable() then return pcall(function() require("copilot.suggestion").accept() end)
        else return pcall(function() require("tabout").tabout() end)
        end
      end, "fallback" },
      ["<S-TAB>"] = { "select_prev", "fallback" },
      ["<CR>"]    = { "snippet_forward", "fallback" },

      ["<Up>"]   = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<ESC>"] = { "hide", "fallback" },
      ["<C-c>"] = { "cancel", "fallback" },

      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

      ["<C-p>"] = { "show_signature", "hide_signature", "fallback" },

      ["<C-f>"] = { "scroll_documentation_down", "scroll_signature_down", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "scroll_signature_up", "fallback" },
    },

    cmdline = {
      enabled = true,
      completion = {
        menu = { auto_show = true },
        list = { selection = { preselect = false, auto_insert = true } },
      },
      keymap = {
        preset = "none",

        ["<TAB>"]   = { "show_and_insert", "select_next", "fallback" },
        ["<S-TAB>"] = { "show_and_insert", "select_prev", "fallback" },
        ["<Up>"]    = { "select_prev", "fallback" },
        ["<Down>"]  = { "select_next", "fallback" },

        -- ["<ESC>"] = { "hide", "fallback" },
        ["<C-c>"] = { "cancel", "fallback" },
      },
    },

    appearance = { nerd_font_variant = "mono" },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      list = { selection = { preselect = true, auto_insert = false } },
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
      keyword = { range = "prefix" },
      ghost_text = { enabled = false },
    },

    signature = { enabled = true, window = { show_documentation = true, border = "single" } },

    sources = {
      default = { "lsp", "path", "snippets", "conventional_commits", "buffer" },
      per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        conventional_commits = {
          name = "GitCommit",
          module = "blink-cmp-conventional-commits",
          enabled = function() return vim.bo.filetype == "gitcommit" end,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  }
}
