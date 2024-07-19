-- =============================================
-- ========== plugin Loading
-- =============================================
local code_runner_ok, code_runner = pcall(require, "code_runner")
if not code_runner_ok then Fau_vim.load_plugin_error("code_runner") return end



-- =============================================
-- ========== Configuration
-- =============================================
local config = {
  mode  = "term",  -- default mode
  focus = true,    -- Focus on runner window (only works on toggle, term and tab mode)
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

  before_run_filetype = function() vim.cmd(":update") end,


  -- -----------------------------------
  -- -------- Configure by Lua
  -- -----------------------------------
  filetype = {
    -- $file               -- file path to currend file opened
    -- $fileName           -- file name to curren file opened
    -- $fileNameWithoutExt -- file without extension file opened
    -- $dir                -- path of directory to file opened

    -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
    python = [[PYTHONPATH=$(pwd):${PYTHONPATH} python3 $dir/$fileName]],
    c   = "cd $dir && clang $fileName -o $fileNameWithoutExt -w && ./$fileNameWithoutExt",
    cpp = "cd $dir && clang++ " .. (os.getenv("CPPFLAGS_FAU") or "") .. " $fileName -o $fileNameWithoutExt -w && ./$fileNameWithoutExt",
    -- typescript = "deno run",
    -- rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
  },

  project = {
    -- name: Project name
    -- description: Project description
    -- file_name: Filename relative to root path
    -- command: Command to run the project. It is possible to use variables exactly the same as we would in `CRFiletype`

    -- ["~/Documents/Fau/Projects/Python_Projects/Iris_Recognition.nosync"] = {
    --  name = "Iris Recognition",
    --  description = "Scientific Research",
    -- },
    ["~/Documents/Fau/Projects/Python_Projects/Flask_Book"] = {
      name = "Flask_Book",
      description = "ZYW Book Manager",
      file_name = "app.py",
      -- command = "export PYTHONPATH=$(pwd) && python"
    },
    -- ["~/demo_project"] = {
    --   name = "test project",
    --   description = "test",
    --   file_name = "test.py",
    -- }
  },


  -- -----------------------------------
  -- -------- Configure by json
  -- -----------------------------------
  -- filetype_path = vim.fn.expand(Fau_vim.config_path .. "/code_runner/filetype.json"),
  -- project_path  = vim.fn.expand(Fau_vim.config_path .. "/code_runner/project.json"),
}


code_runner.setup(config)
