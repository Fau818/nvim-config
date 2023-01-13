-- =============================================
-- ========== Directly Called Funtions
-- =============================================
-- -----------------------------------
-- -------- load plugin function
-- -----------------------------------
---@param plugin any
---@return any result
Fau_vim.load_plugin = function(plugin)
	local status_ok, instance = pcall(require, plugin)
	if not status_ok then
		---@diagnostic disable-next-line: param-type-mismatch
		vim.notify(plugin .. " not found!", "ERROR", { title = "Fau: Plugin Not Found" })
		return nil
	end
	return instance
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
	Fau_vim.notify("not found formatter, use auto indent!", vim.log.levels.INFO, { render = "minimal", timeout = 0 })
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
}
