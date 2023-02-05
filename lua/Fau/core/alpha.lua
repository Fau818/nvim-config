-- =============================================
-- ========== Plugin Loading
-- =============================================
local alpha_ok, alpha = pcall(require, "alpha")
if not alpha_ok then Fau_vim.load_plugin_error("alpha") return end



-- =============================================
-- ========== Configuration
-- =============================================
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[]],
	[[]],
	[[]],
	[[]],
	[[]],
	[[]],
	[[]],
	[[ ________                               __               ]],
	[[|        \                             |  \              ]],
	[[| $$$$$$$$______   __    __  __     __  \$$ ______ ____  ]],
	[[| $$__   |      \ |  \  |  \|  \   /  \|  \|      \    \ ]],
	[[| $$  \   \$$$$$$\| $$  | $$ \$$\ /  $$| $$| $$$$$$\$$$$\]],
	[[| $$$$$  /      $$| $$  | $$  \$$\  $$ | $$| $$ | $$ | $$]],
	[[| $$    |  $$$$$$$| $$__/ $$   \$$ $$  | $$| $$ | $$ | $$]],
	[[| $$     \$$    $$ \$$    $$    \$$$   | $$| $$ | $$ | $$]],
	[[ \$$      \$$$$$$$  \$$$$$$      \$     \$$ \$$  \$$  \$$]],
	[[                                                         ]],
	[[]],
	[[]],
	[[]],
	[[]],
}
dashboard.section.buttons.val = {
	dashboard.button("n", Fau_vim.icons.ui.NewFile .. "  New File", "<CMD>enew<CR>"),

	dashboard.button("p", Fau_vim.icons.ui.Project  .. "  Projects",     "<CMD>Telescope projects layout_strategy=center sorting_strategy=ascending initial_mode=normal<CR>"),
	dashboard.button("f", Fau_vim.icons.ui.FindFile .. "  Find Files",   "<CMD>Telescope find_files<CR>"),
	dashboard.button("r", Fau_vim.icons.ui.History  .. "  Recent Files", "<CMD>Telescope oldfiles<CR>"),
	dashboard.button("t", Fau_vim.icons.ui.FindText .. "  Find Text",    "<CMD>Telescope live_grep<CR>"),

	dashboard.button("l", Fau_vim.icons.ui.Restore .. "  Load Session",      "<CMD>lua require('persistence').load()<CR>"),
	dashboard.button("L", Fau_vim.icons.ui.Restore .. "  Load Last Session", "<CMD>lua require('persistence').load({ last = true })<CR>"),

	dashboard.button("c", Fau_vim.icons.ui.Gear .. "  Configuration", "<CMD>FauvimConfig<CR>"),

	dashboard.button("q", Fau_vim.icons.ui.Exit	.. "  Quit", "<CMD>qa<CR>"),
}

-- dashboard.config.opts.autostart = false
-- local handle = io.popen("fortune")
-- if handle == nil then return end
-- local fortune = handle:read("*a")
-- handle:close()
-- dashboard.section.footer.val = fortune
-- dashboard.config.opts.noautocmd = true
-- vim.cmd [[autocmd User AlphaReady echo 'ready']]


alpha.setup(dashboard.config)
