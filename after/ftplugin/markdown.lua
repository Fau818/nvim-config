if vim.bo.buftype ~= "" then return end

if vim.b.fvim_markdown_ftplugin_loaded then return end
vim.b.fvim_markdown_ftplugin_loaded = true

-- vim.opt_local.spell = true
-- vim.opt_local.spelllang = "en_us"


-- ==================== Markdown Highlight Group ====================
local ns = vim.api.nvim_create_namespace("markdown_custom_hl")

if not vim.g.markdown_hl_set then
  if fvim and fvim.colors then
    vim.api.nvim_set_hl(ns, "@markup.strong", { fg = fvim.colors.pink, bold = true })
    vim.api.nvim_set_hl(ns, "@markup.italic", { fg = fvim.colors.light_red, bold = true, italic = true })
  end
  vim.g.markdown_hl_set = true
end

vim.api.nvim_win_set_hl_ns(0, ns)


-- =============================================
-- ========== NOTE: The content below is highly in experimental.
-- =============================================

-- TODO1: Move skip one empty line
-- TODO2: Formatter, for lines

local function is_concealed()
  for _, cap in ipairs(vim.treesitter.get_captures_at_cursor()) do
    if cap == "conceal" then return true end
  end
  return false
end

local function skip_conceal(dir)
  local max = 50 -- 防止死循环
  local i = 0
  while is_concealed() and i < max do
    vim.cmd("normal! " .. dir)
    i = i + 1
  end
end

vim.keymap.set("n", "l", function()
  vim.cmd("normal! l")
  skip_conceal("l")
end, { buffer = false })

vim.keymap.set("n", "h", function()
  vim.cmd("normal! h")
  skip_conceal("h")
end, { buffer = false })


-- ==================== Markdown Keymaps ====================
-- NOTE: Smart `w` to skip concealed regions.
-- local function is_in_conceal_region()
--   local bufnr = vim.api.nvim_get_current_buf()
--   local cursor = vim.api.nvim_win_get_cursor(0)
--   local row, col = cursor[1] - 1, cursor[2]  -- 0-based indexing
--
--   -- Check markdown_inline parser
--   local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "markdown_inline")
--   if not ok or not parser then return false end
--
--   -- Get the syntax tree
--   local tree = parser:parse()[1]
--   if not tree then fvim.notify("Treesitter parse failed", vim.log.levels.WARN) return false end
--
--   -- Get the node at the cursor position
--   local node = tree:root():named_descendant_for_range(row, col, row, col)
--   if not node then return false end
--
--   -- Get node type and parent type
--   local node_type = node:type()
--   local parent = node:parent()
--   local parent_type = parent and parent:type() or ""
--
--   -- Check if the node or its parent is a conceal type
--   local conceal_types = {
--     "strong_emphasis", "emphasis", "strikethrough",
--     "uri_autolink", "inline_link", "shortcut_link",
--   }
--   for _, t in ipairs(conceal_types) do
--     if node_type == t or parent_type == t then return true end
--   end
--
--   return false
-- end
--
-- local function smart_w()
--   if vim.wo.conceallevel > 0 and is_in_conceal_region() then return "W" end
--   return "w"
-- end
--
-- vim.keymap.set({ "n" }, "w", smart_w, { buffer = true, expr = true, desc = "Smart w: Skip Concealed Regions" })
