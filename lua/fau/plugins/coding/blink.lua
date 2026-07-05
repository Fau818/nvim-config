---@type LazyPluginSpec
return {
  ---@module "blink.cmp"
  "saghen/blink.cmp",
  version = "1.*",
  -- build = "cargo build --release",
  dependencies = {
    ---@module "mini.pairs"
    "nvim-mini/mini.pairs",

    ---@module "nvim-ts-autotag"
    "windwp/nvim-ts-autotag",

    ---@module "colorful-menu"
    "xzbdmw/colorful-menu.nvim",

    "disrupted/blink-cmp-conventional-commits",

    ---@module "blink-cmp-env"
    "bydlw98/blink-cmp-env",

    { "Kaiser-Yang/blink-cmp-dictionary", dependencies = "nvim-lua/plenary.nvim" },

    ---@module "mini.snippets"
    "nvim-mini/mini.snippets",
  },

  event = { "InsertEnter", "CmdlineEnter", "LspAttach" },

  ---@type blink.cmp.Config
  opts = {
    enabled = function() return vim.bo.filetype ~= "copilot-chat" and not fvim.utils.is_large_file() end,

    keymap = {
      preset = "none",
      -- ["<TAB>"] = { "accept", "snippet_forward", "fallback" },
      ["<TAB>"] = {
        "accept", "snippet_forward",
        ---Copilot suggestion
        function()
          local copilot_ok, copilot = pcall(require, "copilot.suggestion")
          return copilot_ok and copilot.is_visible() ~= nil and pcall(copilot.accept)
        end,
        ---Tabout
        function()
          local tabout_ok, tabout = pcall(require, "tabout")
          vim.schedule(function() pcall(tabout.tabout) end)
          return tabout_ok
        end,
        "fallback"
      },
      ["<S-TAB>"] = { "select_prev", "snippet_backward", "fallback" },

      ["<CR>"]    = {
        function(cmp)
          if not cmp.snippet_active() then return false end
          local s = MiniSnippets.session.get()

          local function jump_to_final_tabstop()
            local hops, id = 0, s.cur_tabstop
            while id ~= "0" and hops < vim.tbl_count(s.tabstops) do id = s.tabstops[id].next hops = hops + 1 end
            for _ = 1, hops do vim.schedule(function() MiniSnippets.session.jump("next") end) end
          end

          local function stop_snippet()
            local final_node = nil
            for _, n in ipairs(s.nodes) do if n.tabstop == "0" then final_node = n break end end

            -- Read $0's position before stop() clears its extmark.
            local pos = nil
            if final_node and final_node.extmark_id then
              local m = vim.api.nvim_buf_get_extmark_by_id(s.buf_id, s.ns_id, final_node.extmark_id, { details = true })
              if m and m[1] then
                local d = m[3] or {}
                pos = { (d.end_row or m[1]) + 1, d.end_col or m[2] }
              end
            end

            vim.schedule(function()
              MiniSnippets.session.stop()
              if pos then pcall(vim.api.nvim_win_set_cursor, 0, pos) end
            end)
          end

          -- CASE1: If the current tabstop is not the final one ($0), jump to the final tabstop.
          -- CASE2: If the current tabstop is the final one ($0), stop the snippet session and move the cursor to the end of $0.
          if s.cur_tabstop ~= "0" then jump_to_final_tabstop() else stop_snippet() end

          return true
        end,
        "fallback"
      },

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
        auto_show_delay_ms = 0,
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

    snippets = {
      preset = "mini_snippets",

      -- HACK: Override the default jump behavior to skip the final tabstop ($0) if it's reached.
      jump = function(direction)
        if not _G.MiniSnippets then error("mini.snippets has not been setup") end
        local function mini_jump() MiniSnippets.session.jump(direction == -1 and "prev" or "next") end

        mini_jump()

        vim.schedule(function()
          local session = MiniSnippets.session.get()
          assert(session, "No active snippet session")
          if session.cur_tabstop == "0" then mini_jump() end
        end)
      end,
    },

    appearance = { kind_icons = fvim.icons.kinds },
    fuzzy = nil,  -- Use default.

    sources = {
      default = {
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
        path = { score_offset = 12 },
        snippets = {
          score_offset = 8,

          ---Don't offer snippets right after a member access (`field.xxx`, `obj:method`), or while inside a comment/string.
          should_show_items = function(ctx)
            local col = ctx.bounds.start_col
            local char_before = ctx.line:sub(col - 1, col - 1)
            if char_before == "." or char_before == ":" then return false end

            -- `ctx.cursor` sits right after the last typed char, i.e. past the end of that
            -- char's node range, so query one column to the left to catch its syntax context.
            local row, ccol = ctx.cursor[1] - 1, math.max(ctx.cursor[2] - 1, 0)
            for _, capture in ipairs(vim.treesitter.get_captures_at_pos(ctx.bufnr, row, ccol)) do
              if capture.capture:match("^comment") or capture.capture:match("^string") then return false end
            end

            return true
          end,

          ---Resolve snippet variables ($LINE_COMMENT, $TM_FILENAME, …) for the docs preview.
          transform_items = function(_, items)
            if not _G.MiniSnippets then return items end

            local function render(nodes)
              local out = {}
              for _, n in ipairs(nodes) do
                if n.text ~= nil then out[#out + 1] = n.text
                elseif n.placeholder ~= nil then out[#out + 1] = render(n.placeholder)
                end
              end
              return table.concat(out)
            end

            for _, item in ipairs(items) do
              local snip = item.data and item.data.snip  --[[@as { body: string|string[] }?]]
              local body = snip and snip.body
              if type(body) == "table" then body = table.concat(body, "\n") end
              if type(body) == "string" then
                local ok, nodes = pcall(MiniSnippets.parse, body, { normalize = true })
                if ok then item.detail = render(nodes) end
              end
            end
            return items
          end,
        },

        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 8 },
        lsp = {
          score_offset = 8,
          transform_items = function(_, items)
            if vim.api.nvim_get_current_line():match("^%s*@") then
              local Kind = require("blink.cmp.types").CompletionItemKind
              for _, item in ipairs(items) do
                if item.kind == Kind.Function or item.kind == Kind.Method then item.kind = Kind.Variable end
              end
            end
            return items
          end,
        },
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
      if not package.loaded["copilot"] then return end

      local group = vim.api.nvim_create_augroup("CopilotAutoDismiss", { clear = true })
      local suggestion = require("copilot.suggestion")
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "BlinkCmpMenuOpen",
        callback = function() vim.b.copilot_suggestion_hidden = true suggestion.dismiss() end,
      })

      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
          vim.defer_fn(function() suggestion.update_preview() end, fvim.settings.debounce.copilot)
        end,
      })
    end
  end,
}
