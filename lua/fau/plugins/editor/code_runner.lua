-- TODO: Refactor me!
---@type LazySpec
return {
  -- DESC: Easily run code in Neovim.
  ---@module "code_runner"
  "CRAG666/code_runner.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects", "CrStopHr" },
  keys = {
    { "<LEADER>r",  "<NOP>",                          desc = "Code Runner"               },
    { "<C-r>",      "<CMD>RunFile toggleterm<CR>",    desc = "Run File in Toggleterm"    },
    { "<LEADER>rt", "<CMD>RunFile term<CR>",          desc = "Run File in Terminal"      },
    { "<LEADER>rT", "<CMD>RunFile toggle<CR>",        desc = "Run File Toggle"           },
    { "<LEADER>rf", "<CMD>RunFile float<CR>",         desc = "Run File in Float"         },
    { "<LEADER>rc", "<CMD>RunClose<CR>",              desc = "Run Close"                 },
    { "<LEADER>rp", "<CMD>RunProject toggleterm<CR>", desc = "Run Project in Toggleterm" },
  },

  opts = {
    mode = "toggleterm",  -- default mode
    focus = true,  -- Focus on runner window (only works on toggle, term and tab mode)
    startinsert = true,

    term = { position = "belowright", size = 8 },
    float = { border = "double", width = 0.6, x = 0.5, y = 0.5, border_hl = "FloatBorder" },
    better_term = nil,

    before_run_filetype = function() vim.cmd.update() end,

    filetype = {
      -- $file               : file path to currend file opened
      -- $fileName           : file name to curren file opened
      -- $fileNameWithoutExt : file without extension file opened
      -- $dir                : path of directory to file opened
      -- $end                : finish the command

      -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
      python = [[PYTHONPATH=$(pwd):${PYTHONPATH} python3 $dir/$fileName]],
      c      = {
        "cd $dir &&",
        "clang $fileName -o $fileNameWithoutExt -w &&",
        "./$fileNameWithoutExt",
      },
      cpp    = {
        "cd $dir && clang++",
        (os.getenv("CPPFLAGS_FAU") or ""),
        "$fileName -o $fileNameWithoutExt -w && ./$fileNameWithoutExt",
      },
      lua = [[luajit $dir/$fileName]]
      -- typescript = "deno run",
      -- rust = "cd $dir && rustc $fileName && $dir/$fileNameWithoutExt"
    },

    project = {
      -- name        : Project name
      -- description : Project description
      -- file_name   : Filename relative to root path
      -- command     : Command to run the project. It is possible to use variables exactly the same as we would in `CRFiletype`

      -- ["~/Documents/Fau/Projects/Python_Projects/Iris_Recognition.nosync"] = {
      --  name = "Iris Recognition",
      --  description = "Scientific Research",
      -- },
      -- ["~/demo_project"] = {
      --   name = "test project",
      --   description = "test",
      --   file_name = "test.py",
      -- }
    },


    -- NOTE: If use json to config code_runner, uncomment the following codes.
    -- filetype_path = vim.fn.expand(fvim.nvim_config_path .. "/code_runner/filetype.json"),
    -- project_path  = vim.fn.expand(fvim.nvim_config_path .. "/code_runner/project.json"),

    hot_reload = false,
  }
}
