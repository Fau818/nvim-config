-- -----------------------------------
-- -------- Edit Snippet
-- -----------------------------------
vim.api.nvim_create_user_command("EditSnip",
	function()
		require("luasnip.loaders").edit_snippet_files {
			extend = function(ft, paths)
				if #paths == 0 then return { { ft .. ".snippets",
					string.format("%s/snippets/%s.snippets", Fau_vim.config_path, ft) } } end
				return {}
			end
		}
	end, {}
)


-- -----------------------------------
-- -------- Edit Configuration
-- -----------------------------------
vim.api.nvim_create_user_command("EditConfiguration",
	function()
		vim.api.nvim_command("edit " .. Fau_vim.config_path .. "/configuration")
	end, {}
)


-- -----------------------------------
-- -------- Configuration
-- -----------------------------------
vim.api.nvim_create_user_command("FauvimConfig",
	function()
		vim.api.nvim_command("edit " .. Fau_vim.config_path)
		-- vim.api.nvim_command("NvimTreeToggle")
		-- vim.api.nvim_command("Alpha")
		-- vim.api.nvim_command("NvimTreeToggle")
	end, {}
)


-- -----------------------------------
-- -------- Copy pyproject.toml file
-- -----------------------------------
vim.api.nvim_create_user_command("GetpyprojectFile",
	function()
		vim.api.nvim_command("!cp " .. Fau_vim.config_path .. "/configuration/pyproject.toml" .. " .")
	end, {}
)
