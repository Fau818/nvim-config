-- DESC: "Disable `K` to show hover document keymaps in `noice`.",
vim.b.markdown_keys = true


-- DESC: Better `gx` handling.
-- SEE: noice.nvim/lua/noice/text/markdown.lua:221
vim.keymap.set("n", "gx", function()
  local line = vim.api.nvim_get_current_line()
  local pos = vim.api.nvim_win_get_cursor(0)
  local col = pos[2] + 1

  for pattern, handler in pairs(require("noice.config").options.markdown.hover) do
    local from = 1; local to, url
    while from do
      ---@diagnostic disable-next-line: cast-local-type
      from, to, url = line:find(pattern, from)
      if from and col >= from and col <= to then return handler(url) end
      if from then from = to + 1 end
    end
  end

  return "gx"
end, { buffer = true, expr = true, desc = "Open link under cursor" })
