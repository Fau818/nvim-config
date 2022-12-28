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
-- -------- Edit Style
-- -----------------------------------
vim.api.nvim_create_user_command("EditStyle",
	function()
		vim.api.nvim_command("edit " .. Fau_vim.config_path .. "/style")
	end, {}
)


-- -----------------------------------
-- -------- Configuration
-- -----------------------------------
vim.api.nvim_create_user_command("FauvimConfig",
	function()
		vim.api.nvim_command("edit " .. Fau_vim.config_path)
	end, {}
)
