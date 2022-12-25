-- =============================================
-- ========== plugin Loading
-- =============================================
local code_runner = Fau_vim.load_plugin("code_runner")
if code_runner == nil then return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
	mode = "term", -- default mode
	focus = true,  -- Focus on runner window (only works on toggle, term and tab mode)
	startinsert = true,

	term = {
		position = "belowright",
		size = 8,
	},

	float = {
		-- Key that close the code_runner floating window
		close_key = "<ESC>",
		-- Window border (see ':h nvim_open_win')
		border = "double",

		-- Num from `0 - 1` for measurements
		height = 0.6,
		width = 0.6,
		x = 0.5,
		y = 0.5,

		-- Highlight group for floating window/border (see ':h winhl')
		border_hl = "FloatBorder",
		float_hl = "Normal",

		-- Transparency (see ':h winblend')
		blend = 0,
	},


	-- -----------------------------------
	-- -------- Configure by Lua
	-- -----------------------------------
	filetype = {
		-- $file               -- file path to currend file opened
		-- $fileName           -- file name to curren file opened
		-- $fileNameWithoutExt -- file without extension file opened
		-- $dir                -- path of directory to file opened

		-- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
		python = "export PYTHONPATH=$(pwd) && python3 $dir/$fileName",
		c = "cd $dir && clang $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
		cpp = "cd $dir && clang $fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
		-- typescript = "deno run",
		-- rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
	},

	project = {
		-- name: Project name
		-- description: Project description
		-- file_name: Filename relative to root path
		-- command: Command to run the project. It is possible to use variables exactly the same as we would in `CRFiletype`

		-- ["~/Documents/Fau/Projects/PyCharm_Projects/Iris_Recognition.nosync"] = {
		-- 	name = "Iris Recognition",
		-- 	description = "Scientific Research",
		-- },
	},


	-- -----------------------------------
	-- -------- Configure by json
	-- -----------------------------------
	-- filetype_path = vim.fn.expand('~/.config/nvim/code_runner.json'),
	-- project_path  = vim.fn.expand('~/.config/nvim/project_manager.json'),
}


code_runner.setup(config)