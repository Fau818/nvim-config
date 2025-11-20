local preset = require("fau.plugins.editor.snacks.picker.sources.preset")


---Get conda installation path.
---@return string conda_path
local function get_conda_path()
  local conda_path_list = {
    -- Universe
    os.getenv("CONDA_ROOT"),
    -- macOS
    "/usr/local/Caskroom/miniconda/base",
    "/opt/homebrew/Caskroom/miniconda/base",
    -- Linux
    "/usr/local/miniconda3",
    vim.fn.expand("$HOME/miniconda3"),
    vim.fn.expand("$HOME/.miniconda3"),
    vim.fn.expand("$HOME/.local/share/miniconda3"),
  }

  for _, path in ipairs(conda_path_list) do
    if path and vim.fn.isdirectory(path) == 1 then
      if vim.fn.executable(path .. "/bin/conda") == 1 then return path end
    end
  end

  vim.notify("Conda path not found.", vim.log.levels.WARN)
  assert(false, "Conda path not found. Please install Miniconda or Anaconda.")
  return ""
end


local _conda_env_list = nil
---Get list of conda environments.
---@return snacks.picker.Item[]
local function get_conda_envs()
  if not _conda_env_list then
    local conda_path = get_conda_path()
    local conda_envs_path = conda_path .. "/envs"

    if vim.fn.isdirectory(conda_envs_path) ~= 1 then
      vim.notify("Conda envs directory not found: " .. conda_envs_path, vim.log.levels.WARN)
      return {}
    end

    local env_list = {}
    table.insert(env_list, { name = "base", path = conda_path, idx = 1 })

    local file_list = vim.fn.readdir(conda_envs_path)
    for _, file in ipairs(file_list) do
      if file:sub(1,1) ~= "." then  -- Ignore hidden files
        local full_path = string.format("%s/%s", conda_envs_path, file)
        if vim.fn.isdirectory(full_path) == 1 then
          table.insert(env_list, {
            name = file,
            path = full_path,
            idx = #env_list + 1,
          })
        end
      end
    end

    _conda_env_list = env_list
  end

  return _conda_env_list
end


---Activate conda environment.
---@param item snacks.picker.Item
local function conda_avtivate(item)
  vim.notify("Activating conda environment: " .. item.name, vim.log.levels.INFO)

  vim.fn.setenv("CONDA_DEFAULT_ENV", item.name)
  vim.fn.setenv("CONDA_PREFIX",      item.path)
  vim.fn.setenv("CONDA_SHLVL",       "1")
  vim.env.PATH = string.format("%s/bin:%s", item.path, vim.env.PATH)
end


local function conda_deactivate(item)
  vim.notify("Deactivating conda environment.", vim.log.levels.INFO)

  ---@diagnostic disable-next-line: param-type-mismatch
  vim.fn.setenv("CONDA_DEFAULT_ENV", nil)
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.fn.setenv("CONDA_PREFIX",      nil)
  vim.fn.setenv("CONDA_SHLVL",       "0")
  vim.env.PATH = vim.env.PATH:gsub(string.format("%s/bin:", item.path), "")
end



return {
  ---@type snacks.picker.Config
  conda_picker = {
    title = "Conda Environment",

    finder = function(opts, ctx) return get_conda_envs() end,

    format = function(item, picker)
      return {
        { string.format("%-12s", item.name), "SnacksPickerFile" },
        { item.path, "SnacksPickerDir" },
      }
    end,

    actions = {
      confirm = function(picker, item)
        local venv_name = os.getenv("CONDA_DEFAULT_ENV")
        if venv_name == item.name then conda_deactivate(item)
        else conda_avtivate(item)
        end
        picker:close()

        fvim.lsp.restart_lsp()
      end,
    },

    layout = { preset = "vscode", layout = { height = #get_conda_envs() + 3, max_height = 25 } },
    on_show = preset.normal_mode,
  },
}
