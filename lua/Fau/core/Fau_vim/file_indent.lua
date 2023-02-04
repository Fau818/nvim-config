---@class Fau_vim_file_indent
---@field indent_type "tab"|"space"
---@field indent_width 2|4|8


---@type Fau_vim_file_indent
local default_config = {
	indent_type = "tab",
	indent_width = 2,
}


---@type table<string, Fau_vim_file_indent>
local M = {
	default = default_config,

	-- c = default_config, cpp = default_config,
	--
	-- python = default_config,
	--
	-- lua = default_config,
}


return M
