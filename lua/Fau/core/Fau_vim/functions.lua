-- =============================================
-- ========== Directly Called Funtions
-- =============================================
-- -----------------------------------
-- -------- show no plugin message
-- -----------------------------------
---@param plugin string
Fau_vim.load_plugin_error = function(plugin)
	vim.notify(plugin .. " not found!", "ERROR", { title = "Fau: Plugin Not Found" })
end


-- -----------------------------------
-- -------- show lua table
-- -----------------------------------
Fau_vim.table2string = function(...)
	local objects = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		table.insert(objects, vim.inspect(v))
	end

	return table.concat(objects, "\n")
end


Fau_vim.show = function(...)
	local objects = {}
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		table.insert(objects, vim.inspect(v))
	end

	print(table.concat(objects, "\n"))
end



-- =============================================
-- ========== Private Functions
-- =============================================
local function auto_indent()
	local mode = vim.api.nvim_get_mode()["mode"]
	if mode == "v" or mode == "V" then -- indent selected
		vim.api.nvim_input("gv=")
	else -- indent all buffer
		local save_cursor = vim.fn.getpos(".")
		vim.api.nvim_command("normal! gg=G")
		vim.fn.setpos(".", save_cursor)
	end
	Fau_vim.functions.remove_blank_lines_and_spaces()
	vim.api.nvim_command("nohlsearch")
	Fau_vim.notify("not found formatter, use auto indent!", vim.log.levels.INFO, { render = "minimal" })
end

---set file indent
---@param indent_type "tab"|"space"
---@param indent_width 2|4|8
local function set_indent(indent_type, indent_width)
	local for_tab = indent_type == "tab" and " noexpandtab" or " expandtab"
	local command = "setlocal tabstop=" .. indent_width ..
		" shiftwidth=" .. indent_width ..
		" softtabstop=" .. indent_width .. for_tab

	vim.api.nvim_command(command)
end


---@return Fau_vim_file_indent
local function get_indent()
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	if Fau_vim.file_indent[filetype] == nil then -- use default indent
		Fau_vim.file_indent[filetype] = {
			indent_type  = Fau_vim.file_indent.default.indent_type,
			indent_width = Fau_vim.file_indent.default.indent_width
		}
	end

	return Fau_vim.file_indent[filetype]
end




-- =============================================
-- ========== Fau_vim.functions
-- =============================================
return {
	-- -----------------------------------
	-- -------- Trim Blank Lines and Spaces
	-- -----------------------------------
	remove_blank_lines_and_spaces = function()
		local save_cursor = vim.fn.getpos(".")
		vim.api.nvim_command([[silent! %s#\($\n\s*\)\+\%$##]])
		vim.api.nvim_command([[silent! %s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,


	-- -----------------------------------
	-- -------- Automatically Format
	-- -----------------------------------
	format = function()
		local bufnr = vim.api.nvim_get_current_buf()
		local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

		-- specific filetype
		if filetype == "python" then return auto_indent()
		elseif filetype == "c" or filetype == "cpp" then return auto_indent()
		end

		-- by lsp capability
		local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
		clients = vim.tbl_filter(function(client) return client.supports_method("textDocument/formatting") end, clients)

		if #clients == 0 then auto_indent()
		else vim.lsp.buf.format() end
	end,


	-- -----------------------------------
	-- -------- Open Terminal
	-- -----------------------------------
	terminal = {}, -- Implement in terminal.lua file


	-- -----------------------------------
	-- -------- Auto LSP
	-- -----------------------------------
	initialize_vim = nil,   -- Implement in autocmd.lua file
	set_client_by_ft = nil, -- Implement in lspconfig.lua file


	-- -----------------------------------
	-- -------- Auto File Indent
	-- -----------------------------------
	set_indent = function()
		local file_indent = get_indent()
		set_indent(file_indent.indent_type, file_indent.indent_width)
	end,

	---Cycle indent in [tab2, space2, space4]
	cycle_indent = function()
		local filetype = vim.api.nvim_buf_get_option(0, "filetype")
		local file_indent = get_indent()

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

		Fau_vim.functions.set_indent()
		vim.api.nvim_command("retab!")
	end
}
