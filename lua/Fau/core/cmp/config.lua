local cmp     = require("cmp")
local luasnip = require("luasnip")
local mapping = require("Fau.core.cmp.mapping")


return {
  -- -----------------------------------
  -- -------- Global
  -- -----------------------------------
  ---@type cmp.ConfigSchema
  global = {
    enabled = function()
      if vim.bo.filetype == "TelescopePrompt" then return false end
      return not Fau_vim.functions.utils.is_large_file()
    end,

    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end }, -- for loading custom snippets of luasnip

    performance = {
      debounce = 100,         -- popup menu delay
      throttle = 50,          -- refresh delay
      fetching_timeout = 500, -- fetching timeout
      async_budget = 250,
      max_view_entries = 100,
    },

    view = { entries = "custom" },

    completion = {
      autocomplete = { "InsertEnter", "TextChanged" },
      completeopt = "menu,menuone,noinsert",
      -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
      -- keyword_length = 1,
      -- get_commit_characters = function() end,
    },

    confirmation = {
      -- default_behavior = "insert",
      default_behavior = "insert",
      -- get_commit_characters = ...,
    },
    preselect = cmp.PreselectMode.item,

    mapping = mapping.global,

    formatting = {
      expandable_indicator = true,         -- Boolean to show the `~` expandable indicator in cmp's floating window.
      fields = { "kind", "abbr", "menu" }, -- An array of completion fields to specify their order.
      format = function(entry, vim_item)   -- The function used to customize the appearance of the completion menu.
        vim_item.kind = Fau_vim.icons.kind[vim_item.kind]
        vim_item.menu = ({
          copilot = "[Copilot]",
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",

          gitcommit = "[Git]",
          zsh = "[ZSH]",
          calc = "[Calc]",

          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]

        -- limit the length of abbr
        vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, 30)
        return vim_item
      end,
    },

    matching = {
      disallow_fuzzy_matching         = false,
      disallow_fullfuzzy_matching     = false,
      disallow_partial_fuzzy_matching = false,
      disallow_partial_matching       = false,
      disallow_prefix_unmatching      = false,
    },

    -- sorting = {
    --   comparators = ...,
    --   priority_weight = ...,
    -- },

    sources = { -- The order of the sources determines their order in the completion results.
      { name = "copilot" },
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "gitcommit" },
      { name = "zsh" },
      { name = "calc" },

      { name = "buffer" },
      { name = "path" },
    },

    window = {
      completion    = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    experimental = { ghost_text = true },
  },


  -- -----------------------------------
  -- -------- cmdline
  -- -----------------------------------
  ---@type cmp.ConfigSchema
  cmdline = {
    enabled = true,
    completion = {
      autocomplete = false,
      completeopt = "menu,menuone,noselect",
    },

    mapping = mapping.cmdline,
    sources = {
      { name = "cmdline" },
      { name = "path" },
    }
  },


  -- -----------------------------------
  -- -------- Search
  -- -----------------------------------
  ---@type cmp.ConfigSchema
  search = {
    enabled = true,
    completion = {
      autocomplete = false,
      completeopt = "menu,menuone,noselect",
    },

    mapping = mapping.search,
    sources = { { name = "buffer" }, }
  },

}
