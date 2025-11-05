vim.cmd.runtime("after/ftplugin/all.lua")

-- Set TodoSign highlights namespace.
if vim.bo.buftype == "" then fvim.colorscheme.set_todo_sign_hl_ns() end
