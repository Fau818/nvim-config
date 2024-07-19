if Fau_vim.plugin.trouble.tag and Fau_vim.plugin.trouble.tag:find("v2") then require("Fau.configs.editor.trouble.v2")
else require("Fau.configs.editor.trouble.v3")
end
