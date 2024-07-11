local cmp     = require("cmp")
local luasnip = require("luasnip")


--- Whether the copilot suggestion is visible.
--- @return boolean
local function copilot_is_visable()
  if not Fau_vim.plugin.copilot.enable then return false end
  return require("copilot.suggestion").is_visible()
end

--- Accept the copilot suggestion.
local function copilot_accept() require("copilot.suggestion").accept() end

--- Manually tabout!
local function jumpout()
  local flag, tabout = pcall(require, "tabout")
  if flag then tabout.tabout() end
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
        elseif copilot_is_visable() then copilot_accept()
        -- BUG: `fallback` function sometimes does not work.
        else jumpout()
        -- else fallback()
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
