local cmp     = require("cmp")
local luasnip = require("luasnip")


local function accept_copilot()
  if not Fau_vim.plugin.copilot.enable then return false end

  if require("copilot.suggestion").is_visible() then
    require("copilot.suggestion").accept()
    return true
  end
  return false
end


return {
  -- -----------------------------------
  -- -------- Global
  -- -----------------------------------
  global = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-2), { "i", "s" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(2),  { "i", "s" }),

    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c", "s" }),

    ["<ESC>"] = cmp.mapping(cmp.mapping.close(), { "i", "s" }),
    ["<C-c>"] = cmp.mapping(cmp.mapping.abort(), { "i", "c", "s" }),

    ["<TAB>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then cmp.confirm({ select=true })
        elseif luasnip.jumpable(1) then luasnip.jump(1)
        elseif not accept_copilot() then fallback()
        else fallback()
        end
      end, { "i", "s" }
    ),
    ["<S-TAB>"] = cmp.mapping(
      function(fallback)
        if luasnip.jumpable(-1) then luasnip.jump(-1)
        else fallback()
        end
      end, { "i", "s" }
    ),
    ["<CR>"] = cmp.mapping(
      function(fallback)
        if luasnip.jumpable(1) then while luasnip.jumpable(1) do luasnip.jump(1) end
        else fallback()
        end
      end, { "i", "s" }
    ),
    ["<C-Enter>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then cmp.confirm({ select=true })
        else fallback()
        end
      end, { "i", "s" }
    ),

    ["<UP>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then cmp.select_prev_item()
        else fallback()
        end
      end, { "i", "s", "c" }
    ),
    ["<DOWN>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then cmp.select_next_item()
        else fallback()
        end
      end, { "i", "s", "c" }
    ),
  },


  -- -----------------------------------
  -- -------- Cmdline
  -- -----------------------------------
  cmdline = {
    ["<TAB>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then cmp.select_next_item()
        else cmp.complete(); cmp.select_next_item()
        end
      end, { "c" }
    ),
  },


  -- -----------------------------------
  -- -------- Search
  -- -----------------------------------
  search = {
    ["<TAB>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then cmp.select_next_item()
        else cmp.complete()
        end
      end, { "c" }
    ),
    ["<UP>"] = cmp.mapping(function(fallback) fallback() end, { "c" }),
    ["<DOWN>"] = cmp.mapping(function(fallback) fallback() end, { "c" }),
  },
}
