-- ==================== Commands ====================
-- DESC: Open fau_vim config directory.
vim.api.nvim_create_user_command("FauvimConfig",
  function()
    vim.cmd.chdir(vim.fn.fnameescape(fvim.nvim_config_path))
    local ok, api = pcall(require, "nvim-tree.api")
    if ok then api.tree.focus()
    else fvim.notify("nvim-tree is not available", vim.log.levels.ERROR)
    end
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
