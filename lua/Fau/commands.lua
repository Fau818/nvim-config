-- ==================== Commands ====================
-- DESC:
vim.api.nvim_create_user_command("FauvimConfig",
  function()
    vim.api.nvim_command("chdir " .. Fau_vim.config_path)
    require("nvim-tree.api").tree.focus()
  end, {}
)

-- DESC: Copy pyproject.toml file
vim.api.nvim_create_user_command("GetPyprojectFile",
  function()
    vim.api.nvim_command("!cp " .. Fau_vim.config_path .. "/configuration/pyproject.toml" .. " .")
  end, {}
)


-- ==================== Keymaps ====================
vim.keymap.set("n", "<LEADER>E",  "<Nop>",                 { desc = "+Edit" })
vim.keymap.set("n", "<LEADER>Ec", "<CMD>FauvimConfig<CR>", { desc = "Fau_vim: Config" })
