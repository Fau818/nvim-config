local conda = require("fau.functions.conda")
local preset = require("fau.plugins.editor.snacks.picker.sources.preset")

local M = {}


---@type snacks.picker.Config
M.conda_picker = {
  title = "Conda Environment",

  finder = function(opts, ctx) return conda.get_conda_envs() end,

  format = function(item, picker)
    ---@cast item fvim.CondaEnv
    return {
      { string.format("%-12s", item.name), "SnacksPickerFile" },
      { item.path, "SnacksPickerDir" },
    }
  end,

  actions = {
    confirm = function(picker, item)
      ---@cast item fvim.CondaEnv
      local venv_name = os.getenv("CONDA_DEFAULT_ENV")
      local deactivating = venv_name == item.name
      if deactivating then conda.deactivate(item) else conda.activate(item) end
      picker:close()

      fvim.python.resync_path()
    end,
  },

  layout = { preset = "vscode", layout = { height = #conda.get_conda_envs() + 3, max_height = 25 } },
  on_show = preset.normal_mode,
}


return M
