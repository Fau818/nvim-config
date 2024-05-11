-- -----------------------------------
-- -------- Edit Snippet
-- -----------------------------------
vim.api.nvim_create_user_command("EditSnip",
  function()
    require("luasnip.loaders").edit_snippet_files({
      extend = function(ft, paths)
        if #paths == 0 then return { { ft .. ".snippets", string.format("%s/snippets/%s.snippets", Fau_vim.config_path, ft) } } end
        return {}
      end
    })
  end, {}
)


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
