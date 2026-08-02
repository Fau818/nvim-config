-- ═════════════════════════ Commands ═════════════════════════

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

-- DESC: Re-pad separator comments. Takes a range; `!` applies the `---`/`===` shorthand
-- DESC: even in a file that draws its own rules in ASCII.
vim.api.nvim_create_user_command("NormalizeSeparators",
  function(ev)
    local from, to
    if ev.range > 0 then from, to = ev.line1 - 1, ev.line2 end
    fvim.format.normalize_separators(from, to, ev.bang)
  end, { bang = true, range = true }
)

-- DESC: Copy pyproject.toml file
vim.api.nvim_create_user_command("GetPyprojectFile",
  function()
    vim.api.nvim_command(string.format("!cp %s/configuration/pyproject.toml .", fvim.nvim_config_path))
  end, {}
)


-- ═════════════════════════ Keymaps ══════════════════════════

vim.keymap.set("n", "<LEADER>E",  "<Nop>",                 { desc = "+Edit" })
vim.keymap.set("n", "<LEADER>Ec", "<CMD>FauvimConfig<CR>", { desc = "fau_vim: Config" })
