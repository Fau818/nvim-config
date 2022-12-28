local terminal = {
	["<F1>"] = { "<CMD>lua Fau_vim.functions.terminal.float()<CR>",      "Toggle Float Terminal" },
	["<F2>"] = { "<CMD>lua Fau_vim.functions.terminal.horizontal()<CR>", "Toggle Horizontal Terminal" },
	["<F3>"] = { "<CMD>lua Fau_vim.functions.terminal.vertical()<CR>",   "Toggle Vertical Terminal" },
}

return {
	n = {
		terminal,

		["<LEADER>"] = {
			["gg"] = { "<CMD>lua Fau_vim.functions.terminal.lazygit()<CR>", "Toggle Lazygit" },
			["lg"] = { "<CMD>lua Fau_vim.functions.terminal.lazygit()<CR>", "Toggle Lazygit" },

			b = { "<CMD>lua Fau_vim.functions.terminal.btop()<CR>", "Toggle btop" },
		},
	},



	t = {
		terminal,

		-- ["<ESC>"] = { "<C-\\><C-n>", "Normal Mode" }
	}
}
