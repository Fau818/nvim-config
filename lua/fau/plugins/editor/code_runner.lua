---@type LazySpec
return {
  -- DESC: Easily run code in Neovim.
  ---@module "code_runner"
  "CRAG666/code_runner.nvim",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "RunCode", "RunFile", "RunProject", "RunClose", "CRFiletype", "CRProjects", "CrStopHr" },
  keys = {
    { "<C-r>", function() require("code_runner").run_code() end, desc = "Run Code" },
    { "<LEADER>r", "<NOP>", desc = "Code Runner" },

    { "<LEADER>rf", function() require("code_runner").run_filetype("float") end, desc = "Run File in Float" },
    { "<LEADER>rt", function() require("code_runner").run_filetype("toggleterm") end, desc = "Run File in Terminal" },
    { "<LEADER>rp", function() require("code_runner").run_project("toggleterm") end, desc = "Run Project in Toggleterm" },

    -- { "<LEADER>rc", function() require("code_runner").run_close() end, desc = "Run Close" },
  },

  opts = {
    mode = "toggleterm",
    focus = true,
    startinsert = true,

    term = { position = "belowright", size = 8 },
    float = { border = "double", width = 0.6, x = 0.5, y = 0.5, border_hl = "FloatBorder" },
    better_term = nil,

    before_run_filetype = function() vim.cmd.update() end,

    filetype = {
      -- $file               : path to current open file (e.g. /home/user/current_dir/current_file.ext)
      -- $fileName           : filename of current open file (e.g. current_file.ext)
      -- $fileNameWithoutExt : filename without extension of current file (e.g. current_file)
      -- $dir                : path to directory of current open file (e.g. /home/user/current_dir)
      -- $end                : finish the command (it is useful for commands that do not require final autocompletion)

      -- java = "cd $dir && javac $fileName && java $fileNameWithoutExt",
      python = function()
        -- local use_uv = vim.fn.executable("uv") == 1 and vim.uv.fs_stat("uv.lock") ~= nil
        local use_uv = vim.fn.executable("uv") == 1
        local cmd = use_uv and "uv run" or "python3"
        return { cmd, "$file" }
      end,
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
    },

    -- NOTE: If use json to config code_runner, uncomment the following codes.
    -- filetype_path = string.format("%s/configuration/code_runner/filetype.json", fvim.nvim_config_path),
    -- project_path =  string.format("%s/configuration/code_runner/project.json", fvim.nvim_config_path),

    hot_reload = false,
  }
}
