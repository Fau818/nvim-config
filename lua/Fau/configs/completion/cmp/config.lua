local cmp     = require("cmp")
local luasnip = require("luasnip")
local mapping = require("Fau.configs.completion.cmp.mapping")


return {
  -- -----------------------------------
  -- -------- Global
  -- -----------------------------------
  ---@type cmp.ConfigSchema
  global = {
    enabled = function()
      if vim.bo.filetype == "" or vim.bo.filetype == "TelescopePrompt" then return false end
      return not Fau_vim.functions.utils.is_large_file()
    end,

    snippet = { expand = function(args) luasnip.lsp_expand(args.body) end }, -- for loading custom snippets of luasnip

    performance = { async_budget = 20 },

    completion = {
      autocomplete = { "InsertEnter", "TextChanged" },
      completeopt = "menu,menuone,noinsert",
    },

    confirmation = {
      default_behavior = cmp.ConfirmBehavior.Insert,
      -- get_commit_characters = ...,
    },
    preselect = cmp.PreselectMode.item,

    mapping = mapping.global,

    formatting = {
      expandable_indicator = true,         -- Boolean to show the `~` expandable indicator in cmp's floating window.
      fields = { "kind", "abbr", "menu" }, -- An array of completion fields to specify their order.
      format = function(entry, vim_item)   -- The function used to customize the appearance of the completion menu.
        vim_item.kind = Fau_vim.icons.kind[vim_item.kind] or Fau_vim.icons.kind.Text
        vim_item.menu = ({
          luasnip  = "[Snippet]",
          copilot  = "[Copilot]",
          nvim_lsp = "[LSP]",

          conventionalcommits = "[Git]",

          calc = "[Calc]",

          treesitter = "[Treesitter]",
          buffer = "[Buffer]",
          path   = "[Path]",
        })[entry.source.name]

        -- limit the length of abbr
        vim_item.abbr = vim.fn.strcharpart(vim_item.abbr, 0, 35)
        return vim_item
      end,
    },

    matching = nil,

    ---@type cmp.SourceConfig[]
    sources = {
      { name = "luasnip" },
      { name = "copilot" },
      { name = "nvim_lsp" },

      { name = "conventionalcommits" },

      { name = "calc" },

      { name = "treesitter", max_item_count = 10 },
      { name = "buffer", max_item_count = 10 },
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
    sources = { { name = "cmdline" }, { name = "path" } }
  },


  -- -----------------------------------
  -- -------- Search
  -- -----------------------------------
  ---@type cmp.ConfigSchema
  search = {
    enabled = true,
    completion = {
      autocomplete = { "InsertEnter", "TextChanged" },
      completeopt = "menu,menuone,noselect",
    },

    mapping = mapping.search,
    sources = { { name = "buffer" } }
  },

}
