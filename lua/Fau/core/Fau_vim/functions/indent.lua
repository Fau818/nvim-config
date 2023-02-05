return {
	---use specific indent setting for a filetype
	---@param indent_type "tab"|"space"
	---@param indent_width 2|4|8
	__use_indent = function(indent_type, indent_width)
		local for_tab = indent_type == "tab" and " noexpandtab" or " expandtab"
		local command = "setlocal tabstop=" .. indent_width ..
				" shiftwidth=" .. indent_width ..
				" softtabstop=" .. indent_width .. for_tab

		vim.api.nvim_command(command)
	end,


	---@return Fau_vim_file_indent
	__get_indent = function()
		local filetype = vim.api.nvim_buf_get_option(0, "filetype")

		if Fau_vim.file_indent[filetype] == nil then -- use default indent
			Fau_vim.file_indent[filetype] = {
				indent_type  = Fau_vim.file_indent.default.indent_type,
				indent_width = Fau_vim.file_indent.default.indent_width
			}
		end

		return Fau_vim.file_indent[filetype]
	end,


	set_indent = function()
		local file_indent = Fau_vim.functions.indent.__get_indent()
		Fau_vim.functions.indent.__use_indent(file_indent.indent_type, file_indent.indent_width)
	end,


	---Cycle indent in [tab2, space2, space4]
	cycle_indent = function()
		local filetype    = vim.api.nvim_buf_get_option(0, "filetype")
		local file_indent = Fau_vim.functions.indent.__get_indent()

		if file_indent.indent_type == "tab" then
			Fau_vim.file_indent[filetype].indent_type = "space"
		elseif file_indent.indent_width == 2 then
			Fau_vim.file_indent[filetype].indent_width = 4
		else
			Fau_vim.file_indent[filetype] = {
				indent_type  = Fau_vim.file_indent.default.indent_type,
				indent_width = Fau_vim.file_indent.default.indent_width
			}
		end

		Fau_vim.functions.indent.set_indent()
		vim.api.nvim_command("retab!")
	end
}
