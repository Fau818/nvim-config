vim.cmd.runtime("after/ftplugin/all.lua")

vim.bo.commentstring = "# %s"

if not vim.lsp.is_enabled("surge") and vim.fn.executable(vim.lsp.config.surge.cmd[1]) == 1 then fvim.lsp.setup_server("surge") end


-- DESC: `gx` opens the URL under the cursor.
-- NOTE: A URL ends at a comma; the default `gx` reads `RULE-SET,https://…` as one file name.
vim.keymap.set("n", "gx", function()
  local col = vim.fn.col(".")
  for from, url, to in vim.api.nvim_get_current_line():gmatch("()(%a[%w+.-]*://[^,%s\"]+)()") do
    if from <= col and col < to then return vim.ui.open(url) end
  end
end, { buffer = true, desc = "Open the URL under the cursor" })
