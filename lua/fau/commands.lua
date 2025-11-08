-- ==================== Commands ====================
-- DESC: Open fau_vim config directory.
vim.api.nvim_create_user_command("FauvimConfig",
  function()
    vim.api.nvim_command("chdir " .. fvim.nvim_config_path)
    require("nvim-tree.api").tree.focus()
  end, {}
)

-- DESC: Copy pyproject.toml file
vim.api.nvim_create_user_command("GetPyprojectFile",
  function()
    vim.api.nvim_command(string.format("!cp %s/configuration/pyproject.toml .", fvim.nvim_config_path))
  end, {}
)


-- ==================== Keymaps ====================
vim.keymap.set("n", "<LEADER>E",  "<Nop>",                 { desc = "+Edit" })
vim.keymap.set("n", "<LEADER>Ec", "<CMD>FauvimConfig<CR>", { desc = "fau_vim: Config" })
