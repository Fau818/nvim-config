if not vim.g.vscode then vim.schedule(function() vim.opt_local.formatoptions = "tcqj" end)
else vim.opt_local.formatoptions = "tcqj"
end
