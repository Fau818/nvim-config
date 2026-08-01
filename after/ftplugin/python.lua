vim.cmd.runtime("after/ftplugin/all.lua")

if vim.bo.buftype ~= "" then return end
if fvim.python.library_root() then
  vim.bo.modifiable = false
  vim.bo.readonly = true
end
