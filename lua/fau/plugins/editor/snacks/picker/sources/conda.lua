local conda = require("fau.functions.conda")
local preset = require("fau.plugins.editor.snacks.picker.sources.preset")

local M = {}


---@type snacks.picker.Config
M.conda_picker = {
  title = "Conda Environment",

  finder = function(opts, ctx) return conda.get_conda_envs() end,

  format = function(item, picker)
    return {
      { string.format("%-12s", item.name), "SnacksPickerFile" },
      { item.path, "SnacksPickerDir" },
    }
  end,

  actions = {
    confirm = function(picker, item)
      local venv_name = os.getenv("CONDA_DEFAULT_ENV")
      local deactivating = venv_name == item.name
      if deactivating then conda.deactivate(item) else conda.activate(item) end
      picker:close()

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
        if client.settings.python then
          local root_dir = client.config.root_dir
          -- Deactivating re-runs the decision `before_init` made, now without this env in the way.
          local python_path = vim.fs.joinpath(item.path, "bin/python")
          if deactivating then python_path = root_dir and fvim.utils.resolve_python_path(root_dir) end
          fvim.lsp.reconfigure_python_path(client, python_path)
        end
      end
    end,
  },

  layout = { preset = "vscode", layout = { height = #conda.get_conda_envs() + 3, max_height = 25 } },
  on_show = preset.normal_mode,
}


return M
