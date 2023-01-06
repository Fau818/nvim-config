-- =============================================
-- ========== Plugin Loading
-- =============================================
local whichkey = Fau_vim.load_plugin("which-key")
if whichkey == nil then return end



-- =============================================
-- ========== Initialization
-- =============================================
local opts = {
	n = { mode = "n", prefix = "", buffer = nil, silent = true, noremap = true, nowait = false },
	x = { mode = "x", prefix = "", buffer = nil, silent = true, noremap = true, nowait = false },
	o = { mode = "o", prefix = "", buffer = nil, silent = true, noremap = true, nowait = false },
	i = { mode = "i", prefix = "", buffer = nil, silent = true, noremap = true, nowait = false },
	t = { mode = "t", prefix = "", buffer = nil, silent = true, noremap = true, nowait = false },
}

local register = function(keymaps) for mode, keymap in pairs(keymaps) do whichkey.register(keymap, opts[mode]) end end

local load = function(name)
	local status, p_keymaps = pcall(require, "Fau.core.whichkey.settings." .. name)
	if not status then Fau_vim.notify("Fau which-key register: not found [" .. name .. "] keymap.") return end

	register(p_keymaps)
end



-- =============================================
-- ========== plugin settings
-- =============================================
load("basic")
load("telescope")
load("lsp")
load("gitsigns")
load("terminal")
load("code_runner")
