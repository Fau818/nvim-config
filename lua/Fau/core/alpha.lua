-- =============================================
-- ========== Plugin Loading
-- =============================================
local alpha = Fau_vim.load_plugin("alpha")
if alpha == nil then return end



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
	dashboard.button("f", Fau_vim.ui.FindFile .. "  Find File",   "<CMD>Telescope find_files<CR>"),
	dashboard.button("n", Fau_vim.ui.NewFile .. "  New File",     "<CMD>ene!<CR>"),
	dashboard.button("p", Fau_vim.ui.Project .. "  Projects ",    "<CMD>Telescope projects layout_strategy=center sorting_strategy=ascending initial_mode=normal<CR> "),
	dashboard.button("r", Fau_vim.ui.History .. "  Recent files", "<CMD>Telescope oldfiles<CR>"),
	dashboard.button("t", Fau_vim.ui.FindText .. "  Find Text",   "<CMD>Telescope live_grep<CR>"),
	dashboard.button("c", Fau_vim.ui.Gear .. "  Configuration",   "<CMD>FauvimConfig<CR>"),
	dashboard.button("q", "Quit",   "<CMD>qa<CR>"),
}

local handle = io.popen("fortune")
if handle == nil then return end
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune
dashboard.config.opts.noautocmd = true
vim.cmd [[autocmd User AlphaReady echo 'ready']]


alpha.setup(dashboard.config)
