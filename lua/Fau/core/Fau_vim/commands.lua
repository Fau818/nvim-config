-- -----------------------------------
-- -------- Edit Configuration
-- -----------------------------------
vim.api.nvim_create_user_command("EditConfiguration",
  function()
    vim.api.nvim_command(string.format("edit %s/configuration", Fau_vim.config_path))
  end, {}
)


-- -----------------------------------
-- -------- Configuration
-- -----------------------------------
vim.api.nvim_create_user_command("FauvimConfig",
  function()
    vim.api.nvim_command("chdir " .. Fau_vim.config_path)
    require("nvim-tree.api").tree.focus()
  end, {}
)


-- -----------------------------------
-- -------- Copy pyproject.toml file
-- -----------------------------------
vim.api.nvim_create_user_command("GetPyprojectFile",
  function()
    vim.api.nvim_command("!cp " .. Fau_vim.config_path .. "/configuration/pyproject.toml" .. " .")
  end, {}
)


-- -----------------------------------
-- -------- keymaps
-- -----------------------------------
vim.keymap.set("n", "<LEADER>E",  "<Nop>",                      { silent = true, desc = "Edit" })
vim.keymap.set("n", "<LEADER>Ec", "<CMD>EditConfiguration<CR>", { silent = true, desc = "Fau_vim: Edit Configuration" })
vim.keymap.set("n", "<LEADER>Es", "<CMD>EditSnip<CR>",          { silent = true, desc = "Fau_vim: Edit Snippet" })
