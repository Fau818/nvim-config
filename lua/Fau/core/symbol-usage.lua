-- =============================================
-- ========== Plugin Loading
-- =============================================
local symbol_usage_ok, symbol_usage = pcall(require, "symbol-usage")
if not symbol_usage_ok then Fau_vim.load_plugin_error("symbol-usage") return end



-- =============================================
-- ========== Configuration
-- =============================================
-- -----------------------------------
-- -------- Bubbles Style
-- -----------------------------------
local function h(name) return vim.api.nvim_get_hl(0, { name = name }) end

-- hl-groups can have any name
vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true, bold = true })
vim.api.nvim_set_hl(0, "SymbolUsageContent",  { bg = h("CursorLine").bg, fg = h("Comment").fg,    italic = true, bold = true })
vim.api.nvim_set_hl(0, "SymbolUsageRef",      { fg = h("Function").fg,   bg = h("CursorLine").bg, italic = true, bold = true })
vim.api.nvim_set_hl(0, "SymbolUsageDef",      { fg = h("Type").fg,       bg = h("CursorLine").bg, italic = true, bold = true })
vim.api.nvim_set_hl(0, "SymbolUsageImpl",     { fg = h("@keyword").fg,   bg = h("CursorLine").bg, italic = true, bold = true })

local function text_format(symbol)
  local res = {}

  local round_start = { "", "SymbolUsageRounding" }
  local round_end = { "", "SymbolUsageRounding" }

  -- Indicator that shows if there are any other symbols in the same line
  local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

  if symbol.references then
    local usage = symbol.references <= 1 and "usage" or "usages"
    local num = symbol.references == 0 and "no" or symbol.references
    table.insert(res, round_start)
    table.insert(res, { "󰌹 ", "SymbolUsageRef" })
    table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.definition then
    if #res > 0 then table.insert(res, { " ", "NonText" }) end
    table.insert(res, round_start)
    table.insert(res, { "󰳽 ", "SymbolUsageDef" })
    table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if symbol.implementation then
    if #res > 0 then table.insert(res, { " ", "NonText" }) end
    table.insert(res, round_start)
    table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
    table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  if stacked_functions_content ~= "" then
    if #res > 0 then table.insert(res, { " ", "NonText" }) end
    table.insert(res, round_start)
    table.insert(res, { " ", "SymbolUsageImpl" })
    table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
    table.insert(res, round_end)
  end

  return res
end


local config = {
  references = { enabled = true, include_declaration = false },
  definition = { enabled = true },
  implementation = { enabled = true },
  text_format = text_format,

  disable = {
    lsp = { "bashls" },
    cond = {
      function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
          if client.name ~= "copilot" then return vim.fn.expand("%:p"):find(client.root_dir, 1, true) == nil end
        end
      end,
    },
  },
}

symbol_usage.setup(config)
